#!/usr/bin/env perl
# NetBSD.sk bot
# $Id$

use warnings;
use strict;

use Net::IRC;
use POSIX;

my $Ubiq = 'Ubiq';
my $Revi = 'Revi';
my $me = 'gerda';

my $irc = new Net::IRC;
my $conn = $irc->newconn (
	'Nick'		=> $me,
	'Server'	=> 'irc.nextra.sk',
	'Ircname'	=> 'Robert Fico',
);

$conn->add_handler('public', \&msg);
$conn->add_handler('msg', \&msg);
$conn->add_default_handler(\&logit);
# nicknameinuse endofmotd motd 

$conn->join ('#testbed');
#$conn->join ('#NetBSD.sk');

sub wtf
{
	my $argument = shift;
	$argument =~ s/\'//g;
	`PATH=/usr/games:/bin:/usr/bin:/usr/sbin wtf '$argument' 2>&1`;
}

sub command
{
	$_ = shift;

	/^wtf\s+(.*)/ and return wtf ($1);
	/^version/ and return '$Revision$';
#	/^join\s+(\S+)$/ and return $conn->join ($1);
#	/^part\s+(\S+)\s*(\S*)$/ and return $conn->part ("$1 $2");
#	/^quit\s+(\S*)$/ and return $conn->quit ("$1 $2");
	/^say\s+(\S+)\s*(.*)$/ and return $conn->privmsg ($1, $2);

	'(Not Understood)';
}

sub answer
{
	my ($to, $from, $text) = @_;
	my @text = split /\n/,$text;

	foreach (@text) {
		if ($to eq $me) {	# query
	 		$conn->privmsg ($from, $_);
		} else {		# channel
		 	$conn->privmsg ($to, "$from: $_");
		}
	}
}

sub msg
{
	my ($conn, $event) = @_;
	my ($message) = $event->args;
	my ($to) = $event->to;
	my $from = $event->nick;
	my $response = '';

	$_ = $message;

	if ($to eq $me) {
		$response = command ($_);
	} else {
		/^$me(:\s*)?(.*)/ and $response = command ($2);
	}

	if (/(.*), ani srnky netusia co \'([^\']+)\'/) {
		my ($caller, $arg) = ($1, $2);
		my $wtf = wtf ($arg);

		$response = ''; # not a command

		if ($wtf =~ /^wtf,/) {
			answer ($to, $caller, "Skutocne nevedia.");
		} else {
 			$conn->privmsg ($Revi, "wtf $arg = $wtf");
			answer ($to, $caller, "Skus teraz, teraz uz mozno vedia.");
		}
	}

	answer ($to, $from, $response);
}

sub logit
{
	my ($conn, $event) = @_;

	my $date = `date '+%D %T'`;
	chomp $date;
	
	open (LOG, '>>/tmp/robik.log');
	print LOG $date.' '.$event->type.":\t";
	foreach ($event->args) {
		print LOG "\t$_";
	}
	print LOG "\n";
	close (LOG);
}

sub daemonize {
	chdir ('/');
	open (STDIN, '/dev/null');
	open (STDOUT, '>>/dev/null');
	open (STDERR, '>>/dev/null');

    	fork () and exit (0);
	POSIX::setsid ();
}

daemonize ();
$irc->start ();
