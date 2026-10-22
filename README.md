# mrinalraj/tap

Autopilot turns Linear and Jira tickets into Claude Code sessions on macOS.

Install the desktop app (macOS 13 or later):

```sh
brew install --cask mrinalraj/tap/autopilot
open -a Autopilot
```

The desktop beta is ad-hoc signed and not notarized. If macOS blocks the first launch,
after trying to open it use **System Settings → Privacy & Security → Open Anyway** and confirm.
See [release notes](https://github.com/mrinalraj/autopilot/releases/tag/v0.1.0-beta.9)
and [Apple's instructions](https://support.apple.com/en-us/102445).

When switching from the headless formula, stop and remove it before installing the cask:

```sh
brew services stop autopilot
brew uninstall --formula autopilot
```

Settings, tickets and Keychain sign-in are preserved. Closing the app window keeps the
worker running; Quit stops it. Quit before running `brew upgrade --cask autopilot`.

The headless formula remains available:

```sh
brew install --formula mrinalraj/tap/autopilot
```

| Package | Description |
|---|---|
| `autopilot` cask | Native app with a window, menu bar controls and bundled worker. |
| `autopilot` formula | CLI and background service. Formerly `linear-autopilot`. |
