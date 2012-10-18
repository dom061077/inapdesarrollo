<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

$path='';
$pantalla='Reporte de Auditor&iacute;a';

include('../includes/fechas.php');
require_once($path.'../Connections/dbo.php');

if (!empty($_GET['dato'])){
	$otro = " AND upper(tipotransaccion) LIKE '%".$_GET['dato']."%' OR upper(descripcion) LIKE '%".$_GET['dato']."%' ";
} else {
	$otro = "";
}

if ($_GET['usu'] != '-1')
   $f_usu = " AND usuario = '".$_GET['usu']."' ";
else
   $f_usu = "";

$filtro = "WHERE fecha BETWEEN '".fece($_GET['desde'])."' AND '".fece($_GET['hasta'])." 23:59:59'".$otro;

mysql_select_db($database_dbo, $dbo);
$query_consulta = "SELECT id, usuario, fecha, tipotransaccion, descripcion  FROM logging ".$filtro.$f_usu;
$consulta = mysql_query($query_consulta, $dbo) or die(mysql_error());
$row_consulta = mysql_fetch_assoc($consulta);
$totalRows_consulta = mysql_num_rows($consulta);

function ShowMessage() {
		$sMessage = $this->getMessage();
		$this->Message_Showing($sMessage);
		if ($sMessage <> "") { // Message in Session, display
			echo "<p><span class=\"ewMessage\">" . $sMessage . "</span></p>";
			$_SESSION[EW_SESSION_MESSAGE] = ""; // Clear message in Session
		}
	}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>LISTADO DE AUDITORIA</title>
<script type="text/javascript">
function doprint() {
window.print();
}
</script>
</head>

<body>
<table width="100%" border="0" cellpadding="5" bgcolor="#E6E6E6">
      <tr>
		<td width="35%" height="63" align="center" valign="top"><img src="images/logo.png" width="163" height="53" alt="logo" /></td>
	    <td align="left" valign="top" width="65%"><blockquote>
	      <blockquote>
	        <p align="left"><strong>LISTADO DE AUDITORIA - Desde el <?php echo $_GET['desde']." al ".$_GET['hasta']; ?></strong>
            </p>
          </blockquote>
	    </blockquote>
  </tr>
</table>
<table width="100%" height="10" border="0" >
	<td><span class="phpmaker" style="font-size:small;">
	&nbsp;&nbsp;<a href='javascript:doprint()'><?php echo "Imprimir" ?></a> 
	&nbsp;&nbsp;<a href='javascript:history.back()' ><?php echo "Cancelar" ?></a></span></td>
	<td><div align="right">
	<span class="phpmaker" style="font-size:small; color: #0000FF;">
	&nbsp;<a align="right"><?php echo "Usuario:  ".$_SESSION['MM_Username']. "  ".date("d/m/Y H:i"); ?></a></span></div></td>
</table>
<table width="100%" height="10" border="0" bgcolor="#CCCCCC"></table>

<!--
<table width="100%" height="10" border="0" bgcolor="#CCCCCC">
	<span class="phpmaker" style="font-size:small;">
		&nbsp;&nbsp;<a href='javascript:doprint()'><?php echo "Imprimir" ?></a>
		&nbsp;&nbsp;<a href='javascript:history.back()' ><?php echo "Cancelar" ?></a>
		&nbsp;&nbsp;<a align="right"><?php echo "Usuario:  ".$_SESSION['MM_Username']. "  ".date("d/m/Y H:i"); ?></a>
	</span>
</table>
-->
<table width="100%" border="1" cellspacing="0" cellpadding="1" style="font-size:small;">
  <tr bgcolor="#FFFFCC">
    <th bgcolor="#FFFFCC" scope="col">Código</th>
    <th scope="col">Usuario</th>
	<th scope="col">Fecha</th>
    <th scope="col">Tipo transacción</th>
    <th scope="col">Descripción</th>
  </tr>
  <?php 
  do { ?>
  <tr>  
    <td bgcolor="#FFFFCC" class="cuerpo"><?php echo $row_consulta['id']; ?></td>
    <td class="cuerpo"><?php echo $row_consulta['usuario']; ?></td>
    <td class="cuerpo"><?php echo fecshs($row_consulta['fecha']); ?></td>
	<td class="cuerpo"><?php echo $row_consulta['tipotransaccion']; ?></td>
    <td class="cuerpo"><?php echo $row_consulta['descripcion']."  ".$row_consulta['manzana']; ?></td>
  </tr>
  <?php } while ($row_consulta = mysql_fetch_assoc($consulta)); ?>
</table>
<!--
<p>&nbsp;</p>
<div id="noprint" style="text-align:center">
      <input type="button" name="imprimir" value="Imprimir" onclick="doprint()" />
	  <input type="button" name="excel" value="Exp.Excel" onclick="location.href='exp_propietarios.php'"/>
      <input type="button" name="cancelar" value="Cancelar" onclick="history.back();"/>
</div>-->
<div id="noprint" style="text-align:center">
<p><span class="phpmaker" style="font-size:small;">
&nbsp;&nbsp;<a href='javascript:doprint()'><?php echo "Imprimir" ?></a>
&nbsp;&nbsp;<a href='javascript:history.back()' ><?php echo "Cancelar" ?></a>
</span></p>
</div>

</body>
</html>
<?php
mysql_free_result($consulta);
?>



<!-- Font codes by Quackit.com 
style="white-space: nowrap;"
<p >Absolute size - xx-small</p>
<p style="font-size:x-small;">Absolute size - x-small</p>
<p style="font-size:small;">Absolute size - small</p>
<p style="font-size:medium;">Absolute size - medium</p>
<p style="font-size:large;">Absolute size - large</p>
<p style="font-size:x-large;">Absolute size - x-large</p>
<p style="font-size:xx-large;">Absolute size - xx-large</p>
-->
