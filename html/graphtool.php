<?php
include("phpgraphlib.php");
include("config.php");
$query = $_GET["query"] or die("missing query");
$diff =  $_GET["diff"] or $diff = 0;	// compute diff of result
$pos = $_GET["pos"] or $pos = 0;	// only use positive diffs
$rev = $_GET["rev"] or $rev = 0;	// reverse the result
$bar = $_GET["bar"] or $bar = 0;	// enable bar chart
$title = $_GET["title"] or $title = "";
$xinterval = $_GET["xinterval"] or $xinterval = 1;
$ymin = $_GET["ymin"] or $ymin = 0;
$ymax = $_GET["ymax"] or $ymax = 0;
?>
<HTML>
<HEAD>
<TITLE>MySQL Graph Tool</TITLE>
<STYLE>
input,textarea {
	color: blue;
	font-weight: bold;
	background: white;
}
</STYLE>
</HEAD>
<BODY>
<TABLE><TR><TD COLSPAN=6>
<IMG BORDER=1 WIDTH="100%" SRC="/graph.php?title=<?php echo $title;?>&rev=<?php echo $rev;?>&diff=<?php echo $diff;?>&pos=<?php echo $pos;?>&ymin=<?php echo $ymin;?>&ymax=<?php echo $ymax;?>&query=<?php echo $query;?>" />
</TD></TR>
<FORM METHOD=GET ACTION="graphtool.php">
<TR><TD>Title</TD><TD><INPUT CLASS="text"TYPE=TEXT SIZE=20 NAME="title" VALUE="<?php echo $title;?>" /></TD> <TD>Y Range</TD><TD><INPUT CLASS="text" TYPE=TEXT SIZE=5 NAME="ymin" VALUE="<?php echo $ymin;?>" />&ndash;<INPUT CLASS="text" TYPE=TEXT SIZE=4 NAME="ymax" VALUE="<?php echo $ymax;?>"</TD> <TD>X Interval</TD><TD><INPUT CLASS="text" TYPE=TEXT SIZE=5 NAME="xinterval" VALUE="<?php echo $xinterval;?>" /></TD></TR>
<TR><TD>Y Difference</TD><TD><INPUT CLASS="text" TYPE=TEXT NAME="diff" VALUE="<?php echo $diff;?>" /></TD> <TD>Reverse X</TD><TD><INPUT CLASS="text" TYPE=TEXT NAME="rev" VALUE="<?php echo $rev;?>" /></TD> <TD>Positive Y only</TD><TD><INPUT CLASS="text" TYPE=TEXT NAME="pos" VALUE="<?php echo $pos;?>" /></TD></TR>
<!--TR><TD>Y Difference</TD><TD><INPUT TYPE=CHECKBOX NAME="diff" VALUE="<?php echo $diff;?>" /></TD> <TD>Reverse X</TD><TD><INPUT TYPE=CHECKBOX NAME="rev" VALUE="<?php echo $rev;?>" /></TD> <TD>Positive Y only</TD><TD><INPUT TYPE=CHECKBOX NAME="pos" VALUE="<?php echo $pos;?>" /></TD></TR-->
<TR><TD><INPUT TYPE=SUBMIT VALUE="Query" /></TD><TD COLSPAN=6><TEXTAREA CLASS="text" COLS=80 ROWS=6 NAME="query"><?php echo $query;?></TEXTAREA></TD>
</FORM>
</BODY>
</HTML>
