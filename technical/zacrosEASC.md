---
title: "Zacros Software Package Development:"
subtitle: Archer ESCE progress
author: Jens H Nielsen, James Hetherington & Michail Stamatakis
bibliography: "../bibliography/rsdt.bib"
---

Introduction to Zacros
======================

Zacros:
-------

* Kinetic Monte Carlo (KMC) simulation of surface chemistry. 
* Graph theoretical approach.
* Reactions selected based on propensities.
* Surface energy expressed in cluster expansions.
Pushing the Frontiers of Kinetic Monte Carlo Simulation in Catalysis

Pseudo code
-----------

* A reaction is selected based on:
    - Its propensities
    - A random number
* All adsorbates, clusters and reactions involving the reactants are removed
* Add product adsorbates to lattice 
* Find new energy clusters
* Find all processes that need update 
* Update rates of existing processes
* Add new processes

Previous work: OpenMP
=====================

UCL research software development free project
----------------------------------------------

* Usually the bottleneck is "Update rates of existing processes"
* Many processes are affected. 
    - Especially for large cluster expansion.
* Do loop of independent processes to update.
* OpenMP parallization of this loop.

See [@nielsen_parallel_2013]

Scaled performance of OpenMP
----------------------------

![](assets/zacrosESCE/archer_intelO3_threds_scaling.png)


Archer Project
==============

Archer
------

Brief description of work plan



Spatial parallelization
=======================

Testing
-------

Various published methods 

Unit Testing
============

Testing
-------

tearte

Bibliography
============

Bibliography
------------

test