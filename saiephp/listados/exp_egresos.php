<?php

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

$path='../';
$pantalla='Egresos';

include('../includes/fechas.php');
require_once($path.'Connections/dbo.php');

$filtro = " WHERE e.fechacomprobante BETWEEN '".fece($_GET['desde'])."' AND '".fece($_GET['hasta'])."'";

if ($_GET['concepto']!= '0')
	$filtro = $filtro." AND e.codigoconcepto = '".$_GET['concepto']."'";

$filtro = $filtro." ORDER BY e.fechacomprobante, e.codigoegreso";

mysql_select_db($database_dbo, $dbo);
$query_consulta = "SELECT e.codigoegreso, e.fechacomprobante, e.codigocomprobante, c.descripcion as descricompro, e.numerocomprobante, e.codigoconcepto, t.descripcion as descriconcepto, e.descripcion, e.total
FROM egresos as e INNER JOIN comprobantes as c ON (c.codigocomprobante = e.codigocomprobante)
INNER JOIN conceptos as t ON (t.codigoconcepto = e.codigoconcepto) ".$filtro;

$consulta = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_consulta = mysql_fetch_assoc($consulta);

header('Content-type: application/vnd.ms-excel');
header("Content-Disposition: attachment; filename=Egresos.xls");
header("Pragma: no-cache");
header("Expires: 0");
echo "<table border=1> ";
echo "<tr> ";
// Título de las columnas
echo "<th>Cantidad</th> ";
echo "<th>Fecha</th> ";
echo "<th>Número</th> ";
echo "<th>Comprobante</th> ";
echo "<th>Concepto</th> ";
echo "<th>Descripción</th> ";
echo "<th>Total</th> ";
	$i=1;
do { 
	echo "</tr> ";
	echo "<tr> ";
	echo "<td><font color=green>".$i."</font></td> ";
	echo "<td>".$row_consulta[fechacomprobante]."</td> ";
	echo "<td>".$row_consulta[numerocomprobante]."</td> ";
	echo "<td>".$row_consulta[descricompro]."</td> ";
	echo "<td>".$row_consulta[descriconcepto]."</td> ";
	echo "<td>".$row_consulta[descripcion]."</td> ";
	echo "<td>".number_format($row_consulta['total'], 2, ",", ".")."</td> ";
	echo "</tr> ";
	++$i;
} while ($row_consulta = mysql_fetch_assoc($consulta));
echo "</table> ";
	
	mysql_free_result($consulta);
?>