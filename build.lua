#!/usr/bin/env texlua

--- tags

module = "nus-thesis"
pkgversion = "0.1.0.a" -- Major, Minor, Patch, Tweak
pkgdate = "2024-11-28"

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

files2tag = {
   {
    name = "src/"..module..".dtx",
    version_pattern = "ProvidesExplClass{"..module.."}{%d%d%d%d%-%d%d%-%d%d}{%d+%.%d+%.%d+%.%w+}",
    version_subpattern = "}{%d+%.%d+%.%d+%.%w+}",
    date_pattern = "ProvidesExplClass{"..module.."}{%d%d%d%d%-%d%d%-%d%d}{%d+%.%d+%.%d+%.%w+}",
    date_subpattern = module.."}{%d%d%d%d%-%d%d%-%d%d}{",
    version_output =  "}{".. pkgversion .."}",
    date_output = module.."}{"..pkgdate.."}{"
   }
}

-- Typeset documentation - builds two separate PDFs
-- nus-thesis-manual.pdf: User documentation
-- nus-thesis-impl.pdf: Implementation documentation
typesetfiles = {
  "nus-thesis-manual.tex",  -- User documentation
  "nus-thesis-impl.tex"     -- Implementation documentation
}
typesetdemofiles = { "examples/*.tex" }
