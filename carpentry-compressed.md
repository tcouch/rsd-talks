% Software Carpentry: Compressed Edition
% James Hetherington

The State of Research Software
================================

The SIRO Problem
----------------

~~Garbage in Garbage Out~~

Sensible In, Reasonable Out.

PhDWare
-------

* Don't look if anyone's done it before
* Code till it works
* Generate a figure
* Throw it away

Labware
-------

* Understood by one genius
* Implements great science, now
* FORTRAN in any language
* Code not engineered for readability
* Can't add new science

HPCWare
-------

* Get a 5% improvement in performance
* On a particular architecture
* Publish a scaling graph
* Selection against:
      * Readability
      * Maintainability
      * Adaptability

ConsultantWare
--------

* Little understanding of the science
* Overengineered
* Unmaintainable by the research group

Software Carpentry
------------------

![](https://raw.githubusercontent.com/swcarpentry/bc/master/img/software-carpentry-banner.png)

* Founded by [Greg Wilson](http://www.third-bit.com/about.html)
* Volunteer organization
      * [Alfred P. Sloan Foundation](http://www.sloan.org/)
      * [Mozilla Foundation](http://www.mozilla.org/en-US/foundation/).
* Provides online training materials on which UCL course is based.

Software Carpentry
------------------

* Intensive "bootcamp"
* Teaches the tools needed to do computational science the Right Way
      * Readable
      * Reliable
      * Repeatable

Version Control
===============

What Version Control is For
---------------------------

* Managing Code Inventory
    * "When did I introduce this bug"?
    * Undoing Mistakes
* Working with other programmers
    * "How can I merge my work with Jim's"

What is version control?
------------------------

Do some programming

`my_vcs commit`

Program some more

Realise mistake

`my_vcs rollback`

Mistake is undone

What is version control? (Team version)
---------------------------------------

Sue                 James
------------------ ------
`my_vcs commit`
                    Join the team
                    `my_vcs checkout`
                    Do some programming
                    `my_vcs commit`
`my_vcs update`
Do some programming Do some programming
					`my_vcs commit`
`my_vcs update`
`my_vcs merge`
`my_vcs commit`

Version Control Examples
------------------------

* [Working alone with git](http://development.rc.ucl.ac.uk/training/carpentry/assets/distributed_solo.png)
* [Publishing with git](http://development.rc.ucl.ac.uk/training/carpentry/assets/distributed_solo_publishing.png)
* [Teamworking in git](http://development.rc.ucl.ac.uk/training/carpentry/assets/distributed_shared_noconflict.png)
* [Teamworking in git with conflicts](http://development.rc.ucl.ac.uk/training/carpentry/assets/distributed_shared_conflicted.png)

More than great backup
--------------------------

* Logging
* Collaboration
* Labels for code versions
* Branches for production vs play

Automation
==========

How Things Should Be
--------------------

``` Bash
fetch_dataset 53b6
run_model dataset_53b6
Examine_results results_28_02_13_1_53b6_98d2
archive_results latest
create_graphs results_28_02_13_1_53b6_98d2
```

Program or Be Programmed
------------------------

* Repetition leads to Boredom
* Boredom leads to Horrifying Mistakes
* Horrifying Mistakes lead to God-I-Wish-I-Was-Still-Bored

Automation for reproducibility
------------------------------

* More than saving time
* Provide a rigorous description of what was done

Python
------

[IPython Notebooks](http://nbviewer.ipython.org/github/swcarpentry/bc/blob/master/novice/python/01-numpy.ipynb)

This talk
---------

[This talk](https://github.com/UCL/rsd-talks/blob/master/carpentry-compressed/lecture.md)

This talk's SConscript
----------------------

``` python
pandoc_slides=Builder(action='pandoc -t revealjs -s -V theme=night'+
    ' --css=night.css'+
    ' --css=slidetheme.css'+
    ' --mathjax '+
    ' -V revealjs-url=http://lab.hakim.se/reveal-js/'+
    ' $SOURCES -o $TARGET')

...
dot_figure_builder=Builder(action='dot -Tpng $SOURCE -o $TARGET',
    suffix='.png',
    src_suffix='.dot')
```

This talk's puppet manifest
---------------------------

``` puppet
# Checkout the repository from GitHub
  vcsrepo {"repo-$title":
      path => "/opt/gitrepos/$checkout_location",
      ensure => 'latest',
      owner => 'apache',
      user => 'apache',
      identity => '/home/ccsprsd/.ssh/id_rsa',
      group => 'apache',
      provider => 'git',
      require => [ Package["git"], File["$service_home/.ssh/id_rsa"], ],
      source => "$source",
      revision => $branch,
    }

#Run Pandoc via scons to produce the Reveal.js presentations

    exec { "build-$title":
      command => $command,
      cwd => "/opt/gitrepos/$checkout_location/$workdir",
      require => [Exec["install-pandoc"],
        Package["scons"],
        Vcsrepo["repo-$title"]]
    }

# Copy the C++ course directory into the web folder
    file {"install-$title":
      path => "$install/$target",
      source => "/opt/gitrepos/$checkout_location/$sitedir",
      recurse => true,
      require => Exec["build-$title"],
      notify => Service["httpd"],
      owner => 'ccsprsd',
      group => 'ccspx0',
    }
```

Testing
=======

You don't need to test if:
--------------------------

> * Your programs always work correctly, or
> * You don't care if they're correct or not, so long
    as their output looks plausible, and
> * You like being inefficient:
    the more you invest in quality, the less total time
    it takes to build working software

Levels of Testing
-----------------

> * Regression testing: Does my code work the same as yesterday
> * Functional testing: Does my code match an analytic solution
> * Unit testing: Does this subroutine work as expected

Test-driven development
-----------------------

Know what you want:

``` python
def test_range_overlap():
    assert range_overlap([ (0.0, 1.0), (5.0, 6.0) ]) == None
    assert range_overlap([ (0.0, 1.0) ]) == (0.0, 1.0)
    assert range_overlap([ (2.0, 3.0), (2.0, 4.0) ]) == (2.0, 3.0)
    assert range_overlap([ (0.0, 1.0), (0.0, 2.0), (-1.0, 1.0) ]) == (0.0, 1.0)
```

Test-driven development
-----------------------

Then make it happen:

``` python
def range_overlap(ranges):
    '''Return common overlap among a set of [low, high] ranges.'''
    highest_min=max([range[0] for range in ranges])
    lowest_max=min([range[1] for range in ranges])
    if (lowest_max <= highest_min): return None # Note equality
    return (highest_min, lowest_max)
```

Tests Define Behaviour
----------------------

```python
assert range_overlap([ (0.0, 1.0), (1.0, 2.0) ]) == None
```

Tests are *Executable Documentation*

Tests As Specifications
-----------------------

Testing tells you:

> * If the program is doing what it's supposed to
> * What the program actually is supposed to do
> * Tests are runnable specifications:
> * Less likely to fall out of sync with the program
    than documentation

Continuous Testing Infrastructure
---------------------------------

[Jenkins](http://development.rc.ucl.ac.uk/jenkins/)

Coda
====

Contact
-------

![](http://development.rc.ucl.ac.uk/talks/scholar/assets/twitter.png) @uclrcsoftdev @jamespjh @uclrits

![](http://development.rc.ucl.ac.uk/talks/scholar/assets/rss.png) blogs.ucl.ac.uk/research-software-development

![](http://development.rc.ucl.ac.uk/talks/scholar/assets/email.png) j.hetherington@ucl.ac.uk

And [sign up](https://www.mailinglists.ucl.ac.uk/mailman/listinfo/research-programming)
to be notified of the date of the next bootcamp.

> ``I found the command line intimidating at first, but after a while it felt
> like I was inside my computer.''

-- A student at the UCL software carpentry event
