#!/usr/bin/env texlua

--- tags

module = "nus-thesis"
pkgversion = "0.2.0.a" -- Major, Minor, Patch, Tweak
pkgdate = "2026-07-28"

sourcefiledir = "src"
docfiledir = "doc"
docfiles =  { "*.tex" , "*.png" }

-- Add the examples directory
examplesdir = "examples"
examplesfiles = { "*.tex" }

typesetexe = "pdflatex"
typesetruns = 4  -- Run pdflatex multiple times to resolve cross-references

packtdszip = true

checkengines = { "pdftex" }
checksuppfiles = { "*.tex" }

-- l3build's `tag` target only edits files when a Lua `update_tag` function is
-- supplied (see the l3build manual, section 4.2 "Automatic tagging"); with no
-- such function defined, `l3build tag` is a no-op. Keep the
-- \ProvidesExplClass{...}{date}{version}{...} declaration in src/nus-thesis.dtx
-- in sync with pkgversion/pkgdate above. The declaration is split across two
-- docstrip-tagged lines:
--   %<class>\ProvidesExplClass{nus-thesis}
--   %<class>{2024-11-29}{0.0.0.a}{NUS thesis class}
local function lua_pattern_escape(s)
  return (s:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"))
end

function update_tag(file,content,tagname,tagdate)
  if file == module..".dtx" then
    local module_pat = lua_pattern_escape(module)
    content = content:gsub(
      "(\\ProvidesExplClass{"..module_pat.."}\n%%<class>){%d%d%d%d%-%d%d%-%d%d}{%d+%.%d+%.%d+%.%w+}",
      "%1{"..pkgdate.."}{"..pkgversion.."}"
    )
  end
  return content
end

-- Typeset documentation - builds two separate PDFs
-- nus-thesis-manual.pdf: User documentation
-- nus-thesis-impl.pdf: Implementation documentation
typesetfiles = {
  "nus-thesis-manual.tex",  -- User documentation
  "nus-thesis-impl.tex"     -- Implementation documentation
}
typesetdemofiles = { "examples/*.tex" }
