<!DOCTYPE HTML>
<HTML>
<!-- IEEE-123 realtime simulation configuration
     Copyright (C) 2016, Stanford University
     Author: dchassin@slac.stanford.edu
-->
<TITLE>GridLAB-D Realtime Server</TITLE>
<BODY>
<H1>Welcome</H1>
The following simulations are currently running on this server:
<TABLE CELLSPACING=10 WIDTH="100%">
<TR><TH>Model<HR/></TH><TH>Loads<HR/></TH><TH>Solar panels<HR/></TH><TH>Webpage<HR/></TH><TH>Database<HR/></TH><TH>Status<HR/></TH><TH>Load<HR/></TH></TR>
<TR><TD>IEEE 123</TD><TD>Static</TD><TD>No</TD><TD><A TARGET="_blank" HREF="http://gridlabd.slac.stanford.edu:6266/rt/control.htm">http://gridlabd.slac.stanford.edu:6266/rt/control.htm</A></TD><TD><A TARGET="_blank" HREF=data>gridlabd_ro@gridlabd.slac.stanford.edu:3306/ieee123z_{model,ami,scada}</A></TD><TD ALIGN=CENTER><?php passthru('/home/gridlabd/bin/gridlabd-ctl -q status model-6266');?></TD><TD ALIGN=RIGHT><?php passthru('/home/gridlabd/bin/gridlabd-ctl -qq status model-6266');?></TD></TR>
<TR><TD>IEEE 123</TD><TD>Dynamic</TD><TD>No</TD><TD><A TARGET="_blank" HREF="http://gridlabd.slac.stanford.edu:6267/rt/control.htm">http://gridlabd.slac.stanford.edu:6267/rt/control.htm</A></TD><TD><A TARGET="_blank" HREF=data>gridlabd_ro@gridlabd.slac.stanford.edu:3306/ieee123_{model,ami,scada}</A></TD><TD ALIGN=CENTER><?php passthru('/home/gridlabd/bin/gridlabd-ctl -q status model-6267');?></TD><TD ALIGN=RIGHT><?php passthru('/home/gridlabd/bin/gridlabd-ctl -qq status model-6267');?></TD></TR>
<TR><TD>IEEE 123</TD><TD>Dynamic</TD><TD>Yes</TD><TD><A TARGET="_blank" HREF="http://gridlabd.slac.stanford.edu:6268/rt/control.htm">http://gridlabd.slac.stanford.edu:6268/rt/control.htm</A></TD><TD><A TARGET="_blank" HREF=data>gridlabd_ro@gridlabd.slac.stanford.edu:3306/ieee123s_{model,ami,scada}</A></TD><TD ALIGN=CENTER><?php passthru('/home/gridlabd/bin/gridlabd-ctl -q status model-6268');?></TD><TD ALIGN=RIGHT><?php passthru('/home/gridlabd/bin/gridlabd-ctl -qq status model-6268');?></TD></TR>
<TR><TD>IEEE 123</TD><TD>Static</TD><TD>Yes</TD><TD><A TARGET="_blank" HREF="http://gridlabd.slac.stanford.edu:6269/rt/control.htm">http://gridlabd.slac.stanford.edu:6269/rt/control.htm</A></TD><TD><A TARGET="_blank" HREF=data>gridlabd_ro@gridlabd.slac.stanford.edu:3306/ieee123zs_{model,ami,scada}</A></TD><TD ALIGN=CENTER><?php passthru('/home/gridlabd/bin/gridlabd-ctl -q status model-6269');?></TD><TD ALIGN=RIGHT><?php passthru('/home/gridlabd/bin/gridlabd-ctl -qq status model-6269');?></TD></TR>
</TABLE>

<HR/>
<TABLE WIDTH="100%"><TR>
<TD ALIGN=LEFT>Source: <A HREF="https://code.stanford.edu/gridlabd/ieee123">https://code.stanford.edu/gridlabd/ieee123</A></TD>
<TD ALIGN=CENTER>Last fetch: <?php passthru("cat ~gridlabd/.update-info");?></TD>
<TD ALIGN=RIGHT>Last build: <?php passthru("stat -c '%y' ~gridlabd/.update-info | cut -c1-19,30-");?></TD>
</TD>
</TR>
</TABLE>

</HTML>

