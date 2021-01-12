#!/usr/bin/perl -w
#
# Script to read temparute output from DS18B20 file and reformat for publishing on web-page
#
use strict;
use POSIX qw(strftime);
#
# Define which files to use for reading sensor data
# ls /sys/bus/w1/devices should show the attached sensors 
my $sensor_out='/sys/devices/w1_bus_master1/28-0214687041ff/w1_slave';
# Where to put the html file
my $file='/var/www/html/temp.html';
my $temp_out;
my $timestamp;
#
#
#Subroutine to read temp from DS18B20
#
sub readtemp() {
        open(my $file_in, '<',$sensor_out) or warn "Couldn't open $sensor_out\n";
        while (<$file_in>) {
                chomp;
                /t\=(-?\d+)/;
                $temp_out = $1;
                }
return $temp_out;
}
#
#Subroutine to output in html format
#
sub htmlput {
my $var1=shift;
my $var2=shift;
open(FH, '>', "$file") or warn "cannot open file";
select FH;
# The html output
print <<ENDHTML;
<!DOCTYPE html>
<html>
<style>
body 	{background-color: Black;}
h1 	{color: Lavender;
	font-family: verdana;
	font-size: 230%;
	}	
h2 	{color: Lavender;
	font-family: verdana;
	font-size: 550%;
	}	
.container { 
  height: 650px;
  position: relative;
  border: none; 
}

.center {
  margin: 0;
  position: absolute;
  top: 50%;
  left: 50%;
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
}
</style>
<head>
<title>Temperatur</title>
<meta http-equiv="refresh" content="60">
<meta name="apple-mobile-web-app-capable" content="yes">
</head>
<body>
<div class="container"> 
	<div class="center">
<h1>$var2
<br>
<br>
<br></h1>
<center><h2>$var1 &#8451</h2>
	</div>
</div>
</body>
</html>
ENDHTML
close FH;
return;
}

#
# Main loop
#
while (1) {
	$timestamp=strftime "%a %d %B %R", localtime;;
	my $out=readtemp();
	$out=sprintf("%.1f",$out/1000);
	htmlput($out,$timestamp);
	sleep 60;
	}
exit 0;
