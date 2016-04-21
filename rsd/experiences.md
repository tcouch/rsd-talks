---
title: Experiences in creating a Research Software Engineering Group
author: James Hetherington
layout: default
slidelink: True
---

Experiences in creating a Research Software Engineering Group
=============================================================

The UCL Research Software Group
-------------------------------

* Started 2012
* Helped UCL win over 1.5M in research income
* Grown through grant funding from just me to a team of 8
* Works with researchers from archaeology to astrophysics
* Part of [UCL RITS](https://www.ucl.ac.uk/research-it-services)

Readable, reliable, and reproducible
---------------------------------

We help make code:

* Last beyond the end of the grant that funded it
* Be usable by someone other than the PhD student who wrote it
* Have a standard of correctness better than "the graph looks about right"

Low-Template DNA
================

Whodunnit code: low-template DNA
--------------------------------

![](assets/whodunnitdna.jpg)

Whodunnit code: low-template DNA
-----------------------

* Low-template DNA
* Relative likelihood of defence and prosecution hypotheses
* Optimise over relative degree of contribution from various individuals

Structural work on likeLTD
--------------------------------------------

* Broken down into functions
* Separate objective function from simulated annealing optimiser
* Look at using different optimiser libraries
* Documentation added
* Ready for publication to CRAN

Performance Improvements in likeLTD
-------------------------------------------

* 4 times from moving to C
* 8 times from parallelisation
* 10 times from change of optimisation algorithm
* 300 times total

DCProgs
=======

Old State of the Code
-----------------

* Very old-style Fortran
* Hasn't compiled since 2006
* Underpins Nature-published research

New State
---------

* Reimplemented in C++ and Python
* Use linear algebra and root finding libraries
* Just as performant as the Fortran

HemeLB Setup Tool
=================

HemeLB Setup Tool
-----------------

![](assets/tubes.png)

Voxelisation
------------

![](assets/blockgrid.jpg)


Robustness
----------

![](assets/cgal.png)

Robustness
----------

* From ~95% to 100%.
* Voxelisation in the loop

Good, huh?
==========

Well, it hasn't always been pretty.

I'll try to indicate some tips and tricks learned while
creating a generalist science-as-a-service software group.

Some of these we got right. Some are things I wish I'd
known at the beginning.


Sell performance, deliver reproducibility
-----------------------------------------

![Source: [Secret Leeds](http://www.secretleeds.com/viewtopic.php?t=5498&start=30)](http://farm7.staticflickr.com/6144/6202830241_f16833fbaf_z.jpg)

Use appropriate technology
--------------------------

![Source: [African Windmill Project](http://africawindmill.org)](http://africawindmill.org/wp-content/uploads/2013/03/DSC01549-Copy-2-.jpg)

Look beyond the usual
---------------------

![Source: [ORACC](http://oracc.museum.upenn.edu) ](https://www.ucl.ac.uk/research-it-services/about/research-software-development/carousel/ORACC.jpg)

Recruit flexibly, and nurture
-----------------------------

![Smart and Gets Things Done ](http://www.software.ac.uk/sites/default/files/images/content/ScholarAndCraftsman.jpg)

Organisational Judo
-------------------

![Source: Unknown](https://scontent.cdninstagram.com/hphotos-xfp1/t51.2885-15/s320x320/e15/10954254_848450445193608_1268926421_n.jpg)

Transcend the academic hierarchy
--------------------------------

<iframe width="420" height="315" src="https://www.youtube.com/embed/p85xwZ_OLX0" frameborder="0" allowfullscreen></iframe>

Copyright
---------

The sourcecode of this talk is available under a CC-BY license:

* [https://github.com/UCL/rsd-talks/tree/master][https://github.com/UCL/rsd-talks/tree/master]

The images in this talk are not copied. They are embedded or "transcluded".

* [Transclusion](https://en.wikipedia.org/wiki/Transclusion)
* [Transclusion and copyright](http://www.create.ac.uk/blog/2014/11/28/eu-ruling-embedding-does-not-equal-copyright-infringement/)
