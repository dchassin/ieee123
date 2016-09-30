This project will install a realtime simulation of the IEEE 123-bus test feeder 
on a RedHat EL6 system.  You must use the latest version of GridLAB-D, as 
well as MySQL server.  See the GridLAB-D wiki pages for details.

Building GridLAB-D
------------------
GridLAB should be built from and installed to the home directory of the gridlabd
user. If you have not already done so, you must create a gridlabd user on the
host system.

  > host% sudo adduser -s /bin/bash -m -U gridlabd

The recommended build sequence after the mysql server is setup is

  > host% sudo su gridlabd

  > host% svn co http://code.sf.net/p/gridlab-d/code/trunk ~gridlabd/trunk

  > host% cd ~gridlabd/trunk

  > host% autoreconf -isf

  > host% ./configure --enable-silent-rules --prefix=~gridlabd --with-mysql=/usr/lib64/mysql 'CXXFLAGS=-I/usr/include/mysql -w -O3' 'CFLAGS=-I/usr/include/mysql -w -O3'

  > host% make install

  > host% make validate

Installing IEEE123
------------------
The ieee123 project Makefile will install both the model files and the service
control files.  After installation you must start the gridlabd service with the
command

  > host% sudo service gridlabd start
  
Connecting
----------

The main control page is reached by directing your web browser to the system's
home page:

  > http://hostname/

