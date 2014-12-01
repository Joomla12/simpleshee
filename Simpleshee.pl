#!/usr/bin/perl -w
#Special thanks to Auze (https://github.com/Auze) for bansheeX.

use strict;
use Xchat qw( :all);

register('Simpleshee', '1.0', 'A very basic script for announcing Banshee\'s currently playing song.');

hook_command('np', \&np);

sub np {
	
	my $run = &btest();
	if ($run == 0) {
	
		my $rawtitle = substr(`banshee --query-title`, 7);
		my $title = substr($rawtitle,0, length($rawtitle) -1);
		
		my $rawartist = substr(`banshee --query-artist`, 8);
		my $artist = substr($rawartist,0,length($rawartist) -1);
		
		my $rawalbum = substr(`banshee --query-album`, 7);
		my $album= substr($rawalbum,0,length($rawalbum) -1);

		my $rawstatus = substr(`banshee --query-current-state`, 15);
		my $status = substr($rawstatus,0,length($rawstatus) -1);
		
		my $listening ="is listening to \cB$title\cB"." by \cB$artist\cB"." from \cB$album\cB";
		command("me $listening");
	}
}

# Test if Banshee currently running
sub btest {
	`pidof banshee`;
	my $btest = $?;
	if ($btest == 0) { 
		return 0;
	}
	else {
		command("echo Banshee is not currently running.");
		return 1;
	}
}

