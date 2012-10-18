<?php

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

$path='../';
$pantalla='Reporte de Ingresos';

include('../includes/fechas.php');
require_once($path.'Connections/dbo.php');

$filtro = " WHERE i.fechacomprobante BETWEEN '".fece($_GET['desde'])."' AND '".fece($_GET['hasta'])."'";

if ($_GET['panio']!='0')
	$filtro = $filtro." and i.periodoano = ".$_GET['panio'];
if ($_GET['pmes']!='0')
	$filtro = $filtro." and i.periodomes = ".$_GET['pmes'];
if ($_GET['concepto']!='0')
	$filtro = $filtro." and i.codigoconcepto = '".$_GET['concepto']."'";

$filtro = $filtro." ORDER BY i.numerocomprobante";

mysql_select_db($database_dbo, $dbo);
$query_consulta = "SELECT i.numerocomprobante, i.fechacomprobante, i.propietario, CONCAT(p.apellido, ', ', p.nombre) as nombre, i.periodomes, i.periodoano, i.codigoconcepto, c.descripcion, i.total, p.codigopropiedad, CONCAT(d.manzana, ' ', d.casa) as propiedad
FROM ingresos as i INNER JOIN propietarios as p ON (i.propietario = p.codigo)
INNER JOIN conceptos as c ON (i.codigoconcepto = c.codigoconcepto)
INNER JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad) ".$filtro;
$Recordset1 = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

header('Content-type: application/vnd.ms-excel');
header("Content-Disposition: attachment; filename=Ingresos.xls");
header("Pragma: no-cache");
header("Expires: 0");
echo "<table border=1> ";
echo "<tr> ";
// Título de las columnas
echo "<th>Cantidad</th> ";
echo "<th>Número</th> ";
echo "<th>Fecha</th> ";
echo "<th>Período</th> ";
echo "<th>Concepto</th> ";
echo "<th>Propiedad</th> ";
echo "<th>Propietario</th> ";
echo "<th>Importe</th> ";
echo "<th>Estado</th> ";
	$i=1;
do { 
	$fecha = fecs($row_Recordset1[fechacomprobante]);
	$partes = explode("/", $fecha);
	$comprobate = $partes[1]*100+$partes[2];
	$periodocor = $row_Recordset1[periodomes]*100+$row_Recordset1[periodoano];
	echo "</tr> ";
	echo "<tr> ";
	echo "<td><font color=green>".$i."</font></td> ";
	echo "<td>".$row_Recordset1[numerocomprobante]."</td> ";
	echo "<td>".$fecha."</td> ";
	echo "<td>".$row_Recordset1[periodomes]."/".$row_Recordset1[periodoano]."</td> ";
	echo "<td>".$row_Recordset1[descripcion]."</td> ";
	echo "<td>".$row_Recordset1[propiedad]."</td> ";
	echo "<td>".strtoupper($row_Recordset1[nombre])."</td> ";
	echo "<td>".number_format($row_Recordset1['total'], 2, ",", ".")."</td> ";
	if ($comprobate<=$periodocor) {echo "<td>OK</td> ";} else {echo "<td>FP</td> ";};
	echo "</tr> ";
	++$i;
} while ($row_Recordset1 = mysql_fetch_assoc($Recordset1));
echo "</table> ";
mysql_free_result($Recordset1);
?>