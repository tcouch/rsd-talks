pandoc -t beamer dexy.md -V theme:uclposter  -o dexy.pdf --include-in-header header.tex
pdfjam dexy.pdf 2 -o dexy2.pdf

