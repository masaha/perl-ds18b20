# perl-ds18b20
Perl - read temperature from DS18B20 sensor and output html file every minute.

Simple perl script to read output from DS18B20 sensor and make a html file with date, time and temperature. Updates every minute. 

You should modify the variables:
$sensor_out - find out by "ls /sys/bus/w1/devices" which attached sensor you have
$file - the html file you want to publish 

I run it on a Raspberry PI 2B and have two old Ipads wall mounted to display the webpage. As webserver I use lighthttpd but you can use Apache, nginx or whatever.
