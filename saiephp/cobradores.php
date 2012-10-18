<?php
$pantalla="Cobradores"; 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php');
require_once('sp_funciones.php');

?>

<?php

if (!function_exists("GetSQLValueString")) {
function GetSQLValueString($theValue, $theType, $theDefinedValue = "", $theNotDefinedValue = "") 
{
  if (PHP_VERSION < 6) {
    $theValue = get_magic_quotes_gpc() ? stripslashes($theValue) : $theValue;
  }

  $theValue = function_exists("mysql_real_escape_string") ? mysql_real_escape_string($theValue) : mysql_escape_string($theValue);

  switch ($theType) {
    case "text":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;    
    case "long":
    case "int":
      $theValue = ($theValue != "") ? intval($theValue) : "NULL";
      break;
    case "double":
      $theValue = ($theValue != "") ? doubleval($theValue) : "NULL";
      break;
    case "date":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;
    case "defined":
      $theValue = ($theValue != "") ? $theDefinedValue : $theNotDefinedValue;
      break;
  }
  return $theValue;
}
}

$editFormAction = $_SERVER['PHP_SELF'];
if (isset($_SERVER['QUERY_STRING'])) {
  $editFormAction .= "?" . htmlentities($_SERVER['QUERY_STRING']);
}

if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "form1")) {
  
  $nro_generado = SP_Cobrador($_POST['Nombre'], $_POST['Direccion'], $_POST['Telefono']);

  // ----------------------Auditoria ----------------------//
	mysql_select_db($database_dbo, $dbo);
	$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Agregar Cobrador", "text"),
				GetSQLValueString("Codigo: ".$nro_generado." ".$_POST['Nombre'], "text"));
	$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
	// -----------------Fin de Auditoria ------------------//
  
  $insertGoTo = "cobradores.php";
  
  if (isset($_SERVER['QUERY_STRING'])) {
    $insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
    $insertGoTo .= $_SERVER['QUERY_STRING'];
  }
  //header(sprintf("Location: %s", $insertGoTo));
} else {
	if (isset($_GET['error'])){
		if($_GET['error'] == 1){
			$hasError = true;
			$errormje = "No se puede eliminar este cobrador porque hay datos que dependen de él...";
		}
	}
}

mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = "SELECT codigocobrador, nombre, telefono, direccion FROM cobrador ORDER BY codigocobrador";
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
 
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><? echo $pantalla;?></title>
<? include($path.'includes/cssyjs.php');
?>
<script src="../SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<link href="../SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />

</head>

<body>
<div id="contenedor">
	<div id="header">
	  <?
		$userid=$_SESSION['MM_Username'];
		$grupoid=$_SESSION['MM_UserGroup'];
	  ?>
  	</div>
 <div id="container1" >
  <h1><?php echo $pantalla;?></h1>
<form action="<?php echo $editFormAction; ?>" method="post" name="form1" id="form1">
  <table align="center">
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Nombre:</td>
      <td><span id="sprytextfield1">
        <input type="text" name="Nombre" value="" size="32" maxlength="50"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Dirección:</td>
      <td><input type="text" name="Direccion" value="" size="32" maxlength="50"/></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Teléfono:</td>
      <td><span id="sprytextfield2">
        <input type="text" name="Telefono" value="" size="32" maxlength="30"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">&nbsp;</td>
      <td><input type="submit" value="Aceptar" /></td>
    </tr>
  </table>
  <input type="hidden" name="MM_insert" value="form1" />

	<center>
	<?php if(isset($hasError)) { ?>
			<p id="mensaje"><? echo $errormje; ?></p>
	<?php } ?> 
	</center>
  
</form>
</div>
   
</div></div>
  <div id="sub">		
	<div id="example">
			<div class="tableFilter">
		  		<form name="form2" method="post" action="cobradores.php">Buscar por: 
					<select name="Tipo" id="column">
						<option value="1">C&oacute;digo</option>
						<option value="2">Nombre</option>
					</select>
					<input type="text" name="txtBusqueda" id="txtBusqueda" />
					<input type="submit" name="cmdBuscar" id="cmdBuscar" value="Buscar" />
					<input type="reset" value="Limpiar" />
				</form>
				<table id="myTable" cellpadding="0" cellpadding="0">
					<tr>
						<td><div align="center">C&oacute;digo </div></td>
						<td><div align="center">Nombre</div></td>
						<td><div align="center">Direcci&oacute;n</div></td>
						<td><div align="center">Tel&eacute;fono</div></td>
					</tr>
<?php

mysql_select_db($database_dbo, $dbo);

//"SELECT codigocobrador, nombre, telefono, direccion FROM cobrador ORDER BY codigocobrador";

if ($_POST['Tipo']==1){
	if (is_numeric($_POST['txtBusqueda'])){
		$filtro="WHERE Codigocobrador = ".$_POST['txtBusqueda']." ORDER BY codigocobrador ASC";
	}else{
		$filtro="ORDER BY codigocobrador ASC";
	}
}else{
	$filtro="WHERE nombre like '%".$_POST['txtBusqueda']. "%' ORDER BY codigocobrador ASC";
}

if (isset($_POST['txtBusqueda'])) {
	$query_Recordset1 = "SELECT codigocobrador, nombre, telefono, direccion FROM cobrador ".$filtro;
} else {
	$query_Recordset1 = "SELECT codigocobrador, nombre, telefono, direccion FROM cobrador ORDER BY codigocobrador ASC";
}
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

do {?>
	<tr>
	<td><?php echo $row_Recordset1['codigocobrador']; ?></td>
	<td><?php echo strtoupper($row_Recordset1['nombre']); ?></td>
	<td><?php echo strtoupper($row_Recordset1['direccion']); ?></td>
	<td><?php echo strtoupper($row_Recordset1['telefono']); ?></td>
	<td><a href="cobradores_editar.php?id=<?php echo $row_Recordset1['codigocobrador']; ?>"><strong><img src="images/edit.ico"/></strong></a></td>
	<td><a href="cobradores_borrar.php?id=<?php echo $row_Recordset1['codigocobrador'].'&nombre='.$row_Recordset1['nombre']; ?>" onclick="return Verificar(<? echo $row_Recordset1['codigocobrador'] ?>);"><img src="images/papel.ico"/></a></td>
	</tr>
	<?php
} while ($row_Recordset1 = mysql_fetch_assoc($Recordset1));

?>
    </div>
</div>
	  <tfoot>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
	</tfoot>
  </table>
	
  <br class="clearfloat" />
  <p class="cerrar"><a href="<?echo $path;?>principal.php">Volver</a></p>
  <br class="clearfloat" />
  <div id="footer"><p><? include($path.'includes/pie.php');?></p></div>
</div>

<script type="text/javascript">

function Verificar(regi){
	return confirm('Esta seguro que desea eliminar el registro Nº '+regi+'?');
}

var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1");
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2");

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
?>
