<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

$path='../';
$pantalla='Reporte de Talonarios';

include('../includes/fechas.php');
require_once($path.'Connections/dbo.php');

// Buscamos el rango del talonario para filtrar los comprobantes
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

$consulta = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_consulta = mysql_fetch_assoc($consulta);
$totalRows_consulta = mysql_num_rows($consulta);

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Listado de Talonarios</title>
<script type="text/javascript">
function doprint() {
window.print();
}
</script>
</head>

<body>
<table width="100%" border="0" cellpadding="5" bgcolor="#E6E6E6">
      <tr>
		<td width="35%" height="63" align="center" valign="top"><img src="../images/logo.png" width="163" height="53" alt="logo" /></td>
	    <td align="left" valign="top" width="65%"><blockquote>
	      <blockquote>
	        <p align="left"><strong>LISTADO DE TALONARIOS - Desde el <?php echo $_GET['desde']." al ".$_GET['hasta']; ?> </strong>
            </p>
          </blockquote>
	    </blockquote>
  </tr>
</table>
<table width="100%" height="10" border="0" >
	<td><span class="phpmaker" style="font-size:small;">
	&nbsp;&nbsp;<a href='javascript:doprint()'><?php echo "Imprimir" ?></a> 
	&nbsp;&nbsp;<a href="<?php echo "exp_talonarios.php?concepto=".$_GET['concepto']."&desde=".$_GET['desde']."&hasta=".$_GET['hasta']."&comp=".$_GET['comp']."&tal=".$_GET['tal'] ?>"><?php echo "Exportar a Excel" ?></a>
	&nbsp;&nbsp;<a href='javascript:history.back()' ><?php echo "Cancelar" ?></a></span></td>
	<td><div align="right">
	<span class="phpmaker" style="font-size:small; color: #0000FF;">
	&nbsp;<a align="right"><?php echo "Usuario:  ".$_SESSION['MM_Username']. "  ".date("d/m/Y H:i"); ?></a></span></div></td>
</table>
<table width="100%" height="10" border="0" bgcolor="#CCCCCC"></table>
<table width="100%" border="1" cellspacing="0" cellpadding="1" style="font-size:small;">
  <tr bgcolor="#FFFFCC">
    <th bgcolor="#FFFFCC" scope="col">Cantidad</th>
	<th scope="col">Fecha</th>
	<th scope="col">Comprobante</th>
    <th scope="col">Período</th>
    <th scope="col">Concepto</th>
    <th scope="col">Propiedad</th>
    <th scope="col">Propietario</th>
    <th scope="col">Pagos</th>
    <th scope="col">Importe</th>
    <th scope="col">Cuota</th>
    <th scope="col">Estado</th>
  </tr>
  <?php 
	$i=1;
	$total=0;
  do { 
	$fecha = fecs($row_consulta['fechacomprobante']);
	$partes = explode("/", $fecha);
	$comprobate = $partes[1]*100+$partes[2];
	$periodocor = $row_consulta['periodomes']*100+$row_consulta['periodoano'];
  ?>
  <tr>  
    <td bgcolor="#FFFFCC" class="cuerpo"><?php echo $i; ?></td>
    <td class="cuerpo"><?php echo fecs($row_consulta['fechacomprobante']); ?></td>
    <td class="cuerpo"><?php echo $row_consulta['numerocomprobante']; ?></td>
	<td class="cuerpo"><?php echo $row_consulta['periodomes']."/".$row_consulta['periodoano']; ?></td>
    <td class="cuerpo"><?php echo $row_consulta['descripcion']."  ".$row_consulta['manzana']; ?></td>
    <td class="cuerpo"><?php echo $row_consulta['propiedad']; ?></td>
    <td class="cuerpo"><?php echo strtoupper($row_consulta['nombre']); ?></td>
    <td class="cuerpo"><?php echo $row_consulta['cantidad']; ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['total'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['importe'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="center"><?php if ($comprobate<=$periodocor) {echo "OK";} else {echo "FP";} ?></td>
  </tr>
  <?php ++$i; $total+=$row_consulta['total']; } while ($row_consulta = mysql_fetch_assoc($consulta)); ?>
<tr>  
    <td bgcolor="#FFBB00" class="cuerpo"><strong><?php echo "Total:"; ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($total, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
  </tr>  
  
</table>

<div id="noprint" style="text-align:center">
<p><span class="phpmaker" style="font-size:small;">
&nbsp;&nbsp;<a href='javascript:doprint()'><?php echo "Imprimir" ?></a>
&nbsp;&nbsp;<a href="<?php echo "exp_talonarios.php?concepto=".$_GET['concepto']."&desde=".$_GET['desde']."&hasta=".$_GET['hasta']."&comp=".$_GET['comp']."&tal=".$_GET['tal'] ?>"><?php echo "Exportar a Excel" ?></a>
&nbsp;&nbsp;<a href='javascript:history.back()' ><?php echo "Cancelar" ?></a>
</span></p>
</div>

</body>
</html>
<?php
mysql_free_result($consulta);
?>


