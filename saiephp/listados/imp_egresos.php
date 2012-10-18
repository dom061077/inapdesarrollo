<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

$path='../';
$pantalla='Reporte de Egresos';

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
$totalRows_consulta = mysql_num_rows($consulta);

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>EGRESOS</title>
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
	        <p align="left"><strong>INFORME DE EGRESOS - Desde el <?php echo $_GET['desde']." al ".$_GET['hasta']; ?> </strong>
            </p>
          </blockquote>
	    </blockquote>
  </tr>
</table>
<table width="100%" height="10" border="0" >
	<td><span class="phpmaker" style="font-size:small;">
	&nbsp;&nbsp;<a href='javascript:doprint()'><?php echo "Imprimir" ?></a> 
	&nbsp;&nbsp;<a href="<?php echo "exp_egresos.php?concepto=".$_GET['concepto']."&desde=".$_GET['desde']."&hasta=".$_GET['hasta'] ?>"><?php echo "Exportar a Excel" ?></a>
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
    <th scope="col">Número</th>
    <th scope="col">Comprobante</th>
    <th scope="col">Concepto</th>
    <th scope="col">Descripción</th>
    <th scope="col">Total</th>
  </tr>
  <?php 
	$i=1;
	$total=0;
  do { 
  ?>
  <tr>  
    <td bgcolor="#FFFFCC" class="cuerpo"><?php echo $i; ?></td>
    <td class="cuerpo"><?php echo fecs($row_consulta['fechacomprobante']); ?></td>
	<td class="cuerpo"><?php echo $row_consulta['numerocomprobante']; ?></td>
    <td class="cuerpo"><?php echo $row_consulta['descricompro']; ?></td>
    <td class="cuerpo"><?php echo $row_consulta['descriconcepto']; ?></td>
    <td class="cuerpo"><?php echo $row_consulta['descripcion']; ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['total'], 2, ",", "."); ?></td>
  </tr>
  <?php ++$i; $total+=$row_consulta['total']; } while ($row_consulta = mysql_fetch_assoc($consulta)); ?>
<tr>  
    <td bgcolor="#FFBB00" class="cuerpo"><strong><?php echo "Total:"; ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo"></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($total, 2, ",", "."); ?></strong></td>
  </tr>  
  
</table>
<div id="noprint" style="text-align:center">
<p><span class="phpmaker" style="font-size:small;">
&nbsp;&nbsp;<a href='javascript:doprint()'><?php echo "Imprimir" ?></a>
&nbsp;&nbsp;<a href="<?php echo "exp_egresos.php?concepto=".$_GET['concepto']."&desde=".$_GET['desde']."&hasta=".$_GET['hasta'] ?>"><?php echo "Exportar a Excel" ?></a>
&nbsp;&nbsp;<a href='javascript:history.back()' ><?php echo "Cancelar" ?></a>
</span></p>
</div>

</body>
</html>
<?php
	mysql_free_result($consulta);
?>


