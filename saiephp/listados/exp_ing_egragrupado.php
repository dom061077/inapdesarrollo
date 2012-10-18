<?php

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

$path='../';
$pantalla='Reporte de Ingresos y Egresos';

include('../includes/fechas.php');
require_once($path.'Connections/dbo.php');

$filtro1 = " WHERE i.fechacomprobante BETWEEN '".fece($_GET['desde'])."' AND '".fece($_GET['hasta'])."' ";
$filtro2 = " WHERE e.fechacomprobante BETWEEN '".fece($_GET['desde'])."' AND '".fece($_GET['hasta'])."' ";


mysql_select_db($database_dbo, $dbo);
$query_consulta = "SELECT i.codigoconcepto, c.descripcion, SUM(i.total) AS ingreso, 0 AS egreso
FROM ingresos as i INNER JOIN propietarios as p ON (i.propietario = p.codigo)
INNER JOIN conceptos as c ON (i.codigoconcepto = c.codigoconcepto) ".$filtro1." GROUP BY i.codigoconcepto 
UNION 
SELECT e.codigoconcepto, t.descripcion AS descriconcepto, 0 AS ingreso, SUM(e.total) AS egreso
FROM egresos as e INNER JOIN conceptos as t ON (t.codigoconcepto = e.codigoconcepto) ".$filtro2." GROUP BY e.codigoconcepto 
ORDER BY descripcion";

$Recordset1 = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

header('Content-type: application/vnd.ms-excel');
header("Content-Disposition: attachment; filename=IngresosEgresos.xls");
header("Pragma: no-cache");
header("Expires: 0");
echo "<table border=1> ";
echo "<tr> ";
// Título de las columnas
echo "<th>Cantidad</th> ";
echo "<th>Concepto</th> ";
echo "<th>Descripcion</th> ";
echo "<th>Ingreso</th> ";
echo "<th>Egreso</th> ";
echo "<th>Saldo</th> ";
	$i=1;
	$total=0;
do { 
	$fecha = fecs($row_Recordset1[fechacomprobante]);
    $total+=($row_Recordset1['ingreso']-$row_Recordset1['egreso']); 
	echo "</tr> ";
	echo "<tr> ";
	echo "<td><font color=green>".$i."</font></td> ";
	echo "<td>".$row_Recordset1[codigoconcepto]."</td> ";
	echo "<td>".$row_Recordset1[descripcion]."</td> ";
	echo "<td>".$row_Recordset1[ingreso]."</td> ";
	echo "<td>".$row_Recordset1[egreso]."</td> ";
	echo "<td>".$total."</td> ";
	echo "</tr> ";
	++$i;
} while ($row_Recordset1 = mysql_fetch_assoc($Recordset1));
echo "</table> ";
mysql_free_result($Recordset1);
?>