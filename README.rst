=======================
 el7-rsyslog-framework
=======================

--------------------------------------------------------
Configuration "framework" written in pure *RainerScript*
--------------------------------------------------------

:Author: `Matouš Jan Fialka <mjf@mjf.cz>`_
:Version: 0.3
:Date: 2016-01-08
:Manual section: 8
:Manual group: Linux System Administration

SYNOPSIS
========
*EL7 Rsyslog Framework* provides a configuration "framework" or template
written in pure *RainerScript* limited exclusively to *Rsyslog v7.4.7*
distributed with *Red Hat Enterprise Linux v7* (*RHEL7*) and it's
derivatives such as *CentOS 7*.

CAVEATS
=======
From the nature of the described limitation to a specific version many
caveats arise. To point out the least obvious:

* you **can not** use ``imrelp`` module together with *rulesets*,
* you **must** be aware of precise form of the *RainerScript*,
* you **should not** trust documentation which is fairly incomplete.

Testing your configuration before you reload or restart *Rsyslog* is
thus highly recommended! If still in doubts: "Read the source, Luke!"

DESCRIPTION
===========
The configuration is split into different domains represented by folder
hierarchy placed in ``/etc/rsyslog.d`` path. These are included from the
main ``/etc/rsyslog.conf`` configuration file in precise order. Files
eventualy placed in the ``/etc/rsyslog.d`` path are also included. Too
know the precise order, please see the ``/etc/rsyslog.conf`` file.

Only those files in the hierarchy matching the following ``glob(3)`` are
processed::

 S[0-9][0-9]-?*.conf

You may see many files starting with the letter ``K`` there too. These
files are considered as disabled, indicating their original position
for evaluation with their numbers. The reciprocal formulæ how to
calculate the ``S`` and ``K`` values are the following::

 <K-value> = 100 - <S-value>
 <S-value> = 100 - <K-value>

*Example*: To enable for instance ``K33-something.conf`` you need to
rename it to ``S77-something.conf`` and *vice versa*. This is quite
common convention, well-known from the former system-wide *initscripts*.

EXAMPLES
========
Configure server ``server.domain.tld`` to *TCP* forward all *Syslog*
messages to central server ``syslog.domain.tld``::

 $ cd /path/to/repository
 $ make
 $ sftp root@server.domain.tld:/tmp
 sftp> put el7-rsyslog-framework.tar.gz
 sftp> quit
 $ make clean
 $ ssh root@server.domain.tld
 ssh# cd /etc
 ssh# rm -rf rsyslog.*
 ssh# tar xzvf /tmp/el7-rsyslog-framework.tar.gz
 ssh# restorecon -R -F rsyslog.*
 ssh# cd rsyslog.d/
 ssh# mv rules.d/K99-forward-tcp.conf rules.d/S01-forward-tcp.conf
 ssh# sed -i 's/<remote-host>/syslog.domain.tld/' rules.d/S01-forward-tcp.conf
 ssh# rm /tmp/el7-rsyslog-framework.tar.gz
 ssh# systemctl restart rsyslog
 ssh# exit

The only change, as seen above, is enabling the *TCP* forwarding
rules and to set the server ``syslog.domain.tld``. Easy.

SYNTAX HINTS
============
Always use ``cstr()`` function if comparing *IP* address with string,
for instance the following code **will result in unpredictable result**::

 if $fromhost-ip startswith "10.0." then {
     stop
 }

The **correct way** to express the intended condition is the following::

 if cstr($fromhost-ip) startswith "10.0." then {
     stop
 }

Also be aware of the ``not`` infix operator! Always enclose the desired
expression to be negated in parentheses::

 if not(cstr($fromhost-ip) == "127.0.0.1") then {
     stop
 } 

SEE ALSO
========
- ``rsyslog.conf(5)``
- `Rsyslog Online Documentation <http://www.rsyslog.com/doc/v7-stable>`_

.. vi:ft=rst
