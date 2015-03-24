---
title: Automated lecturing with Pandoc, Dexy, and Jenkins
author: James Hetherington
institution: University College London
date: 23 March 2015
---

\columnsbegin
\columnbegin
\blockbegin{Pandoc}

``` bash
pandoc lecture.md -o lecture.pdf
pandoc lecture.md -t revealjs
pandoc lecture.md -o lecture.html
```

\blockend
\blockbegin{Dexy}

``` yaml
.md|pandoc
.md|pandoc|-reveal|h
.md|mdjup
.md|pandoc|p
.dot|dot
.py|idio|pycon
```

\blockend
\blockbegin{Result}

* Write once in Markdown, with all figures and text version controlled
* Get pdf book, website, online slides, and IPython Notebook!
* Push to git, 5 mins later, updated lecture online

\blockend
\blockbegin{Implications}

* Version control $\rightarrow$ collaboration
* Multi-format $\rightarrow$ gradually flipped classroom
* Autodeployment $\rightarrow$ live mistake correction

\blockend
\columnend
\columnbegin
\blockbegin{Jenkins}


``` yaml
job-template:
  name: "lecture-publisher"
  scm:
    - git:
      url: "git@github.com:UCL/lec.git"
    - pollscm: "*/5 * * * *"
  builders:
    - shell : dexy
  publishers:
    - html-publisher:
      name: output
```

\blockend
\blockbegin{YUML}
``` yuml
[Model]<>-*>[Boid]
```
\includegraphics{aggregation.png}
\blockend
\blockbegin{Try it!}
See our lecture notes at
http://bit.ly/rcnotes

\blockend
\columnend
\columnsend

