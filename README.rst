-----------------------
 EL7 Rsyslog Framework
-----------------------

Synopsis
========
*EL7 Rsyslog Framework* provides a configuration "framework" or template
written in pure *RainerScript* limited exclusively to *Rsyslog v7.4.7*
distributed with *Red Hat Enterprise Linux v7* (*RHEL7*) and it's
derivatives such as *CentOS 7*.

Caveats
-------
From the nature of the described limitation to a specific version many
caveats arise. To point out the least obvious:

- you **can not** use ``imrelp`` module together with *rulesets*,
- you **must** be aware of precise form of the *RainerScript*,
- you **should not** trust documentation which is fairly incomplete.

Testing your configuration before you reload or restart *Rsyslog* is
thus highly recommended! If still in doubts: "Read the source, Luke!"

Configuration
=============
The configuration is split into different domains represented by folder
hierarchy placed in ``/etc/rsyslog.d`` path. These are included from the
main ``/etc/rsyslog.conf`` configuration file in precise order

Only those files in the hierarchy matching the following ``glob(3)`` are
processed::

 S[0-9][0-9]-?*.conf

You can see many files starting with the letter ``K`` there too. These
files are considered as disabled, indicating their original position
for evaluation with their numbers. The reciprocal formulæ how to
calculate the ``S`` and ``K`` values are the following::

 <K-value> = 100 - <S-value>
 <S-value> = 100 - <K-value>

*Example*: To enable for instance ``K33-something.conf`` you need to
rename it to ``S77-something.conf`` and *vice versa*. This is quite
common convention, well-known from the former system-wide *initscripts*.

.. vi:ft=rst
