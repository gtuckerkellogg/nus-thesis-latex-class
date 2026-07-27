# Fixed Submission Date Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a `submission-date` key to `nus-thesis.cls` so a thesis author can pin an explicit ISO date (`YYYY-MM-DD`) that fixes both the printed submission year (cover/title pages) and the declaration-page signature date, instead of those silently drifting to `\today`/`\number\year` every time the document is recompiled.

**Architecture:** A new expl3 key `submission-date` is added to the existing `nus-thesis` key-value interface in `src/nus-thesis.dtx`. Its `.code:n` parses the ISO string with `\seq_set_split:Nnn` + `\int_eval:n` + `\int_case:nn`, then sets two variables: the existing `\l__thesis_year_tl` (already consumed by the cover/title pages — no changes needed there) and a new `\l__nusthesis_declaration_date_tl` (defaults to unexpanded `\today`, consumed by `\DeclarationSignature` in place of the current literal `\today`). The existing `submission-year` key is untouched and stays independent.

**Tech Stack:** LaTeX3 (expl3), DocStrip (`.dtx`/`.ins`), l3build, pdflatex, pdftotext (for automated smoke tests — this repo has no `l3build check`/`.lvt` test harness, so verification uses scratch `.tex` smoke files compiled and grepped, not committed to the repo).

## Global Constraints

- No new package dependencies — pure expl3 (spec §2).
- No public command signatures change (`\DeclarationSignature`, `\DeclarationPage`, `\maketitle`, `\coverpage`, `\titlepagefooter` all keep their interfaces) (spec §3).
- `submission-year` key stays fully independent and unchanged; ordinary l3keys left-to-right precedence applies if both keys are set (spec §1).
- If `submission-date` is never set, behavior must be pixel-identical to current: `\l__thesis_year_tl` defaults to `\number\year`, declaration date defaults to (unexpanded) `\today` (spec §1).
- No bespoke input validation for malformed ISO strings — trust the value like every other config key in this class (spec §2).
- Display format is fixed day-month-year, e.g. `15 August 2025` — no other locale/format (spec §2, out of scope list).
- Design spec: `docs/superpowers/specs/2026-07-27-submission-date-design.md` — refer back to it if any task here seems ambiguous.

---

### Task 1: Add the `submission-date` key (data model + ISO parsing)

**Files:**
- Modify: `src/nus-thesis.dtx:921-924` (token list declarations)
- Modify: `src/nus-thesis.dtx:947-948` (key block, right after the existing `submission-year` key)
- Test: scratch file `/tmp/claude-2036/-home-gtk-Dropbox--support-src-nus-thesis-latex-class/1f2e07ce-ac39-4221-9782-0a8f6f60be2b/scratchpad/smoke1.tex` (not committed)

**Interfaces:**
- Produces: `\l__thesis_year_tl` (already exists; this task adds a second way to set it) — a token list holding a bare year number, e.g. `2025`.
- Produces: `\l__nusthesis_declaration_date_tl` — a token list holding either the unexpanded token `\today` (default) or a formatted display string like `15 August 2025` (after `submission-date` is set). Consumed by Task 2.
- Produces: `\l__nusthesis_submission_date_tl` — raw ISO string as passed by the user, stored for completeness (not consumed elsewhere in this plan).

- [ ] **Step 1: Unpack the class once so you have a baseline to compile against**

Run: `cd /home/gtk/Dropbox/_support/src/nus-thesis-latex-class && l3build unpack`
Expected: creates/refreshes `build/unpacked/nus-thesis.cls` (and the `.sty` files) with no errors.

- [ ] **Step 2: Write the failing smoke test**

Create `smoke1.tex` in the scratchpad directory:

```latex
\documentclass{nus-thesis}
\ThesisSetup{
  author = Test Author,
  title = {Test Title},
  submission-date = {2025-08-05},
}
\begin{document}
\ExplSyntaxOn
\typeout{~}
\typeout{YEAR-RESULT:\l__thesis_year_tl:YEAR-RESULT}
\typeout{DECL-RESULT:\l__nusthesis_declaration_date_tl:DECL-RESULT}
\ExplSyntaxOff
Hello.
\end{document}
```

Compile it with the unpacked class on `TEXINPUTS`:

Run:
```bash
cd /tmp/claude-2036/-home-gtk-Dropbox--support-src-nus-thesis-latex-class/1f2e07ce-ac39-4221-9782-0a8f6f60be2b/scratchpad
TEXINPUTS=".:/home/gtk/Dropbox/_support/src/nus-thesis-latex-class/build/unpacked:" pdflatex -interaction=nonstopmode smoke1.tex > smoke1.out 2>&1
grep -E "YEAR-RESULT|DECL-RESULT" smoke1.log
```

- [ ] **Step 2b: Run it to confirm it fails (key doesn't exist yet)**

Expected: pdflatex errors out (undefined key `submission-date`) — `smoke1.log` will contain something like `! Package l3keys Error: Unknown key`. Confirm the error mentions `submission-date` specifically, not an unrelated typo in the test file.

- [ ] **Step 3: Declare the two new token lists**

In `src/nus-thesis.dtx`, find:

```latex
\tl_new:N \l__nusthesis_supervisor_tl
\tl_new:N \l__nusthesis_subtitle_tl
\tl_new:N \l__nusthesis_qualification_tl
\tl_new:N \l__nusthesis_keywords_tl
```

Replace with:

```latex
\tl_new:N \l__nusthesis_supervisor_tl
\tl_new:N \l__nusthesis_subtitle_tl
\tl_new:N \l__nusthesis_qualification_tl
\tl_new:N \l__nusthesis_keywords_tl
\tl_new:N \l__nusthesis_submission_date_tl
\tl_new:N \l__nusthesis_declaration_date_tl
\tl_set:Nn \l__nusthesis_declaration_date_tl { \today }
```

(The `\tl_set:Nn` gives `\l__nusthesis_declaration_date_tl` its default — the unexpanded `\today` token — so anything that reads it before `submission-date` is set behaves exactly as today's hardcoded `\today` does.)

- [ ] **Step 4: Add the `submission-date` key**

In `src/nus-thesis.dtx`, find:

```latex
  , submission-year .tl_set:N = \l__thesis_year_tl
  , submission-year .initial:n =  { \number\year }
```

Replace with:

```latex
  , submission-year .tl_set:N = \l__thesis_year_tl
  , submission-year .initial:n =  { \number\year }
  , submission-date .tl_set:N = \l__nusthesis_submission_date_tl
  , submission-date .initial:n = { }
  , submission-date .code:n = {
      \seq_set_split:Nnn \l_tmpa_seq { - } { #1 }
      \tl_set:Nx \l__thesis_year_tl { \int_eval:n { \seq_item:Nn \l_tmpa_seq {1} } }
      \tl_set:Nx \l__nusthesis_declaration_date_tl {
        \int_eval:n { \seq_item:Nn \l_tmpa_seq {3} }
        ~
        \int_case:nn { \int_eval:n { \seq_item:Nn \l_tmpa_seq {2} } }
          {
            {1}{January}
            {2}{February}
            {3}{March}
            {4}{April}
            {5}{May}
            {6}{June}
            {7}{July}
            {8}{August}
            {9}{September}
            {10}{October}
            {11}{November}
            {12}{December}
          }
        ~
        \int_eval:n { \seq_item:Nn \l_tmpa_seq {1} }
      }
    }
```

- [ ] **Step 5: Re-unpack and re-run the smoke test**

Run:
```bash
cd /home/gtk/Dropbox/_support/src/nus-thesis-latex-class && l3build unpack
cd /tmp/claude-2036/-home-gtk-Dropbox--support-src-nus-thesis-latex-class/1f2e07ce-ac39-4221-9782-0a8f6f60be2b/scratchpad
TEXINPUTS=".:/home/gtk/Dropbox/_support/src/nus-thesis-latex-class/build/unpacked:" pdflatex -interaction=nonstopmode smoke1.tex > smoke1.out 2>&1
grep -E "YEAR-RESULT|DECL-RESULT" smoke1.log
```

Expected output lines:
```
YEAR-RESULT:2025:YEAR-RESULT
DECL-RESULT:5 August 2025:DECL-RESULT
```

If you see `08` instead of `8`, or `2025` is missing/wrong, re-check Step 4's `\int_eval:n` usage before moving on.

- [ ] **Step 6: Add and run the fallback (unset) case in the same smoke test**

Append a second document to a new file `smoke2.tex` (copy `smoke1.tex` but remove the `submission-date` line entirely, and change the typeout to compare against `\today` directly, since a hardcoded date string would be wrong on any other day):

```latex
\documentclass{nus-thesis}
\ThesisSetup{
  author = Test Author,
  title = {Test Title},
}
\begin{document}
\ExplSyntaxOn
\typeout{~}
\typeout{TODAY-RESULT:\today:TODAY-RESULT}
\typeout{DECL-RESULT:\l__nusthesis_declaration_date_tl:DECL-RESULT}
\ExplSyntaxOff
Hello.
\end{document}
```

Run:
```bash
cd /tmp/claude-2036/-home-gtk-Dropbox--support-src-nus-thesis-latex-class/1f2e07ce-ac39-4221-9782-0a8f6f60be2b/scratchpad
TEXINPUTS=".:/home/gtk/Dropbox/_support/src/nus-thesis-latex-class/build/unpacked:" pdflatex -interaction=nonstopmode smoke2.tex > smoke2.out 2>&1
grep -E "TODAY-RESULT|DECL-RESULT" smoke2.log
```

Expected: the text between `TODAY-RESULT:` and `:TODAY-RESULT` is byte-identical to the text between `DECL-RESULT:` and `:DECL-RESULT` (both were expanded in the same compiler run, so they must match if the default is genuinely still `\today`).

- [ ] **Step 7: Commit**

```bash
cd /home/gtk/Dropbox/_support/src/nus-thesis-latex-class
git add src/nus-thesis.dtx
git commit -m "$(cat <<'EOF'
Add submission-date key with ISO date parsing

Recompiling a thesis after submission currently changes the printed
year because submission-year defaults to \number\year at compile
time. submission-date lets the author pin an explicit YYYY-MM-DD date
that derives both the year and a formatted display date, while
staying opt-in: unset behavior is unchanged.

Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>
EOF
)"
```

---

### Task 2: Wire `\DeclarationSignature` to the new declaration-date variable

**Files:**
- Modify: `src/nus-thesis.dtx:1525` (inside `\DeclarationSignature`)
- Test: scratch file `smoke3.tex` in the same scratchpad directory

**Interfaces:**
- Consumes: `\l__nusthesis_declaration_date_tl` (produced by Task 1).
- No new interfaces produced — this task only changes what `\DeclarationSignature` prints.

- [ ] **Step 1: Write the failing test**

Create `smoke3.tex`:

```latex
\documentclass{nus-thesis}
\ThesisSetup{
  author = Test Author,
  title = {Test Title},
  submission-date = {2025-08-05},
}
\begin{document}
\begin{declaration}
  \DeclarationStatement
  \DeclarationSignature
\end{declaration}
\end{document}
```

Run:
```bash
cd /tmp/claude-2036/-home-gtk-Dropbox--support-src-nus-thesis-latex-class/1f2e07ce-ac39-4221-9782-0a8f6f60be2b/scratchpad
TEXINPUTS=".:/home/gtk/Dropbox/_support/src/nus-thesis-latex-class/build/unpacked:" pdflatex -interaction=nonstopmode smoke3.tex > smoke3.out 2>&1
pdftotext smoke3.pdf - | grep -c "5 August 2025"
```

- [ ] **Step 2: Run it to confirm it fails**

Expected: the `grep -c` prints `0` — the declaration page currently shows today's real date (from the hardcoded `\today`), not `5 August 2025`, because `\DeclarationSignature` hasn't been wired up yet.

- [ ] **Step 3: Update `\DeclarationSignature`**

In `src/nus-thesis.dtx`, find:

```latex
    \rule{\c__nusthesis_declaration_line_width_dim}{\c__nusthesis_declaration_line_thickness_dim}\\
    \vspace*{\c__nusthesis_declaration_author_adjust_dim}
    \@author\\
    \vspace*{\c__nusthesis_declaration_date_vspace_dim}
    \vspace*{\c__nusthesis_declaration_author_adjust_dim}
    \today
  \end{center}
}
```

Replace with:

```latex
    \rule{\c__nusthesis_declaration_line_width_dim}{\c__nusthesis_declaration_line_thickness_dim}\\
    \vspace*{\c__nusthesis_declaration_author_adjust_dim}
    \@author\\
    \vspace*{\c__nusthesis_declaration_date_vspace_dim}
    \vspace*{\c__nusthesis_declaration_author_adjust_dim}
    \l__nusthesis_declaration_date_tl
  \end{center}
}
```

- [ ] **Step 4: Re-unpack and re-run the smoke test**

Run:
```bash
cd /home/gtk/Dropbox/_support/src/nus-thesis-latex-class && l3build unpack
cd /tmp/claude-2036/-home-gtk-Dropbox--support-src-nus-thesis-latex-class/1f2e07ce-ac39-4221-9782-0a8f6f60be2b/scratchpad
TEXINPUTS=".:/home/gtk/Dropbox/_support/src/nus-thesis-latex-class/build/unpacked:" pdflatex -interaction=nonstopmode smoke3.tex > smoke3.out 2>&1
pdftotext smoke3.pdf - | grep -c "5 August 2025"
```

Expected: prints `1`.

- [ ] **Step 5: Confirm the unset-fallback path still renders (visual sanity, no fixed string to grep for)**

Run the same compile but with a copy of `smoke3.tex` that has no `submission-date` key (call it `smoke4.tex`), then eyeball `pdftotext smoke4.pdf -` — it should show today's actual date on the declaration line, same as before this change.

- [ ] **Step 6: Commit**

```bash
cd /home/gtk/Dropbox/_support/src/nus-thesis-latex-class
git add src/nus-thesis.dtx
git commit -m "$(cat <<'EOF'
Use submission-date for the declaration page signature date

\DeclarationSignature previously hardcoded \today. It now reads
\l__nusthesis_declaration_date_tl, which is either the pinned date
from submission-date or, unset, still resolves to \today at compile
time -- current behavior is preserved by default.

Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>
EOF
)"
```

---

### Task 3: Document the `submission-date` key

**Files:**
- Modify: `src/nus-thesis.dtx:219-227` (the `\subsection{Submission Details}` doc block)

**Interfaces:**
- None (documentation only — this is DocStrip commentary, compiled into `nus-thesis-manual.pdf`/`nus-thesis-impl.pdf` via `l3build doc`, not into the `.cls`).

- [ ] **Step 1: Update the doc block**

In `src/nus-thesis.dtx`, find:

```latex
% \subsection{Submission Details}
%
% \begin{function}{submission-year}
%   \begin{syntax}
%     |submission-year| = \meta{year}
%   \end{syntax}
% The four-digit submission year.  Defaults to the current year.
% \end{function}
%
% \begin{function}{advisor}
```

Replace with:

```latex
% \subsection{Submission Details}
%
% \begin{function}{submission-year}
%   \begin{syntax}
%     |submission-year| = \meta{year}
%   \end{syntax}
% The four-digit submission year.  Defaults to the current year.
% Prefer |submission-date| (below) when you want the year pinned
% together with a fixed declaration-page date; if both are set, whichever
% is processed later in \ThesisSetup{} wins.
% \end{function}
%
% \begin{function}{submission-date}
%   \begin{syntax}
%     |submission-date| = \meta{ISO date, e.g.\ 2025-08-15}
%   \end{syntax}
% Pins the thesis to a fixed submission date instead of deriving it from
% \cs{today} at compile time.  Recompiling the document later (e.g.\ to fix a
% typo in an already-submitted thesis) would otherwise silently change the
% printed year and the declaration-page signature date to "now" -- setting
% |submission-date| avoids that.  The value must be an ISO date
% (\meta{YYYY-MM-DD}).  Setting it derives the four-digit year shown on the
% cover and title pages (overriding |submission-year|) \emph{and} the
% formatted date (e.g.\ |15 August 2025|) shown on the declaration page in
% place of \cs{today}.  Leave it unset while actively drafting; set it once
% for the final/archival copy.
% \end{function}
%
% \begin{function}{advisor}
```

- [ ] **Step 2: Rebuild the documentation PDFs to confirm the doc block compiles cleanly**

Run: `cd /home/gtk/Dropbox/_support/src/nus-thesis-latex-class && l3build doc`
Expected: no errors; `build/doc/nus-thesis-impl.pdf` regenerates and its "Submission Details" section now shows both `submission-year` and `submission-date` entries. Open the PDF (or run `pdftotext build/doc/nus-thesis-impl.pdf - | grep -A3 "submission-date"`) to confirm the new text appears and reads sensibly.

- [ ] **Step 3: Commit**

```bash
cd /home/gtk/Dropbox/_support/src/nus-thesis-latex-class
git add src/nus-thesis.dtx
git commit -m "$(cat <<'EOF'
Document the submission-date key

Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>
EOF
)"
```

---

### Task 4: Demonstrate `submission-date` in the example, bump the version, and do a full manual acceptance build

**Files:**
- Modify: `doc/PhD.tex:7-18` (the `\ThesisSetup{}` block)
- Modify: `build.lua:6-7` (`pkgversion`, `pkgdate`)

**Interfaces:**
- None (example + packaging metadata only).

- [ ] **Step 1: Add `submission-date` to the reference example**

In `doc/PhD.tex`, find:

```latex
\ThesisSetup{
  author = Ramanan Balakrishnan,
  qualification = {Bachelor of Science, MIT},
  candidacy = {Doctor of Philosophy},
  font = helvetica,
  final = true,
  advisor = {Professor Greg Tucker-Kellogg},
  examiners = {Professor Foo \\ Prof Bar},
  field = {my obscure field},
  university = National University of Singapore,
  department = Biological Sciences
}
```

Replace with:

```latex
\ThesisSetup{
  author = Ramanan Balakrishnan,
  qualification = {Bachelor of Science, MIT},
  candidacy = {Doctor of Philosophy},
  font = helvetica,
  final = true,
  advisor = {Professor Greg Tucker-Kellogg},
  examiners = {Professor Foo \\ Prof Bar},
  field = {my obscure field},
  university = National University of Singapore,
  department = Biological Sciences,
  % Pin the submission date for a final/archival recompile so the year and
  % declaration-page date don't drift to "today" on rebuild. Comment this
  % out (or omit it) while actively drafting to keep using today's date.
  submission-date = {2025-08-15}
}
```

- [ ] **Step 2: Bump the version in `build.lua`**

In `build.lua`, find:

```lua
pkgversion = "0.1.0.a" -- Major, Minor, Patch, Tweak
pkgdate = "2024-11-28"
```

Replace with (use today's actual date when you run this step):

```lua
pkgversion = "0.1.1.a" -- Major, Minor, Patch, Tweak
pkgdate = "2026-07-27"
```

- [ ] **Step 3: Run `l3build tag` to propagate the version into the source**

Run: `cd /home/gtk/Dropbox/_support/src/nus-thesis-latex-class && l3build tag`
Expected: updates the `\ProvidesExplClass{nus-thesis}{2026-07-27}{0.1.1.a}` line in `src/nus-thesis.dtx` to match. Confirm with `grep ProvidesExplClass src/nus-thesis.dtx`.

- [ ] **Step 4: Full build and manual visual acceptance check**

Run: `cd /home/gtk/Dropbox/_support/src/nus-thesis-latex-class && l3build build`
Expected: no errors. Then open `build/doc/PhD.pdf` (or wherever the built example lands) and manually confirm:
- Cover page shows `2025`.
- Title page footer shows `2025`.
- Declaration page shows `15 August 2025` (not today's real date).

Then, as a regression check, temporarily comment out the `submission-date` line in `doc/PhD.tex`, rebuild, and confirm the three values above revert to showing today's actual year/date — then restore the `submission-date` line (uncommented) before committing, since the example should ship with it demonstrated.

- [ ] **Step 5: Commit**

```bash
cd /home/gtk/Dropbox/_support/src/nus-thesis-latex-class
git add doc/PhD.tex build.lua src/nus-thesis.dtx
git commit -m "$(cat <<'EOF'
Demonstrate submission-date in the PhD example, bump to 0.1.1.a

Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>
EOF
)"
```

---

## Post-plan cleanup

Delete the scratch smoke-test files once Task 4 is done — they live in the session scratchpad, not the repo, so no repo cleanup is needed:

```bash
rm -f /tmp/claude-2036/-home-gtk-Dropbox--support-src-nus-thesis-latex-class/1f2e07ce-ac39-4221-9782-0a8f6f60be2b/scratchpad/smoke*.tex
rm -f /tmp/claude-2036/-home-gtk-Dropbox--support-src-nus-thesis-latex-class/1f2e07ce-ac39-4221-9782-0a8f6f60be2b/scratchpad/smoke*.{aux,log,out,pdf}
```
