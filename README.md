# GARbro-cli

> A command-line build of **GARbro** for listing and extracting files from visual-novel / game archives — designed to be driven as a subprocess by other tools.

![license](https://img.shields.io/badge/license-MIT-blue.svg)
![platform](https://img.shields.io/badge/platform-Windows-0078d6.svg)
![.NET](https://img.shields.io/badge/.NET%20Framework-4.6%2B-512bd4.svg)
![release](https://img.shields.io/github/v/release/Alex123666tw/garbro-cli?sort=semver)

**English** | [繁體中文](#繁體中文)

## Overview

garbro-cli is a thin, automation-friendly command-line front end for [GARbro](https://github.com/morkt/GARbro), the de-facto archive browser for Japanese visual-novel engines. It identifies, lists and extracts entries from hundreds of game archive formats, and is hardened to run unattended — no prompts, clean stdout, real exit codes — so other programs can call it to unpack archives.

Please read the [License](#license) and [Disclaimer](#disclaimer) before use.

## Features

- **Extract & list** any GARbro-supported archive straight from the shell.
- **Subprocess-safe**: non-interactive overwrite, real exit codes, data on stdout / diagnostics on stderr.
- **Filter** entries by regex (`-f`) and pick an output directory (`-o`).
- **Self-contained**: prebuilt Windows zip — unzip and run, nothing to install.
- **Byte-exact**: extraction verified identical (SHA-256) to reference tooling.

## Preview

```text
> GARbro.Console.exe l data.pac
     Offset      Size  Name
 ----------  --------  --------------------------------------
 [0000AD94]    955712  POINT.DAT
 [006A1D90]   1000148  SCRIPT.SRC
 [0020CA5A]   7954532  TEXT.DAT
 ----------  --------  --------------------------------------
                       160 files
```

## Tech stack

| Component | Role | License |
|---|---|---|
| [C# / .NET Framework 4.6](https://dotnet.microsoft.com/) | language & runtime target | — |
| [GARbro](https://github.com/morkt/GARbro) — GameRes, ArcFormats | archive detection & extraction engine | MIT (default build is MIT-clean; one GPLv2 file is opt-in only — see [License](#license)) |
| [NAudio](https://github.com/naudio/NAudio) · [SharpZipLib](https://github.com/icsharpcode/SharpZipLib) · [NVorbis](https://github.com/NVorbis/NVorbis) | audio / compression codecs used by formats | MIT |

## Quick start

### Requirements

- Windows 10 / 11 (x64)
- .NET Framework 4.6 or later (preinstalled on modern Windows)

### Download (recommended)

1. Grab the latest `garbro-cli-*-win.zip` from [Releases](https://github.com/Alex123666tw/garbro-cli/releases).
2. Unzip anywhere.
3. Run `GARbro.Console.exe` from that folder.

### Build from source

```bash
git clone https://github.com/Alex123666tw/garbro-cli.git
cd garbro-cli
# needs MSBuild + the .NET desktop build tools (VS Build Tools 2022, ManagedDesktop workload)
nuget restore GARbro.sln
msbuild ArcFormats/ArcFormats.csproj /p:Configuration=Release
msbuild Console/GARbro.Console.csproj /p:Configuration=Release
# output in bin/Release
```

## Usage

```text
GARbro.Console.exe <command> [switches] <archive>
```

| Command | Meaning |
|---|---|
| `i` | identify archive format |
| `f` | list supported formats |
| `l` | list archive contents |
| `x` | extract |

| Switch | Meaning |
|---|---|
| `-o <dir>` | output directory for extraction |
| `-f <regex>` | only process entries whose name matches the regular expression |
| `-y` / `-s` / `-r` | on existing files: overwrite / skip / rename (overwrite is automatic when non-interactive) |
| `-q` | quiet — banner & progress go to stderr only |

Example — extract three entries from a SoftPal archive into `out/`:

```bash
GARbro.Console.exe x -y -q -f "SCRIPT\.SRC|TEXT\.DAT|POINT\.DAT" -o out data.pac
```

The exit code is `0` on success and non-zero on any error or skipped file. `i` / `l` output goes to **stdout**; banner, progress, warnings and errors go to **stderr** — so the output is safe to parse from a parent process.

## Roadmap

- GitHub Actions CI for reproducible, tag-triggered releases.
- Documented, regression-tested coverage for more engines.
- Possible .NET (Core) port for cross-platform use.

*(Direction, not a committed schedule.)*

## Contributing

Pull requests are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md). Fixes to the underlying format engine are best sent upstream to [morkt/GARbro](https://github.com/morkt/GARbro).

## Security

Please report vulnerabilities privately as described in [SECURITY.md](SECURITY.md). Do **not** open a public issue for security problems.

## License

The CLI packaging and all code added by this fork are released under the **MIT License** — see [LICENSE](LICENSE). garbro-cli is a fork of GARbro (© 2014–2020 morkt, MIT).

The prebuilt release ships `ArcFormats.dll` built in the **default configuration, which is MIT-clean** — it contains no GPLv2 code. Blowfish has been reimplemented from the public-domain reference, and the one GPLv2 file (`ArcFormats/KogadoCocotte.cs`, morkt's C# port of GPLv2 code by juicy.gt) is **excluded from the default build** and only compiled in when the `INCLUDE_GPL` constant is defined. That file is kept in the repository for an optional opt-in build; `licenses/GPL-2.0.txt` is retained for that case. An `INCLUDE_GPL` build (which re-enables Kogado "Cocotte" compression and older ShiinaRio WARC RNG decompression, which share that file's range coder) produces a combined work governed by GPLv2. Either way, calling `GARbro.Console.exe` as a separate process (arm's-length) does **not** place the calling program under the GPL. See [NOTICE](NOTICE) for the full disclosure and attribution.

## Open-source credits

- [GARbro](https://github.com/morkt/GARbro) by morkt — the engine this builds on
- Command-line groundwork by [Bioruebe (PR #394)](https://github.com/morkt/GARbro/pull/394)
- NAudio · SharpZipLib · NVorbis (Concentus · System.Data.SQLite are GUI/Experimental only, not in the CLI release)

## Disclaimer

This tool extracts data from files **you already own**. It is intended for translation, modding, accessibility and preservation. You are responsible for complying with each game's EULA and with applicable copyright law; do not use it to redistribute copyrighted assets. The software is provided "as is", without warranty, and the authors accept no liability for how it is used.

---

## 繁體中文

[English](#garbro-cli) | **繁體中文**

> **GARbro** 的命令列版本,用來列出與解開視覺小說 / 遊戲封包檔 —— 專為「被其他工具當子程序呼叫」而設計。

### 專案簡介

garbro-cli 是 [GARbro](https://github.com/morkt/GARbro)(日系視覺小說引擎封包瀏覽器的事實標準)的輕量、自動化友善命令列前端。它能辨識、列出並解開數百種遊戲封包格式,且經過硬化可無人值守執行 —— 不跳互動提示、stdout 乾淨、回傳真實 exit code —— 讓其他程式能呼叫它來拆封包。

使用前請先讀文末的 [授權](#授權) 與 [免責聲明](#免責聲明)。

### 功能特色

- **解開與列出**任何 GARbro 支援的封包,直接在命令列操作。
- **子程序安全**:免互動覆寫、真實 exit code、資料走 stdout / 診斷走 stderr。
- **正規式過濾**(`-f`)+ 指定輸出夾(`-o`)。
- **免安裝**:預編譯 Windows zip,解壓即用。
- **位元組精確**:解出結果經 SHA-256 驗證與參考工具一致。

### 預覽

```text
> GARbro.Console.exe l data.pac
     Offset      Size  Name
 ----------  --------  --------------------------------------
 [0000AD94]    955712  POINT.DAT
 [006A1D90]   1000148  SCRIPT.SRC
 [0020CA5A]   7954532  TEXT.DAT
 ----------  --------  --------------------------------------
                       160 files
```

### 技術棧

| 套件 | 用途 | 授權 |
|---|---|---|
| [C# / .NET Framework 4.6](https://dotnet.microsoft.com/) | 程式語言與執行環境目標 | — |
| [GARbro](https://github.com/morkt/GARbro) — GameRes, ArcFormats | 封包辨識與解包引擎 | MIT(預設 build 為 MIT-clean;一個 GPLv2 檔僅選用 build 才編入 —— 見 [授權](#授權)) |
| [NAudio](https://github.com/naudio/NAudio) · [SharpZipLib](https://github.com/icsharpcode/SharpZipLib) · [NVorbis](https://github.com/NVorbis/NVorbis) | 格式用到的音訊 / 壓縮編解碼 | MIT |

### 快速開始

#### 環境需求

- Windows 10 / 11(x64)
- .NET Framework 4.6 以上(現代 Windows 內建)

#### 下載(建議)

1. 到 [Releases](https://github.com/Alex123666tw/garbro-cli/releases) 取得最新 `garbro-cli-*-win.zip`。
2. 解壓到任意位置。
3. 在該資料夾執行 `GARbro.Console.exe`。

#### 從原始碼建構

```bash
git clone https://github.com/Alex123666tw/garbro-cli.git
cd garbro-cli
# 需要 MSBuild + .NET desktop build tools(VS Build Tools 2022,ManagedDesktop workload)
nuget restore GARbro.sln
msbuild ArcFormats/ArcFormats.csproj /p:Configuration=Release
msbuild Console/GARbro.Console.csproj /p:Configuration=Release
# 產物在 bin/Release
```

### 使用方式

```text
GARbro.Console.exe <command> [switches] <archive>
```

| 指令 | 意義 |
|---|---|
| `i` | 辨識封包格式 |
| `f` | 列出支援的格式 |
| `l` | 列出封包內容 |
| `x` | 解開 |

| 開關 | 意義 |
|---|---|
| `-o <dir>` | 解壓輸出資料夾 |
| `-f <regex>` | 只處理名稱符合正規式的項目 |
| `-y` / `-s` / `-r` | 遇到同名檔:覆寫 / 略過 / 改名(非互動時自動覆寫) |
| `-q` | 安靜模式 —— 橫幅與進度只走 stderr |

範例 —— 從 SoftPal 封包解三個檔到 `out/`:

```bash
GARbro.Console.exe x -y -q -f "SCRIPT\.SRC|TEXT\.DAT|POINT\.DAT" -o out data.pac
```

成功回傳 exit code `0`,任何錯誤或被略過的檔回傳非零。`i` / `l` 的資料走 **stdout**,橫幅 / 進度 / 警告 / 錯誤走 **stderr**,因此可安全地由父程序解析。

### 發展藍圖

- GitHub Actions CI,以打 tag 觸發可重現的自動發行 *(進行中)*。
- 為更多引擎建立有文件、有回歸測試的支援。
- 可能移植到 .NET(Core)以跨平台。

*(方向,非承諾時程。)*

### 貢獻

歡迎送 Pull Request —— 請先讀 [CONTRIBUTING.md](CONTRIBUTING.md)。底層格式引擎的修正,建議送回上游 [morkt/GARbro](https://github.com/morkt/GARbro)。

### 安全

安全性問題請依 [SECURITY.md](SECURITY.md) 私下回報,**請勿**開公開 issue。

### 授權

CLI 打包與本 fork 自加的所有程式碼以 **MIT License** 釋出 —— 見 [LICENSE](LICENSE)。garbro-cli 是 GARbro(© 2014–2020 morkt,MIT)的 fork。

發行包內含的 `ArcFormats.dll` 以**預設組態**建置,**為 MIT-clean** —— 不含任何 GPLv2 程式碼。Blowfish 已依 public-domain 參考實作重寫;唯一的 GPLv2 檔(`ArcFormats/KogadoCocotte.cs`,morkt 移植 juicy.gt 的 GPLv2 碼)在**預設 build 被排除**,僅在定義 `INCLUDE_GPL` 常數時才編入。該檔仍保留於倉庫供選用(opt-in)build;`licenses/GPL-2.0.txt` 亦為此保留。若以 `INCLUDE_GPL` 建置(此時會一併啟用 Kogado「Cocotte」壓縮與較舊 ShiinaRio WARC 的 RNG 解壓,二者共用該檔的 range coder),產出的 DLL 即成為受 GPLv2 規範的合併著作。無論何者,作為獨立子程序(arm's-length)呼叫 `GARbro.Console.exe` **都不會**使呼叫端受 GPL 拘束。完整揭露與致謝見 [NOTICE](NOTICE)。

### 開源專案

- [GARbro](https://github.com/morkt/GARbro) by morkt —— 本專案的底層引擎
- 命令列基礎由 [Bioruebe(PR #394)](https://github.com/morkt/GARbro/pull/394) 奠定
- NAudio · SharpZipLib · NVorbis(Concentus · System.Data.SQLite 僅 GUI/Experimental 用,不在 CLI 發行包內)

### 免責聲明

本工具用於解開**你已擁有**的檔案,目的為翻譯、模組、無障礙與保存。你必須自行遵守各遊戲的 EULA 與適用著作權法;請勿用於散布受著作權保護的素材。軟體依「現狀」提供、不負擔保責任,作者對使用後果不承擔任何責任。

---

*GARbro © 2014–2020 morkt. garbro-cli is an independent fork and is not affiliated with morkt or with any game publisher.*
