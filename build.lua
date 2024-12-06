#!/usr/bin/env texlua


--- tags

module = "nus-thesis"
pkgversion = "0.1.0.a" -- Major, Minor, Patch, Tweak
pkgdate = "2024-11-28"

sourcefiledir = "src"
docfiledir = "doc"
typesetfiles = {"*.dtx", "*.tex" } 
typesetexe = "pdflatex"

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
