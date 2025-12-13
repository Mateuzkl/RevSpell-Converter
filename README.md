# RevSpell Converter (TFS RevScript)

RevSpell Converter reads `spells.xml` from a TFS-based server and generates modern RevScript Lua files. It preserves original combat logic when available and wraps it into a clean `Spell("instant"|"rune")` interface.

## Features

- XML parsing for `instant` and `rune` entries
- Duplicate words handling by merging vocations
- ID rules
  - Runes use XML `itemID`
  - Normal and conjuring spells use sequential IDs starting from a base (default `100`)
- Output structure
  - `saida/runes/{group}/...`
  - `saida/spells/{group}/...`
  - `saida/conjuring/...`
- Lua generation
  - Keeps original Lua combat on top and calls `combat:execute(creature, var)`
  - Adds required spell configs (group, id, name, words, level, mana, vocations)
  - Applies defaults when missing (`cooldown`, `groupCooldown`)
  - Reads XML flags like `needWeapon`, `casterTargetOrDirection`, `blockwalls`, `range`
- UI
  - Dark theme
  - Language toggle `PT/EN`
  - Full table with Words, Premium, Range, Cooldown, Script
  - Preview shows the original callback when available

## Requirements

- Windows
- Rust toolchain (stable)
- Tauri prerequisites for Windows (MSVC, WebView2)

## How to Run

### Using the build script (recommended)

- Portuguese: run `build_pt.bat`
- English: run `build_eng.bat`

Choose an option:
- Fast Build (Incremental)
- Clean and Build (Full)
- Run in DEV
- Test Release (.exe)
- Clean Only

### Manual

```bash
cd src-tauri
cargo tauri dev
# or
cargo tauri build
```

## Usage

1. Open the app
2. Click “Escolher Pasta” / “Choose Folder” and select the folder containing `spells.xml`
3. Set Base ID if needed (default `100`)
4. Click “Salvar RevScripts”
5. Generated files are placed under `saida/` following the folder rules above

## Contributing

Pull requests are welcome. Just make sure you are using English language.

Suggested areas to improve:
- Support for additional XML attributes and edge cases
- Better handling of special groups (custom, house, party)
- More validations for duplicate words and conflicting IDs
- Additional language strings (EN/PT) for footer and badges
- Optional export formats or script naming strategies

Workflow:
- Fork the repo
- Create a topic branch
- Add tests or reproducible examples when possible
- Open a PR describing the change and reasoning in English

## Notes

- Secrets or keys should never be committed
- Generated Lua scripts follow RevScript conventions
- The tool aims to minimize manual adjustments while staying compatible with legacy combat code
