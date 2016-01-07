=======================
 el7-rsyslog-framework
=======================

--------------------------------------------------------
Configuration "framework" written in pure *RainerScript*
--------------------------------------------------------

:Author: `Matouš Jan Fialka <mjf@mjf.cz>`_
:Version: 0.1
:Date: 2016-01-05
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
Standard **non-forwarding** server (this is the default)::

 rsyslog.d/globals.d:
 S01-common.conf

 rsyslog.d/inputs.d:
 K30-nginx.conf
 K99-imtcp.conf
 K99-imudp.conf
 S01-imuxsock-journal.conf

 rsyslog.d/modules.d:
 K99-imfile.conf
 K99-imtcp.conf
 K99-imudp.conf
 S01-imjournal.conf
 S01-imklog.conf
 S01-imuxsock.conf

 rsyslog.d/rules.d:
 K01-fallback-remote.conf
 K70-nginx.conf
 K99-forward-tcp.conf
 K99-forward-udp.conf
 S99-fallback-local.conf

 rsyslog.d/templates.d:
 K90-nginx-local.conf
 K90-nginx-remote.conf
 K99-remote.conf
 S01-local.conf

Standard **central** server::

 rsyslog.d/globals.d:
 S01-common.conf

 rsyslog.d/inputs.d:
 K30-nginx.conf
 K99-imudp.conf
 S01-imtcp.conf
 S01-imuxsock-journal.conf

 rsyslog.d/modules.d:
 K99-imudp.conf
 S01-imfile.conf
 S01-imjournal.conf
 S01-imklog.conf
 S01-imtcp.conf
 S01-imuxsock.conf

 rsyslog.d/rules.d:
 K70-nginx.conf
 K99-forward-tcp.conf
 K99-forward-udp.conf
 S99-fallback-local.conf
 S99-fallback-remote.conf

 rsyslog.d/templates.d:
 K90-local-nginx.conf
 K90-remote-nginx.conf
 S01-local.conf
 S01-remote.conf

SEE ALSO
========
- ``rsyslog.conf(5)``
- `Rsyslog Online Documentation <http://www.rsyslog.com/doc/v7-stable>`_

.. vi:ft=rst
