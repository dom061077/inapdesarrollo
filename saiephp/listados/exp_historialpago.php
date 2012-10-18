<?php

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

$path='../';
$pantalla='Historial de Pago';

include('../includes/fechas.php');
require_once($path.'Connections/dbo.php');

if ($_GET['concepto'] != '-1')
   $filtro = " AND i.codigoconcepto = '".$_GET['concepto']."' ";
else
   $filtro = "";

$query = "SELECT CONCAT(p.manzana, ' ', p.casa) AS propiedad,
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 1  AND i.propietario = t.codigo".$filtro.") AS 'ene',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 2  AND i.propietario = t.codigo".$filtro.") AS 'feb',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 3  AND i.propietario = t.codigo".$filtro.") AS 'mar',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 4  AND i.propietario = t.codigo".$filtro.") AS 'abr',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 5  AND i.propietario = t.codigo".$filtro.") AS 'may',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 6  AND i.propietario = t.codigo".$filtro.") AS 'jun',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 7  AND i.propietario = t.codigo".$filtro.") AS 'jul',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 8  AND i.propietario = t.codigo".$filtro.") AS 'ago',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 9  AND i.propietario = t.codigo".$filtro.") AS 'sep',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 10 AND i.propietario = t.codigo".$filtro.") AS 'oct',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 11 AND i.propietario = t.codigo".$filtro.") AS 'nov',
(SELECT SUM(i.total) FROM ingresos AS i WHERE i.periodoano = ".$_GET['anio']." AND i.periodomes = 12 AND i.propietario = t.codigo".$filtro.") AS 'dic'
FROM propietarios AS t INNER JOIN propiedad AS p ON p.codigopropiedad = t.codigopropiedad
ORDER BY p.manzana, p.casa";

mysql_select_db($database_dbo, $dbo);
$query_consulta = $query;
$Recordset1 = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

header('Content-type: application/vnd.ms-excel');
header("Content-Disposition: attachment; filename=Historial.xls");
header("Pragma: no-cache");
header("Expires: 0");
echo "<table border=1> ";
echo "<tr> ";
// Título de las columnas
echo "<th>Casa/Per.</th> ";
echo "<th>Ene</th> ";
echo "<th>Feb</th> ";
echo "<th>Mar</th> ";
echo "<th>Abr</th> ";
echo "<th>May</th> ";
echo "<th>Jun</th> ";
echo "<th>Jul</th> ";
echo "<th>Ago</th> ";
echo "<th>Sep</th> ";
echo "<th>Oct</th> ";
echo "<th>Nov</th> ";
echo "<th>Dic</th> ";
do { 
	echo "</tr> ";
	echo "<tr> ";
	echo "<td>".$row_Recordset1['propiedad']."</td> ";
	echo "<td>".number_format($row_Recordset1['ene'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['feb'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['mar'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['abr'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['may'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['jun'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['jul'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['ago'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['sep'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['oct'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['nov'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['dic'], 2, ",", ".")."</td> ";
	echo "</tr> ";
	++$i;
} while ($row_Recordset1 = mysql_fetch_assoc($Recordset1));
echo "</table> ";
mysql_free_result($Recordset1);
?>