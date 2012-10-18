<?php

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

$path='../';
$pantalla='Informe de Talonarios';

include('../includes/fechas.php');
require_once($path.'Connections/dbo.php');

mysql_select_db($database_dbo, $dbo);
$query_talonarios = "SELECT numerodesde, numerohasta FROM talonarios WHERE codigotalonario = ".$_GET['tal']." AND codigocomprobante = ".$_GET['comp'];
$talonarios_consulta = mysql_query($query_talonarios, $dbo) or die(mysql_error());
$row_talonarios = mysql_fetch_assoc($talonarios_consulta);
$tal_desde = $row_talonarios['numerodesde'];
$tal_hasta = $row_talonarios['numerohasta'];
mysql_free_result($talonarios_consulta);

$filtro = " WHERE i.fechacomprobante BETWEEN '".fece($_GET['desde'])."' AND '".fece($_GET['hasta'])."' AND codigocomprobante = ".$_GET['comp']." AND i.numerocomprobante BETWEEN ".$tal_desde." AND ".$tal_hasta;

if ($_GET['concepto']!='0')
	$filtro = $filtro." and i.codigoconcepto = '".$_GET['concepto']."'";

$filtro = $filtro." GROUP BY i.propietario, i.periodomes, i.periodoano, i.codigoconcepto 
ORDER BY i.numerocomprobante, i.periodomes, i.periodoano, i.codigoconcepto, d.manzana, d.casa";

mysql_select_db($database_dbo, $dbo);
$query_consulta = "SELECT count(*) as cantidad, MAX(i.fechacomprobante) as fechacomprobante, i.numerocomprobante, i.propietario, 
CONCAT(p.apellido, ', ', p.nombre) as nombre, i.periodomes, i.periodoano, i.codigoconcepto, c.descripcion, 
SUM(i.total) as total, p.codigopropiedad, 
CONCAT(d.manzana, ' ', d.casa) as propiedad, t.importe
FROM ingresos as i INNER JOIN propietarios as p ON (i.propietario = p.codigo)
INNER JOIN conceptos as c ON (i.codigoconcepto = c.codigoconcepto)
INNER JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad)
LEFT JOIN cuotas as t ON (t.periodomes = i.periodomes AND t.periodoano = i.periodoano) ".$filtro;
$Recordset1 = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

header('Content-type: application/vnd.ms-excel');
header("Content-Disposition: attachment; filename=Talonarios.xls");
header("Pragma: no-cache");
header("Expires: 0");
echo "<table border=1> ";
echo "<tr> ";
// Título de las columnas
echo "<th>Cantidad</th> ";
echo "<th>Fecha</th> ";
echo "<th>Comprobante</th> ";
echo "<th>Período</th> ";
echo "<th>Concepto</th> ";
echo "<th>Propiedad</th> ";
echo "<th>Propietario</th> ";
echo "<th>Pagos</th> ";
echo "<th>Importe</th> ";
echo "<th>Cuota</th> ";
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
	echo "<td>".$fecha."</td> ";
	echo "<td>".$row_Recordset1[numerocomprobante]."</td> ";
	echo "<td>".$row_Recordset1[periodomes]."/".$row_Recordset1[periodoano]."</td> ";
	echo "<td>".$row_Recordset1[descripcion]."</td> ";
	echo "<td>".$row_Recordset1[propiedad]."</td> ";
	echo "<td>".strtoupper($row_Recordset1[nombre])."</td> ";
	echo "<td>".$row_Recordset1[cantidad]."</td> ";
	echo "<td>".number_format($row_Recordset1['total'], 2, ",", ".")."</td> ";
	echo "<td>".number_format($row_Recordset1['importe'], 2, ",", ".")."</td> ";
	if ($comprobate<=$periodocor) {echo "<td>OK</td> ";} else {echo "<td>FP</td> ";};
	echo "</tr> ";
	++$i;
} while ($row_Recordset1 = mysql_fetch_assoc($Recordset1));
echo "</table> ";
mysql_free_result($Recordset1);

?>