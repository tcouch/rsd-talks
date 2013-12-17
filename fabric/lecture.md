---
title: Using fabric to deploy to HPC
author: James Hetherington and Derek Groen
institution: University College London
date: 19 November 2013
---

Repetition
==========

* Repetition leads to boredom 
* Boredom leads to horrifying mistakes
* Horrifying mistakes lead to God-I-wish-I-was- still-bored
-- [Will Larson](http://lethain.com/deploying-django-with-fabric/)

Doing it wrong
==============

If you manually shell into a remote supercomputer when you deploy into production you are doing it wrong.

Tools exist to help you manage deployment.

DevOps
======

"Systems administration" should be treated with the same respect as development.

This is systems programming. (Aka dev ops.)

Fabric
======

```bash
cat ~/devel/myproject/fabfile.py
fab deploy
```
```python
from fabric.api import local
env.host = 'gauss.chem.ucl.ac.uk'
env.repo = 'ssh://hg@myserver/myrepo'

env.remote_path='/var/www/www.myapp.com/'
@task
def deploy():
  with cd(env.remote_path)
    run('git clone {repo}'.format(**env))
```

Fabric with supercomputers
==========================

* Maintain list of different remotes
* Maintain templates for jobscripts
* Define modules to load in fabfile, not in remote bashrc.

Fabric with supercomputers
==========================

```python
@task
def configure(*configurations,**extras):
    """CMake configure step for HemeLB and dependencies."""
    configure_cmake(configurations,extras)

    with cd(env.build_path):
        with prefix(env.build_prefix):
            run(template("rm -f $build_path/CMakeCache.txt"))
            run(template("cmake $repository_path $cmake_flags"))
```

Using fabric with multiple remotes
==================================

``` bash
cd devel/projects/hemelb
fab hector cold
fab tianhe send_geometry:cylinder
fab archer hemelb:cylinder
fab dirac wait_on_run
fab legion steer
fab stampede fetch_results
```

Describe machines
=================

```bash
cat ~/devel/hemelb/deploy/machines.yml
```
``` yaml
hector:
  remote: "login.hector.ac.uk"
  username: jamespjh
  job_dispatch: "qsub"
  run_command: "aprun -n $cores -N
            $coresusedpernode"
  batch_header: pbs
  max_job_name_chars: 15
  make_jobs: 4
legion:
  ...
```

Our use of Fabric
=================
We use it to:

* compile, deploy and manage runs of HemeLB (a bloodflow simulation environment),
* create and manage automated workflows to iteratively optimize potentials for coarse-grained molecular dynamics systems.
