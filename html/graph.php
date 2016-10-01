<!-- IEEE-123 realtime simulation configuration
     Copyright (C) 2016, Stanford University
     Author: dchassin@slac.stanford.edu
-->
<?php
include("phpgraphlib.php");

$my_server = 'localhost';
$my_user = 'gridlabd_ro';
$my_pwd = 'gridlabd';
$query = $_GET["query"] or die("missing query");
$diff =  $_GET["diff"] or $diff = 0;	// compute diff of result
$pos = $_GET["pos"] or $pos = 0;	// only use positive diffs
$rev = $_GET["rev"] or $rev = 0;	// reverse the result
$bar = $_GET["bar"] or $bar = 0;	// enable bar chart
$title = $_GET["title"] or $title = "";
$xinterval = $_GET["xinterval"] or $xinterval = 1;
$ymin = $_GET["ymin"] or $ymin = 0;
$ymax = $_GET["ymax"] or $ymax = 0;

$link = mysql_connect($my_server, $my_user, $my_pwd)
	or die("mysql_connect('$my_server','$my_user','$my_pwd') failed: " . mysql_error());
     
$data=array();
  
$result = mysql_query($query)
	or die("mysql_query('$query') failed: " . mysql_error());
if ($result) 
{
	$count = 0;
	while ($row = mysql_fetch_assoc($result)) 
	{
		$x = $row["x"];
		$y = $row["y"];
		if ( $diff != 0 )
		{
      			if ( $count > 0 )
			{
				if ( $pos == 0 || ($yy > $y) )
					$data[$x] = $yy - $y;
			}
			$yy = $y;
		}
		else
		{
			$data[$x] = $y;
		}
		$count++;
	}
}
if ( $rev != 0 )
{
	$data = array_reverse($data,true);
}
  
$graph=new PHPGraphLib(1800,1200); 
$graph->setLine($bar==0);
$graph->setBars($bar==1);
$graph->addData($data);
$graph->setGradient("lime", "green");
$graph->setBarOutlineColor("black");
$graph->setBackgroundColor("white");
if ( strlen($title) > 0 )
	$graph->setTitle($title);
$graph->setXValuesInterval(intval(preg_replace('[^0-9]','',$xinterval)));
if ( $ymin < $ymax )
	$graph->setRange($ymax,$ymin);
$graph->createGraph();
?>
