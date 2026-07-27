# Fixed submission date (design)

## Problem

`nus-thesis.cls` currently derives two printed values from compile-time state
rather than a fixed, explicit value:

- The `submission-year` key (`src/nus-thesis.dtx:947-948`) defaults to
  `\number\year` — the year the document happens to be compiled in. It feeds
  the cover page (`nus-thesis.dtx:1436`) and the title page footer
  (`nus-thesis.dtx:1453`).
- `\DeclarationSignature` (`nus-thesis.dtx:1525`) hardcodes `\today` for the
  signature date on the declaration-of-originality page, with no way to
  override it.

If a thesis is recompiled after submission (e.g. to fix a typo in an
appendix, or to regenerate a personal archival copy), both values silently
change to "now" instead of staying pinned to the actual submission date.
This is surprising and makes the compiled output non-reproducible.

## Goals

- Let the user pin an explicit submission date once, and have it flow
  consistently to every place a date/year is printed.
- Preserve current behavior (today's date/year) for documents that don't set
  anything — this is an opt-in fix, not a breaking change.
- No new package dependencies; stay within expl3.

## Design

### 1. New `submission-date` key

Add a new key to the `nus-thesis` key-value interface (alongside the existing
`submission-year`, which is unchanged):

```
\ThesisSetup{
  ...
  submission-date = {2025-08-15},   % ISO YYYY-MM-DD
}
```

- Stored raw in a new token list `\l__nusthesis_submission_date_tl`.
- Its `.code:n` parses the ISO string (see §2) and, as a side effect:
  - sets `\l__thesis_year_tl` (the existing variable already consumed by the
    cover/title pages) to the parsed year.
  - sets a new token list `\l__nusthesis_declaration_date_tl` to a formatted
    display string, e.g. `15 August 2025`.
- `submission-year` remains fully independent and unchanged (`.initial:n =
  \number\year`). If both keys are set in the same `\ThesisSetup{}` call,
  ordinary l3keys left-to-right precedence applies to `\l__thesis_year_tl` —
  whichever key is processed later wins. This is documented, not specially
  arbitrated.
- If `submission-date` is never set:
  - `\l__thesis_year_tl` keeps its current default (`\number\year`).
  - `\l__nusthesis_declaration_date_tl` defaults to the unexpanded token
    `\today`, preserving exactly the current behavior.

### 2. Parsing & formatting

Pure expl3, no new dependencies:

```
\seq_set_split:Nnn \l_tmpa_seq { - } { <raw ISO string> }
```

yields three string items (year, month, day, e.g. `2025`, `08`, `15`).
Convert month and day to integers with `\int_eval:n` (this also strips
leading zeros, e.g. `08` → `8`). Map the month integer to a name via
`\int_case:nn` (`1` → `January`, …, `12` → `December`). Assemble the display
string as `<day> <month-name> <year>`.

No bespoke validation of the input format is added. A malformed value (not
`YYYY-MM-DD`) will surface as a LaTeX/expl3 error or garbled output at the
point of use — consistent with how `submission-year` and other config keys
in this class are already trusted without validation. This is a deliberate
YAGNI call: it's a one-shot config value set by the thesis author, not
untrusted input.

### 3. Usage sites

- **Cover page / title page** (`nus-thesis.dtx:1436`, `:1453`): **no code
  change**. Both already read `\l__thesis_year_tl`, which `submission-date`
  now populates when set.
- **`\DeclarationSignature`** (`nus-thesis.dtx:1525`): replace the literal
  `\today` with `\l__nusthesis_declaration_date_tl`.
- No public command signatures change. `\DeclarationSignature`,
  `\DeclarationPage`, `\maketitle`, `\coverpage`, `\titlepagefooter` all keep
  their existing interfaces — this is purely a data-source swap behind
  variables that already exist or are newly introduced internally.

### 4. Documentation & migration

- Extend the `submission-year` doc block
  (`nus-thesis.dtx:219-226`, `\begin{function}{submission-year}`) with a new
  `\begin{function}{submission-date}` entry: ISO format, that it overrides
  the derived year, that its formatted value replaces `\today` on the
  declaration page, and a recommendation to set it for final/archival
  recompiles (leave unset while actively drafting).
- Add `submission-date = {2025-08-15}` to `doc/PhD.tex` (the primary
  reference example) as the demonstrated usage pattern, with a comment
  noting that omitting the key preserves today's-date behavior.
- No backward-compatibility shims needed — purely additive. Existing
  documents that never set `submission-date` are unaffected.

### 5. Testing / verification

No automated test harness exists in this repo (`l3build doc`/`build` only
compile PDFs; there's no assertion-based test suite). Verification is
manual:

- Build `doc/PhD.tex` (or run `l3build doc`) with `submission-date` unset —
  confirm cover/title/declaration pages still show today's date/year,
  unchanged from current output.
- Build again with `submission-date` set — confirm the cover page year, the
  title page footer year, and the declaration page date all reflect the
  pinned date, and that day/month formatting is correct (e.g. `2025-08-05` →
  `5 August 2025`).

### 6. Versioning

Bump `pkgversion`/`pkgdate` in `build.lua` per the existing convention (new
feature → minor version bump), then run `l3build tag` as usual.

## Out of scope

- Validating malformed `submission-date` input.
- Auto-formatting locale variants (e.g. US-style `August 15, 2025`) — fixed
  to day-month-year British/NUS style only.
- Any change to `submission-year`'s existing default or independent
  behavior.
