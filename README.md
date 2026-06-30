# garbro-cli

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
| [GARbro](https://github.com/morkt/GARbro) — GameRes, ArcFormats | archive detection & extraction engine | MIT |
| [NAudio](https://github.com/naudio/NAudio) · [SharpZipLib](https://github.com/icsharpcode/SharpZipLib) · [NVorbis](https://github.com/NVorbis/NVorbis) · [Concentus](https://github.com/lostromb/concentus) | audio / compression codecs used by formats | MIT |
| [System.Data.SQLite](https://system.data.sqlite.org/) | format scheme database | Public Domain |

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

- GitHub Actions CI for reproducible, tag-triggered releases *(in progress)*.
- Documented, regression-tested coverage for more engines.
- Possible .NET (Core) port for cross-platform use.

*(Direction, not a committed schedule.)*

## Contributing

Pull requests are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md). Fixes to the underlying format engine are best sent upstream to [morkt/GARbro](https://github.com/morkt/GARbro).

## Security

Please report vulnerabilities privately as described in [SECURITY.md](SECURITY.md). Do **not** open a public issue for security problems.

## License

Released under the **MIT License** — see [LICENSE](LICENSE). garbro-cli is a fork of GARbro (© 2014–2020 morkt, MIT). Every bundled dependency is permissively licensed (MIT or public domain), so the combined distribution stays MIT-clean. Attribution for upstream and contributors is in [NOTICE](NOTICE).

## Open-source credits

- [GARbro](https://github.com/morkt/GARbro) by morkt — the engine this builds on
- Command-line groundwork by [Bioruebe (PR #394)](https://github.com/morkt/GARbro/pull/394)
- NAudio · SharpZipLib · NVorbis · Concentus · System.Data.SQLite

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
| [GARbro](https://github.com/morkt/GARbro) — GameRes, ArcFormats | 封包辨識與解包引擎 | MIT |
| [NAudio](https://github.com/naudio/NAudio) · [SharpZipLib](https://github.com/icsharpcode/SharpZipLib) · [NVorbis](https://github.com/NVorbis/NVorbis) · [Concentus](https://github.com/lostromb/concentus) | 格式用到的音訊 / 壓縮編解碼 | MIT |
| [System.Data.SQLite](https://system.data.sqlite.org/) | 格式 scheme 資料庫 | Public Domain |

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

以 **MIT License** 釋出 —— 見 [LICENSE](LICENSE)。garbro-cli 是 GARbro(© 2014–2020 morkt,MIT)的 fork。所有內含相依套件皆為寬鬆授權(MIT 或 public domain),因此整包散布維持 MIT 乾淨。上游與貢獻者的致謝見 [NOTICE](NOTICE)。

### 開源專案

- [GARbro](https://github.com/morkt/GARbro) by morkt —— 本專案的底層引擎
- 命令列基礎由 [Bioruebe(PR #394)](https://github.com/morkt/GARbro/pull/394) 奠定
- NAudio · SharpZipLib · NVorbis · Concentus · System.Data.SQLite

### 免責聲明

本工具用於解開**你已擁有**的檔案,目的為翻譯、模組、無障礙與保存。你必須自行遵守各遊戲的 EULA 與適用著作權法;請勿用於散布受著作權保護的素材。軟體依「現狀」提供、不負擔保責任,作者對使用後果不承擔任何責任。

---

*GARbro © 2014–2020 morkt. garbro-cli is an independent fork and is not affiliated with morkt or with any game publisher.*
