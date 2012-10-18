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

if ($_GET['concepto'] != '-1'){
   $conc = " Concepto: ".$_GET['concepto'];
   $filtro = " AND i.codigoconcepto = '".$_GET['concepto']."' ";
}else{
   $conc = "";
   $filtro = "";
}

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
$consulta = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_consulta = mysql_fetch_assoc($consulta);
$totalRows_consulta = mysql_num_rows($consulta);

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>::Historial de Pago::</title>
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
	        <p align="left"><strong>HISTORIAL DE PAGO - Período <?php echo $_GET['anio'].$conc;?> </strong>
            </p>
          </blockquote>
	    </blockquote>
  </tr>
</table>
<table width="100%" height="10" border="0" >
	<td><span class="phpmaker" style="font-size:small;">
	&nbsp;&nbsp;<a href='javascript:doprint()'><?php echo "Imprimir" ?></a> 
	&nbsp;&nbsp;<a href="<?php echo "exp_historialpago.php?concepto=".$_GET['concepto']."&anio=".$_GET['anio']?>"><?php echo "Exportar a Excel" ?></a>
	&nbsp;&nbsp;<a href='javascript:history.back()' ><?php echo "Cancelar" ?></a></span></td>
	<td><div align="right">
	<span class="phpmaker" style="font-size:small; color: #0000FF;">
	&nbsp;<a align="right"><?php echo "Usuario:  ".$_SESSION['MM_Username']. "  ".date("d/m/Y H:i"); ?></a></span></div></td>
</table>
<table width="100%" height="10" border="0" bgcolor="#CCCCCC"></table>
<table width="100%" border="1" cellspacing="0" cellpadding="1" style="font-size:small;">
  <tr bgcolor="#FFFFCC">
    <th bgcolor="#FFFFCC" scope="col">Casa/Per.</th>
    <th scope="col">Ene</th>
	<th scope="col">Feb</th>
    <th scope="col">Mar</th>
    <th scope="col">Abr</th>
    <th scope="col">May</th>
    <th scope="col">Jun</th>
    <th scope="col">Jul</th>
    <th scope="col">Ago</th>
    <th scope="col">Sep</th>
    <th scope="col">Oct</th>
    <th scope="col">Nov</th>
    <th scope="col">Dic</th>
  </tr>
  <?php
	$t_ene = 0;
	$t_feb = 0;
	$t_mar = 0;
	$t_abr = 0;
	$t_may = 0;
	$t_jun = 0;
	$t_jul = 0;
	$t_ago = 0;
	$t_sep = 0;
	$t_oct = 0;
	$t_nov = 0;
	$t_dic = 0;
  do { 
  ?>
  <tr>  
    <td bgcolor="#FFFFCC" class="cuerpo"><?php echo $row_consulta['propiedad']; ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['ene'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['feb'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['mar'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['abr'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['may'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['jun'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['jul'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['ago'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['sep'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['oct'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['nov'], 2, ",", "."); ?></td>
    <td class="cuerpo" align="right"><?php echo number_format($row_consulta['dic'], 2, ",", "."); ?></td>
  </tr>
  <?php 
	$t_ene+=$row_consulta['ene'];	
	$t_feb+=$row_consulta['feb'];	
	$t_mar+=$row_consulta['mar'];	
	$t_abr+=$row_consulta['abr'];	
	$t_may+=$row_consulta['may'];	
	$t_jun+=$row_consulta['jun'];	
	$t_jul+=$row_consulta['jul'];	
	$t_ago+=$row_consulta['ago'];	
	$t_sep+=$row_consulta['sep'];	
	$t_oct+=$row_consulta['oct'];	
	$t_nov+=$row_consulta['nov'];	
	$t_dic+=$row_consulta['dic'];	
	} while ($row_consulta = mysql_fetch_assoc($consulta)); ?>
<tr>  
    <td bgcolor="#FFBB00" class="cuerpo"><strong><?php echo "Total:"; ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_ene, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_feb, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_mar, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_abr, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_may, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_jun, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_jul, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_ago, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_sep, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_oct, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_nov, 2, ",", "."); ?></strong></td>
	<td bgcolor="#FFBB00" class="cuerpo" align="right"><strong><?php echo number_format($t_dic, 2, ",", "."); ?></strong></td>
  </tr>  
  
</table>
<div id="noprint" style="text-align:center">
<p><span class="phpmaker" style="font-size:small;">
&nbsp;&nbsp;<a href='javascript:doprint()'><?php echo "Imprimir" ?></a>
&nbsp;&nbsp;<a href="<?php echo "exp_historialpago.php?concepto=".$_GET['concepto']."&anio=".$_GET['anio']?>"><?php echo "Exportar a Excel" ?></a>
&nbsp;&nbsp;<a href='javascript:history.back()' ><?php echo "Cancelar" ?></a>
</span></p>
</div>

</body>
</html>
<?php
mysql_free_result($consulta);
?>


