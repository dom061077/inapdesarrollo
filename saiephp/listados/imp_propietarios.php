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
<title>LISTADO DE PROPIETARIOS</title>
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
	        <p align="left"><strong>LISTADO DE PROPIETARIOS AL </strong><?php echo date("j/n/Y"); ?> </strong>
            </p>
          </blockquote>
	    </blockquote>
  </tr>
</table>
<table width="100%" height="10" border="0" >
	<td><span class="phpmaker" style="font-size:small;">
	&nbsp;&nbsp;<a href='javascript:doprint()'><?php echo "Imprimir" ?></a> 
	&nbsp;&nbsp;<a href="<?php echo "exp_propietarios.php?orden=".$_GET['orden']."&activo=".$_GET['activo'] ?>"><?php echo "Exportar a Excel" ?></a>
	&nbsp;&nbsp;<a href='javascript:history.back()' ><?php echo "Cancelar" ?></a></span></td>
	<td><div align="right">
	<span class="phpmaker" style="font-size:small; color: #0000FF;">
	&nbsp;<a align="right"><?php echo "Usuario:  ".$_SESSION['MM_Username']. "  ".date("d/m/Y H:i"); ?></a></span></div></td>
</table>
<table width="100%" height="10" border="0" bgcolor="#CCCCCC"></table>
<table width="100%" border="1" cellspacing="0" cellpadding="1" style="font-size:small;">
  <tr bgcolor="#FFFFCC">
    <th bgcolor="#FFFFCC" scope="col">Código</th>
    <th scope="col">Apellido y Nombre</th>
	<th scope="col">Teléfono</th>
    <th scope="col">mail</th>
    <th scope="col">Propiedad</th>
    <th scope="col">Calle</th>
    <th scope="col">Calle Nº</th>
    <th scope="col">Estado</th>
  </tr>
  <?php do { ?>
  <tr>  
    <td bgcolor="#FFFFCC" class="cuerpo"><?php echo $row_consulta['codigo']; ?></td>
    <td class="cuerpo"><?php echo strtoupper($row_consulta['apellido']).", ".strtoupper($row_consulta['nombre']); ?></td>
    <td class="cuerpo"><?php echo $row_consulta['telefono']; ?></td>
	<td class="cuerpo"><?php echo $row_consulta['mail']; ?></td>
    <td class="cuerpo"><?php echo $row_consulta['casa']."  ".$row_consulta['manzana']; ?></td>
    <td class="cuerpo"><?php echo $row_consulta['calle']; ?></td>
    <td class="cuerpo"><?php echo $row_consulta['numerocalle']; ?></td>
    <td class="cuerpo"><?php if ($row_consulta['deshabilitado']==0) {echo "H";} else {echo "D";}; ?></td>
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
&nbsp;&nbsp;<a href="<?php echo "exp_propietarios.php?orden=".$_GET['orden']."&activo=".$_GET['activo'] ?>"><?php echo "Exportar a Excel" ?></a>
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
