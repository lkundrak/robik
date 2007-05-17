#!/usr/bin/env perl
# NetBSD.sk bot configuration
# $Id$

use strict;

@config::Ubiqs = ('Ubiq');
@config::Revis = ('Revi');
$config::server = 'irc.upc.cz';
$config::ircname = 'Robert Fico';
@config::buddies = ('_8086');

if ($config::degug = 0) {
	@config::nicks = ('degug');
	@config::channels = ('#testbed');
} else {
	@config::nicks = ('gerda', 'robik');
	@config::channels = ('#netbsd.sk', '#include');
}

@config::ops = (
	'~xyzz@147.175.55.175',
	'~lkundrak@147.175.55.175',
	'~pyxel@147.175.55.175',
	'~e1m1@muff.zlo.sk',
	'~fellow@stezka.nettel.cz',
	'fatboy@195.168.3.218',
	'xyzz@cray.x86.sk',
	'^Ubiq@v0le.elvraba.edu.sk',
	'ado@cloudlet.imladris.sk',
	'crude@tarantula.valec.net',
	'~mato@adsl.*.dsl.nextra.sk',
	'~al.*@roa.*.dsl.club-internet.fr',
	'~sine@158.195.99.101',
	'~sine@213.151.251.83',
	'waicak@.*vutbr.cz',
	'~waico@mail.ui42.sk',
	'norbert@vcielka.rec.uniba.sk',
	'~fefo@84.16.39.226',
	'.*@stip-static-48.213-81-186.telecom.sk',
	'.*@support7.cust.nextra.sk',
	'.*sativa.morph.sk',
	'.*@193.87.19.130',
	'fellow@amee.nettel.cz',
	'crg@lagoon.freebsd.lublin.pl',
	'potion@morphium.synapsia.org',
	'potion@student.tnuni.sk',
	'xyzz@cray.x86.sk',
);

1;
