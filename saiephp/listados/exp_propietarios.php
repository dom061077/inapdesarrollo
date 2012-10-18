<?php

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

$path='../';
$pantalla='Reporte de Propietarios';

require_once($path.'Connections/dbo.php');

switch ($_GET['activo']) {
	case 1:
		$filtro = " ";
		break;
	case 2:
		$filtro = " WHERE p.deshabilitado = 0 ";
		break;
	case 3:
		$filtro = " WHERE p.deshabilitado = 1 ";
		break;
}

if (isset($_GET['orden'])){
	$nombre = "ORDER BY ".$_GET['orden'];
} else {
	$nombre = "";
}

mysql_select_db($database_dbo, $dbo);
$query_consulta = "SELECT p.codigo, p.apellido, p.nombre, p.telefono, p.mail, p.codigopropiedad, 
p.calle, p.numerocalle, p.deshabilitado, d.casa, d.manzana FROM propietarios AS p LEFT JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad) ".$filtro.$nombre;
$Recordset1 = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

header('Content-type: application/vnd.ms-excel');
header("Content-Disposition: attachment; filename=propietarios.xls");
header("Pragma: no-cache");
header("Expires: 0");
echo "<table border=1> ";
echo "<tr> ";
// Título de las columnas
echo "<th>Código</th> ";
echo "<th>Nombre</th> ";
echo "<th>Teléfono</th> ";
echo "<th>e-mail</th> ";
echo "<th>Propiedad</th> ";
echo "<th>Calle</th> ";
echo "<th>Número</th> ";
echo "<th>Casa</th> ";
echo "<th>Manzana</th> ";
echo "<th>Estado</th> ";
do {
	echo "</tr> ";
	echo "<tr> ";
	echo "<td><font color=green>".$row_Recordset1[codigo]."</font></td> ";
	echo "<td>".strtoupper($row_Recordset1[apellido]).", ".strtoupper($row_Recordset1[nombre])."</td> ";
	echo "<td>".$row_Recordset1[telefono]."</td> ";
	echo "<td>".$row_Recordset1[mail]."</td> ";
	echo "<td>".$row_Recordset1[codigopropiedad]."</td> ";
	echo "<td>".$row_Recordset1[calle]."</td> ";
	echo "<td>".$row_Recordset1[numerocalle]."</td> ";
	echo "<td>".$row_Recordset1[casa]."</td> ";
	echo "<td>".$row_Recordset1[manzana]."</td> ";
	if ($row_Recordset1['deshabilitado']==0) {echo "<td>H</td> ";} else {echo "<td>D</td> ";};
	echo "</tr> ";
} while ($row_Recordset1 = mysql_fetch_assoc($Recordset1));
echo "</table> ";
mysql_free_result($Recordset1);
?>