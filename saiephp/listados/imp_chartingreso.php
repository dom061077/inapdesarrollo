<?php

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

	
	$path='../';

	include($path.'includes/fechas.php');
	require_once($path.'Connections/dbo.php');
	
	
$query = "SELECT 
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 1) AS 'ene',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 2) AS 'feb',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 3) AS 'mar',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 4) AS 'abr',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 5) AS 'may',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 6) AS 'jun',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 7) AS 'jul',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 8) AS 'ago',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 9) AS 'sep',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 10) AS 'oct',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 11) AS 'nov',
(SELECT IF(ISNULL(SUM(i.total)),0,SUM(i.total)) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 12) AS 'dic'";
   
mysql_select_db($database_dbo, $dbo);
$query_consulta = $query;
$consulta = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_consulta = mysql_fetch_assoc($consulta);
		
$a_i  = array(	$row_consulta['ene'], $row_consulta['feb'], 
				$row_consulta['mar'], $row_consulta['abr'], 
				$row_consulta['may'], $row_consulta['jun'], 
				$row_consulta['jul'], $row_consulta['ago'], 
				$row_consulta['sep'], $row_consulta['oct'], 
				$row_consulta['nov'], $row_consulta['dic']); 
mysql_free_result($consulta);
				
$query = "SELECT 
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE  YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 1  ) AS 'ene',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE  YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 2  ) AS 'feb',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 3  ) AS 'mar',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 4  ) AS 'abr',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 5  ) AS 'may',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 6  ) AS 'jun',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 7  ) AS 'jul',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 8  ) AS 'ago',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 9  ) AS 'sep',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 10 ) AS 'oct',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 11 ) AS 'nov',
(SELECT IF(ISNULL(SUM(total)),0,SUM(total)) FROM egresos WHERE YEAR(fechacomprobante) = ".$_GET['anio']." AND MONTH(fechacomprobante) = 12 ) AS 'dic'";
				
$query_consulta = $query;
$consulta = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_consulta = mysql_fetch_assoc($consulta);
				
$a_e = array(	$row_consulta['ene'], $row_consulta['feb'], 
				$row_consulta['mar'], $row_consulta['abr'], 
				$row_consulta['may'], $row_consulta['jun'], 
				$row_consulta['jul'], $row_consulta['ago'], 
				$row_consulta['sep'], $row_consulta['oct'], 
				$row_consulta['nov'], $row_consulta['dic']); 
mysql_free_result($consulta);
	
?>

<!DOCTYPE html>
<html>
  <head>
    <style type="text">
    </style>
    <title>:: Chart I-E ::</title>

		<link href="../css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../js/jquery.min.js"></script> 
		<script type="text/javascript" src="../js/highcharts.js"></script> 
		
		<script type="text/javascript" src="../js/modules/exporting.js"></script>

		<script type="text/javascript">
		
			var chart;
			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						renderTo: 'container',
						defaultSeriesType: 'line',
						marginRight: 130,
						marginBottom: 25
					},
					title: {
						text: 'INGRESOS Y EGRESOS POR PERIODO',
						x: -20 //center
					},
					subtitle: {
						text: 'Montos por período - <?php echo $_GET['anio'];?> -',
						x: -20
					},
					xAxis: {
						categories: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 
									 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic']
					},
					yAxis: {
						title: {
							text: 'Importes ($)'
						},
						plotLines: [{
							value: 0,
							width: 1,
							color: '#808080'
						}]
					},
					tooltip: {
						formatter: function() {
				                return '<b>'+ this.series.name +'</b><br/>'+
								this.x +': $'+ this.y;
						}
					},
					legend: {
						layout: 'vertical',
						align: 'right',
						verticalAlign: 'top',
						x: 0,
						y: 100,
						borderWidth: 0
					},
					series: [{
						name: 'Ingreso',
						data:[	<?php echo $a_i[0];  ?>,
								<?php echo $a_i[1];  ?>,
								<?php echo $a_i[2];  ?>,
								<?php echo $a_i[3];  ?>,
								<?php echo $a_i[4];  ?>,
								<?php echo $a_i[5];  ?>,
								<?php echo $a_i[6];  ?>,
								<?php echo $a_i[7];  ?>,
								<?php echo $a_i[8];  ?>,
								<?php echo $a_i[9];  ?>,
								<?php echo $a_i[10]; ?>,
								<?php echo $a_i[11]; ?>
								]
					}, {
						name: 'Egreso',
						data:[	<?php echo $a_e[0];  ?>,
								<?php echo $a_e[1];  ?>,
								<?php echo $a_e[2];  ?>,
								<?php echo $a_e[3];  ?>,
								<?php echo $a_e[4];  ?>,
								<?php echo $a_e[5];  ?>,
								<?php echo $a_e[6];  ?>,
								<?php echo $a_e[7];  ?>,
								<?php echo $a_e[8];  ?>,
								<?php echo $a_e[9];  ?>,
								<?php echo $a_e[10]; ?>,
								<?php echo $a_e[11]; ?>
								]
					}]
				});
				
				
			});
				
		</script>
	

	</head>
	<body>
<br></br>
		<div id="container" style="width: 900px; height: 400px; margin: 0 auto"></div>
		
	<div>
		<br class="clearfloat" />
			<p class="cerrar"><a href="inf_chartingresos.php">Volver</a></p>
				<br class="clearfloat" />
				<div id="footer"><p><? include('../includes/pie.php');?></p></div>
	</div>
	</body>
</html>