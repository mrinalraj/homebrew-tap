# mrinalraj/tap

Autopilot turns Linear and Jira tickets into Claude Code sessions on macOS.

Install the background service and open the browser interface:

```sh
brew install --formula mrinalraj/tap/autopilot
brew services start autopilot
autopilot open
```

Add the optional desktop app (macOS 13 or later) whenever you want:

```sh
brew install --cask mrinalraj/tap/autopilot
open -a Autopilot
```

The desktop beta is ad-hoc signed and not notarized. If macOS blocks the first launch,
after trying to open it use **System Settings → Privacy & Security → Open Anyway** and confirm.
See [public beta release notes](https://github.com/mrinalraj/autopilot/releases/tag/v0.1.0-beta.10)
and [Apple's instructions](https://support.apple.com/en-us/102445).

Keep the formula installed and running. Older formula users first upgrade and restart it:

```sh
brew update
brew upgrade --formula autopilot
brew services restart autopilot
```

The app connects to the compatible running service and leaves it running on Quit. Without a
running service, the app starts its bundled worker and stops that worker on Quit. Closing only
the window keeps the app running. Settings, tickets and Keychain sign-in are shared and preserved.

Existing beta.9 cask users: quit the app and upgrade it before adding the formula, so the old
cask-provided CLI link is removed first:

```sh
brew update
brew upgrade --cask autopilot
```

Then either reopen the app on its own, or install/start the formula before reopening the app.
Use a normal upgrade; the old beta.9 cask's `--zap` removes shared data. The new cask preserves
shared data on uninstall, even with `--zap`.

When both packages are installed, upgrade each separately using `--formula` and `--cask`.
The running daemon serves the dashboard, so upgrading only the app does not upgrade an
attached formula's web interface. Quit the app before cask upgrades.

| Package | Description |
|---|---|
| `autopilot` cask | Native app with a window, menu bar controls and bundled worker. |
| `autopilot` formula | CLI and background service. Formerly `linear-autopilot`. |
