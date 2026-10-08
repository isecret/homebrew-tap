#!/usr/bin/env python3
"""Update the cask from the newest published MemoEcho release, including betas."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import urllib.request

REPO = "isecret/MemoEcho"
ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="Verify without changing the cask")
    args = parser.parse_args()
    headers = {"Accept": "application/vnd.github+json", "User-Agent": "MemoEcho-Tap-Updater"}
    if token := os.environ.get("GH_TOKEN"):
        headers["Authorization"] = f"Bearer {token}"
    request = urllib.request.Request(f"https://api.github.com/repos/{REPO}/releases?per_page=100", headers=headers)
    with urllib.request.urlopen(request, timeout=60) as response:
        releases = [r for r in json.load(response) if not r["draft"] and r.get("published_at")]
    release = max(releases, key=lambda r: r["published_at"])
    tag = release["tag_name"]
    if not re.fullmatch(r"v\d+\.\d+\.\d+(?:-beta\.\d+)?", tag):
        raise RuntimeError("Unrecognized release tag; review the new release channel manually")
    version = tag[1:]
    name = f"MemoEcho-{tag}.dmg"
    asset = next(a for a in release["assets"] if a["name"] == name and a["state"] == "uploaded")
    url = f"https://github.com/{REPO}/releases/download/{tag}/{name}"
    if asset["browser_download_url"] != url:
        raise RuntimeError("Unexpected release asset URL")
    digest = hashlib.sha256()
    size = 0
    # Do not forward the GitHub API credential to the download host.
    with urllib.request.urlopen(urllib.request.Request(url, headers={"User-Agent": "MemoEcho-Tap-Updater"}), timeout=120) as response:
        while chunk := response.read(1024 * 1024):
            digest.update(chunk)
            size += len(chunk)
    checksum = digest.hexdigest()
    if size != asset["size"] or asset.get("digest") != f"sha256:{checksum}":
        raise RuntimeError("Release asset size or SHA-256 did not match GitHub metadata")
    cask = ROOT / "Casks/memoecho.rb"
    original = cask.read_text()
    updated, count = re.subn(r'^  version "[^"]+"$', f'  version "{version}"', original, flags=re.M)
    if count != 1:
        raise RuntimeError("Expected exactly one version stanza")
    updated, count = re.subn(r'^  sha256 "[a-f0-9]{64}"$', f'  sha256 "{checksum}"', updated, flags=re.M)
    if count != 1:
        raise RuntimeError("Expected exactly one SHA-256 stanza")
    if args.check and updated != original:
        raise SystemExit(f"Cask needs updating to {version}")
    if not args.check and updated != original:
        cask.write_text(updated)
    print(f"Verified MemoEcho {version}: {checksum} ({size} bytes)")


if __name__ == "__main__":
    main()
