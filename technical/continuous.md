---
title: Continuous Deployment
author: James Hetherington
institution: University College London
date: 18 May 2016
layout: default
slidelink: True
---

Systems Programming
===================

Repetition
----------

* Repetition leads to boredom
* Boredom leads to horrifying mistakes
* Horrifying mistakes lead to God-I-wish-I-was-still-bored
-- [Will Larson](http://lethain.com/deploying-django-with-fabric/)

Doing it wrong
--------------

If you manually shell into a computer and run commands when you deploy you are doing it wrong.

Systems Programming
-------------------

"Systems administration" is a programming task: we have Puppet.

This is systems programming. (Aka "dev ops".)

There is no distinction between development and operations any more: all
programmers are sysadmins, and vice-versa.

Plan for the talk
-----------------

In this talk, I'll explore some of the consequences of this convergence.

First, though, I'll recap some good things from modern programming
practices, that we're going to borrow
for systems programming.

Programming Practices
=====================

Version control
---------------

* All changes to the code are kept, with a log message
* Grabbing someone else's work is just a `git clone` away

Branching in Git
---------------

Unlike earlier version control tools,
creating branches in Git is easy and cheap, and merges are clean and often
completely automatic.

We create a branch for *each new feature or bug-fix*.

``` bash
git checkout -b new_feature
# Do some Coding
git checkout master
git merge new_feature
```

This is *integration*

Pull Requests
-------------

Then we open a "Pull Request", which indicates that the feature is ready
to be tested and merged.

[https://github.com/UCL-RITS/RSD-Dashboard/pull/170](assets/pull170.png)

Automated Testing
-----------------

myprog.py:

``` python
def some_clever_function(x):
  return x*2
```

test_myprog.py

``` python
def test_myprog():
  from myprog import some_clever_function
  assert(some_clever_function(3) == 6)
```

``` bash
py.test
```

Continuous Testing Servers
--------------------------

It's a faff to run your tests for every platform you might want to run on,
for every version of your language. So we have automated testing servers to
run our tests, and email us when it goes wrong.

[http://development.rc.ucl.ac.uk/jenkins/](assets/jenkins.png)

Version control of automated test jobs
--------------------------------------

Jenkins expects the config for your automated tests to be specified in its GUI.

This is obviously suboptimal: we want to version control everything.

In RSDG, we're using a Jenkins plugin to manage our automated test configuration:

``` yaml
name: 'nammu'
 disabled: false
 node: OSX

 builders:
     - shell: |
         cd $WORKSPACE
         mvn clean install
 scm:
     - git:
         url: git@github.com:oracc/nammu
         branches:
             - '{mybranch}'

 triggers:
   - github
   - timed: "@midnight"

 publishers:
     - git:
         push-only-if-success: true
```

Travis
------

There's a nice cloud service that does this: we're moving our simpler
non-supercomputing jobs over to Travis, instead of Jenkins.

Travis configuration just uses .travis.yml files in the repository to configure
builds.

[https://travis-ci.com/UCL-RITS/RSD-Dashboard/pull_requests](assets/travis.png)

Continuous deployment
=====================

Automatic Deployment
--------------------

If you trust your automated tests, you can do more: you can *automatically
deploy if the tests pass*.

I'm using that for *this talk*:

[https://github.com/UCL/rsd-talks](https://github.com/UCL/rsd-talks)

When the tests pass, the server is updated with the content from the master branch.

Safe automated deployment
--------------------------

We experimented with puppet for this. Our experience is that it's better
to use puppet to set the machine's overall structure up, but then for active deployments:

* Copy the code to the target machine with rsync (folder name based on git hash)
* Repoint a symlink to the new folder
* Service httpd restart

This can be better scripted with [Fabric](http://www.fabfile.org) or [Capistrano](http://capistranorb.com) than bash.

Continuous integration
----------------------

Simple continuous deployment from a master branch, however, breaks for multi-programmer projects.

We can use the magic of Git's branches to achieve something better:
continuous integration.

Github CI
---------

[https://github.com/UCL-RITS/RSD-Dashboard/pull/170](assets/pull170.png)

Jenkins will automatically test *each pull request*.

When the tests pass, the branch can be safely
merged to the master branch, and the deployment triggered.

(This can be manual after a code review, or *automatic
if tests pass*.)

Local Puppet Development
========================

Local development of puppet scripts
-----------------------------------

So, how can we develop puppet scripts locally, as if they were a computer program?
Unless we can locally run it, we can't
hack on it without running it on our test VM stack.

And we sure couldn't build automated tests for it.

We could, of course, use a local VM managed in a
hypervisor's GUI.

Vagrant
-------

But there's a better way, allowing us to treat
virtual machines on our local laptop, just as if they were *outputs* of a
programming exercise.

* Run a local script to provision a VM,
with *all the information in a version controlled folder*, alongside the
code for the service.
* (Ops-code and Dev-code in one place.)

*Everything* can be version controlled together,
with no information locked in GUIs.

Vagrant file
------------

``` ruby
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "server.pp"
  end
end
```

Vagrant usage
-------------

``` bash
cd my_project
vagrant up
```

Consequences
------------

This already kicks ass: we can keep our puppet manifest and vagrantfile alongside any application code. We never need to worry about
a colleague setting up dependencies for a project to get started. They can just `git clone` and then `vagrant up`

Automated Testing of Servers
============================

Automated Tests of Servers
--------------------------

Now we can commission local servers automatically,
we can define *automated tests* for the machines we provision, asserting
that they provide the services we expect.

* Run the vagrantfile to trigger the same puppet manifest as we use in production
* Only secrets and config info should differ
* Run a test script which asserts against the provided services.

Complete Example
----------------

[https://github.com/jamespjh/vagrant-puppet-example/](https://github.com/jamespjh/vagrant-puppet-example/)

Further thoughts
----------------

* Next step would be to automatically run the vagrant VM build inside Jenkins
* Push to puppet master and prun if the tests pass
* Vagrant multi-machine for an infrastructure of interacting services

Containers
==========

Docker vs Vagrant
-----------------

In the above example, our puppet scripts need a whole VM to work, so we use vagrant.

An alternative choice is to use **container** based automation, with Docker.

Here, instead of full VMs, we use a thinner layer of separation, to more
quickly build and manage isolated environments.

Docker doesn't work with our puppet scripts though (e.g.
it doesn't let you use systemd services in a container.)

Docker example
--------------

[https://github.com/jamespjh/docker-example](https://github.com/jamespjh/docker-example)

Docker on Travis

[https://travis-ci.org/jamespjh/docker-example/builds](https://travis-ci.org/jamespjh/docker-example/builds)
[https://github.com/jamespjh/docker-example/blob/master/.travis.yml](https://github.com/jamespjh/docker-example/blob/master/.travis.yml)

Conclusions
===========

Principles
----------

* Version control everything
* Make it so you can do everything locally
* Test automatically
* Trust your tests
* Tests + Deployed branches => Deployment
