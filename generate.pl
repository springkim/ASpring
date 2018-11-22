#!C:/Strawberry/perl/bin/perl.exe
use strict;
use warnings;
use feature qw(say);
use CGI;

my $cgi=new CGI;

my $language=$cgi->param('language');	#c,cpp,mfc,perl,python
my $file=$cgi->param('file');
my $project=$cgi->param('project');
my $owner=$cgi->param('owner');
my $group=$cgi->param('group');
my $type=$cgi->param("type");	#implement,header

$file="(file)" if $file eq "";
$project="(project)" if $project eq "";
$owner="(name)" if $owner eq "";
$group="(group)" if $group eq "";

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime;
$year+=1900;
$mon+=1;

my $xdate=sprintf("%x_%x_%x",$year,$mon,$mday);
my $define=uc $project.'_'.$xdate.'_'.uc $file."_HPP_INCLUDED";
$define=~ s/ /_/g;



sub CommentOfH(){
        my $ret;
        $ret="/*
*  $file.h
*  $project
*
*  Created by $owner on $year. $mon. $mday...
*  Copyright $year $group. All rights reserved.
*
*/
#if !defined($define)
#define $define
#include&ltstdio.h&gt
#include&ltstdlib.h&gt
#include&ltstring.h&gt
#endif  //$define
";      
        return $ret;
}
sub CommentOfC(){
        my $ret;
        $ret="/*
*  $file.c
*  $project
*
*  Created by $owner on $year. $mon. $mday...
*  Copyright $year $group. All rights reserved.
*
*/
#include\"$file.h\"
";
        return $ret;
}

sub CommentOfHPP(){
	my $ret;
	$ret="/*
*  $file.hpp
*  $project
*
*  Created by $owner on $year. $mon. $mday...
*  Copyright $year $group. All rights reserved.
*
*/
#if !defined($define)
#define $define
#include&ltiostream&gt
#include&ltvector&gt
#include&ltstring&gt
#endif  //$define
";
	return $ret;
}
sub CommentOfCPP(){
	my $ret;
        $ret="/*
*  $file.cpp
*  $project
*
*  Created by $owner on $year. $mon. $mday...
*  Copyright $year $group. All rights reserved.
*
*/
#include\"$file.hpp\"
";
	return $ret;
}
sub CommentOfMFC(){
        my $ret;
        $ret="/*
*  $file.cpp
*  $project
*
*  Created by $owner on $year. $mon. $mday...
*  Copyright $year $group. All rights reserved.
*
*/
#include\"stdafx.h\"
#include\"$file.hpp\"\

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif
";
	return $ret;
}
sub CommentOfMFC_H(){
        my $ret;
        $ret="/*
*  $file.hpp
*  $project
*
*  Created by $owner on $year. $mon. $mday...
*  Copyright $year $group. All rights reserved.
*
*/
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#if !defined($define)
#define $define
#include&ltafxwin.h&gt
//TODO...
#endif  //$define
"; 
}
sub CommentOfPERL(){
	my $ret;
	$ret="#!/usr/bin/perl
#  $file.pl
#  $project
#
#  Created by $owner on $year. $mon. $mday...
#  Copyright $year $group. All rights reserved.
#
use strict;
use warnings;
use feature qw(say);
";
	return $ret;
}

print $cgi->header(-charset=>'UTF-8');

my $comment;
if($type eq "implement"){
	
	$comment=CommentOfC if($language eq "c");
	$comment=CommentOfCPP if($language eq "cpp");
	$comment=CommentOfMFC if($language eq "mfc");
	$comment=CommentOfPERL if($language eq "perl");
}else{
	
	$comment=CommentOfH if($language eq "c");
	$comment=CommentOfHPP if($language eq "cpp");
	$comment=CommentOfMFC_H if($language eq "mfc");
}

print $comment;
