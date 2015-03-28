Packer-crewmate
===================

Automation recipe building crewmate running environment
with Packer.
Now it is only tested on Docker.

Dependency
------------

* Packer 0.7.5 or later
* Docker 1.3.3 or later

Here is a limitation on Packer 0.7.5 that works only on <= 1.3.3.
If you are willing to use Docker 1.5 and later, please consult 
on Packer issue 1993
(https://github.com/mitchellh/packer/pull/1993)

* Vagrant

Running
---------

To make doker image export `crewmate.tar`,

```bash
$ packer build --only=docker crewmate.json
```


License
-----------

The MIT License (MIT)

Copyright (c) 2015 Hiroshi Miura 


Contributors
-------------




