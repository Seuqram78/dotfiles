# dotfiles

[chezmoi](https://chezmoi.io)-managed dotfiles and machine setup.

## Setup on a new machine

```sh
git clone https://github.com/Seuqram78/dotfiles.git ~/.local/share/chezmoi
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
chezmoi init
chezmoi apply --verbose
```

`chezmoi init` asks for the machine profile once and stores the answer in
`~/.config/chezmoi/chezmoi.toml`. `chezmoi apply` installs everything and
writes the dotfiles.

The `export PATH` line is only needed for the first `chezmoi` run — after
`apply`, the shell setup block in `~/.bashrc` puts `~/.local/bin` on `PATH`
permanently.

## What gets installed

| Source | Contents |
| --- | --- |
| `packages/apt.txt` | apt packages, plus the `git-core` PPA and build essentials |
| `Brewfile` | Homebrew formulae and casks |
| `packages/npm.txt` | global npm packages (via mise's Node) |
| `packages/uv.txt` | uv tools |
| `.chezmoi.toml.tmpl` | machine profile prompt |

Scripts, in run order:

| Script | Purpose |
| --- | --- |
| `run_before_10-install-packages` | apt, Homebrew, `brew bundle` |
| `run_after_15-configure-shell` | managed block in `~/.bashrc` |
| `run_after_20-mise-install` | mise runtimes, npm and uv packages |
| `run_after_25-configure-docker` | rootless Docker (no sudo needed to run containers) |
| `run_after_30-clone-nvim` | clones the Neovim config |
| `run_after_40-install-adguard` | AdGuard CLI (personal profile only) |

## Profiles

Everything above is the **base** — every machine gets it. A profile adds
machine-specific extras on top.

```
profiles/
  personal/
    Brewfile      # claude-code
```

A profile directory may contain any of `Brewfile`, `apt.txt`, `npm.txt`,
`uv.txt`. Missing files are skipped, so a profile only declares what it adds.
Scripts can be gated on the profile too — see
`run_after_40-install-adguard.sh.tmpl`.

Current profiles:

- **personal** — AdGuard CLI, Claude Code

### Adding to a profile

Edit the file under `profiles/<name>/`, commit, push, then run `chezmoi update`
on the machines that use it. Other machines pull the same commit and skip it.

### Changing a machine's profile

Edit `profile` in `~/.config/chezmoi/chezmoi.toml` and re-run `chezmoi apply`.

## Day to day

```sh
chezmoi update        # pull and apply
chezmoi diff          # what would change
chezmoi status        # pending changes; R means a script will re-run
chezmoi data          # resolved template data, including the profile
chezmoi managed       # every file this machine manages
chezmoi ignored       # what this machine skips
```

### Previewing another profile

Fake the profile in a throwaway config and point chezmoi at a throwaway
destination — nothing touches `$HOME`:

```sh
printf 'umask = 0o022\n[data]\n    profile = "work"\n' > /tmp/as-work.toml
chezmoi --config /tmp/as-work.toml --destination /tmp/preview managed
chezmoi --config /tmp/as-work.toml execute-template < run_after_40-install-adguard.sh.tmpl
```

## Notes

- Docker runs rootless as a systemd user service; `docker run hello-world`
  works without sudo.
- AdGuard CLI is not managed by a package manager. The script installs it once;
  update it with `adguard-cli update`. Activation (`adguard-cli activate`) is
  interactive and not automated.
