# Contributing

Thanks for your interest in garbro-cli.

## Scope

garbro-cli is the **command-line distribution** of [GARbro](https://github.com/morkt/GARbro).

- **CLI behaviour, packaging, build, docs** → contribute here.
- **Archive/format engine** (new formats, decryption, decoding bugs) → these live in `GameRes` / `ArcFormats`, which are shared with upstream. Fixes there are best sent to [morkt/GARbro](https://github.com/morkt/GARbro) so the whole ecosystem benefits; we periodically merge upstream.

## Reporting issues

Open an issue with: OS version, garbro-cli version (the banner prints it), the exact command line, and the full output. For archive-specific problems, mention the game/engine and, if possible, attach a small reproducing sample you are allowed to share.

## Development

```bash
git clone https://github.com/Alex123666tw/garbro-cli.git
cd garbro-cli
nuget restore GARbro.sln
msbuild ArcFormats/ArcFormats.csproj /p:Configuration=Release
msbuild Console/GARbro.Console.csproj /p:Configuration=Release
```

Requires MSBuild with the **.NET desktop build tools** (VS Build Tools 2022, `ManagedDesktop` workload). Output lands in `bin/Release`.

## Pull requests

- Keep changes focused; one logical change per commit.
- Follow [Conventional Commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`, `build:`, `docs:` …).
- Match the surrounding code style (the CLI sources use tabs, as in the original).
- Describe what you changed and how you verified it.

## License of contributions

By contributing you agree your changes are licensed under the project's [MIT License](LICENSE).
