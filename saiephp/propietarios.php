<?php
$pantalla="Propietarios"; 

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

	mysql_select_db($database_dbo, $dbo);
	$sql= sprintf("SELECT codigo FROM propietarios WHERE codigopropiedad = %s",
						GetSQLValueString($_POST['CodigoPropiedad'], "text"));
	$result = mysql_query($sql, $dbo) or die(mysql_error());
	$row_Rec = mysql_fetch_assoc($result);
	$control = mysql_num_rows($result);
	mysql_free_result($result);
	if ($control > 0){
		$hasError = true;
		$errormje = "Ya se asignó esa propiedad a otro propietario";
	}
	
	$ape 	= $_POST['Apellido'];
	$nom 	= $_POST['Nombre'];
	$tel 	= $_POST['Telefono'];
	$mail	= $_POST['Mail'];
	$prop	= $_POST['CodigoPropiedad'];
	$calle	= $_POST['Calle'];
	$nro	= $_POST['Numerocalle'];
	$tpo	= $_POST['Tipopago'];
	$estdo	= $_POST['Deshabilitado'];
		
	if(!isset($hasError)) {
			$nro_generado = SP_Propietario($_POST['Apellido'],
						$_POST['Nombre'],
						$_POST['Telefono'],
						$_POST['Mail'],
						$_POST['CodigoPropiedad'],
						$_POST['Calle'],
						$_POST['Numerocalle'],
						$_POST['Tipopago'],
						GetSQLValueString(isset($_POST['Deshabilitado']) ? "true" : "", "defined","1","0"));
			// ----------------------Auditoria ----------------------//
			mysql_select_db($database_dbo, $dbo);
			$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
						GetSQLValueString($_SESSION['MM_Username'], "text"),
						GetSQLValueString("Agregar Propietario", "text"),
						GetSQLValueString("Codigo: ".$nro_generado." ".$_POST['Apellido']." ".$_POST['Nombre'], "text"));
			$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
			// -----------------Fin de Auditoria ------------------//
			
			$insertGoTo = "propietarios.php";
  
			if (isset($_SERVER['QUERY_STRING'])) {
				$insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
				$insertGoTo .= $_SERVER['QUERY_STRING'];
			}
			
			//header(sprintf("Location: %s", $insertGoTo));
			
			$ape	= "";
			$nom	= "";
			$tel 	= "";
			$mail	= "";
			$prop	= "";
			$calle	= "";
			$nro	= "";
			$tpo	= "";
			unset($estdo);
	}
} else {
	if (isset($_GET['error'])){
		if($_GET['error'] == 1){
			$hasError = true;
			$errormje = "No se puede eliminar este propietario porque hay datos que dependen de él...";
		}
	}
}
mysql_select_db($database_dbo, $dbo);
$query_propiedad = "SELECT codigopropiedad, manzana, casa FROM propiedad ORDER BY Manzana, casa";
$propiedad = mysql_query($query_propiedad, $dbo) or die(mysql_error());
$row_propiedad = mysql_fetch_assoc($propiedad);
$totalRows_propiedad = mysql_num_rows($propiedad);

mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = "SELECT p.codigo, p.apellido, p.nombre, p.telefono, p.mail, p.codigopropiedad, p.calle, p.numerocalle, p.deshabilitado, d.casa, d.manzana FROM propietarios AS p LEFT JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad) ORDER BY Codigo";
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
 
mysql_select_db($database_dbo, $dbo);
$query_Recordset2 = "SELECT tipopago, descripcion FROM tipopago";
$Recordset2 = mysql_query($query_Recordset2, $dbo) or die(mysql_error());
$row_Recordset2 = mysql_fetch_assoc($Recordset2);
 
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><? echo $pantalla;?></title>
<? include($path.'includes/cssyjs.php');
?>

<script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script> 
<link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" /> 
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
      <td nowrap="nowrap" align="right">Apellido:</td>
      <td><span id="sprytextfield3">
        <input type="text" name="Apellido" value="<?php echo $ape; ?>" size="32" maxlength="50"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Nombre:</td>
      <td><span id="sprytextfield4">
        <input type="text" name="Nombre" value="<?php echo $nom; ?>" size="32" maxlength="50"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Teléfono:</td>
      <td><input type="text" name="Telefono" value="<?php echo $tel; ?>" size="32" maxlength="50"/></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Mail:</td>
      <td><input type="text" name="Mail" value="<?php echo $mail ?>" size="32" maxlength="50"/></td>
    </tr>
	<tr valign="baseline">
		<td nowrap="nowrap" align="right">Propiedad:</td>	
		<td><span id="spryselect1">
	    <select name="CodigoPropiedad" id="select1">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_propiedad['codigopropiedad']?>"<?php if (!(strcmp($row_propiedad['codigopropiedad'], htmlentities($prop, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_propiedad['manzana']." ".$row_propiedad['casa']?></option>
					<?php
				} while ($row_propiedad = mysql_fetch_assoc($propiedad));
			 ?>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Calle:</td>
      <td><input type="text" name="Calle" value="<?php echo $calle ?>" size="32" maxlength="50"/></td>
    </tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Calle Nº:</td>
      <td><span id="sprytextfield6">
	  <input type="text" name="Numerocalle" value="<?php echo $nro ?>" size="12" maxlength="8"/></span></td>
    </tr>
	<tr valign="baseline">
		<td nowrap="nowrap" align="right">Tipo pago:</td>	
		<td><span id="spryselect2">
	    <select name="Tipopago" id="select1">
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset2['tipopago']?>"<?php if (!(strcmp($row_Recordset2['tipopago'], htmlentities($tpo, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset2['descripcion']?></option>
					<?php
				} while ($row_Recordset2 = mysql_fetch_assoc($Recordset2));
			 ?>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Deshabilitado:</td>
      <td><input type="checkbox" name="Deshabilitado" value="" <?php if (isset($estdo)) {echo "checked";} ?> /></td>
	</tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">&nbsp;</td>
      <td><input type="submit" value="Aceptar" /></td>
    </tr>
  </table>
  <input type="hidden" name="MM_insert" value="form1" />
</form>

	<center>
	<?php if(isset($hasError)) { ?>
			<p id="mensaje"><? echo $errormje; ?></p>
	<?php } ?> 
	</center>

</div>
   
</div></div>
  <div id="suba">		
	<div id="example">
			<div class="tableFilter">
		  		<form name="form2" method="post" action="propietarios.php">Buscar por: 
					<select name="Tipo" id="column">
						<option value="2">Nombre</option>
						<option value="1">C&oacute;digo</option>
						<option value="3">Manzana</option>
					</select>
					<input type="text" name="txtBusqueda" id="txtBusqueda" />
					<input type="submit" name="cmdBuscar" id="cmdBuscar" value="Buscar" />
					<input type="reset" value="Limpiar" />
				</form>
				<table id="myTable" cellpadding="0" cellpadding="0">
				<tr>
					<td><div align="center">C&oacute;digo </div></td>
					<td><div align="center">Nombre</div></td>
					<td><div align="center">Calle</div></td>
					<td><div align="center">Propiedad</div></td>
					<td><div align="center">E-mail</div></td>
					<td><div align="center">Teléfono</div></td>
					<td><div align="center">Tipo pago</div></td>
				</tr>
<?php

mysql_select_db($database_dbo, $dbo);

//"SELECT p.codigo, p.apellido, p.nombre, p.telefono, p.mail, p.codigopropiedad, p.calle, p.numerocalle, p.deshabilitado, d.casa, d.manzana FROM propietarios AS p LEFT JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad) ORDER BY Codigo"

if ($_POST['Tipo']==1){
	if (is_numeric($_POST['txtBusqueda'])){
		$filtro="WHERE p.codigo = ".$_POST['txtBusqueda']." ORDER BY codigo ASC";
	}else{
		$filtro="ORDER BY p.codigo ASC";
	}
}elseif($_POST['Tipo']==2){
		$filtro="WHERE p.apellido like '%".$_POST['txtBusqueda']. "%' ORDER BY p.codigo ASC";
	}else{
		$filtro="WHERE d.manzana like '%".$_POST['txtBusqueda']. "%' ORDER BY d.manzana ASC, d.casa ASC";
}

if (isset($_POST['txtBusqueda'])) {
	$query_Recordset1 = "SELECT p.codigo, p.apellido, p.nombre, p.telefono, p.mail, p.codigopropiedad, p.calle, p.numerocalle, p.deshabilitado, d.casa, d.manzana, p.tipopago, t.descripcion
FROM propietarios as p 
LEFT JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad)
LEFT JOIN tipopago as t ON (p.tipopago = t.tipopago) ".$filtro;
} else {
	$query_Recordset1 = "SELECT p.codigo, p.apellido, p.nombre, p.telefono, p.mail, p.codigopropiedad, p.calle, p.numerocalle, p.deshabilitado, d.casa, d.manzana, p.tipopago, t.descripcion
FROM propietarios as p 
LEFT JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad)
LEFT JOIN tipopago as t ON (p.tipopago = t.tipopago) ORDER BY p.codigo ASC";
}
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

do {?>
	<tr> 
	<td><?php echo $row_Recordset1['codigo']; ?></td>
	<td><?php echo strtoupper($row_Recordset1['apellido'].", ".$row_Recordset1['nombre']); ?></td>
	<td><?php echo strtoupper($row_Recordset1['calle'])." ".$row_Recordset1['numerocalle']; ?></td>
	<td><?php echo strtoupper($row_Recordset1['casa'])." | ".$row_Recordset1['manzana']; ?></td>
	<td><?php echo $row_Recordset1['mail']; ?></td>
	<td><?php echo $row_Recordset1['telefono']; ?></td>
	<td><?php echo $row_Recordset1['descripcion']; ?></td>
	<td><a href="propietarios_editar.php?id=<?php echo $row_Recordset1['codigo']; ?>"><strong><img src="images/edit.ico"/></strong></a></td>
    <td><a href="propietarios_borrar.php?id=<?php echo $row_Recordset1['codigo'].'&nombre='.$row_Recordset1['apellido'].' '.$row_Recordset1['nombre']; ?>" onclick="return confirm('Esta seguro que desea eliminar el registro?');"><strong><img src="images/papel.ico"/></strong></a></td>
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

var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1");
var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3");
var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4");
//var sprytextfield6 = new Spry.Widget.ValidationTextField("sprytextfield6", "integer", {useCharacterMasking:true, validateOn:["change"]});
var spryselect2 = new Spry.Widget.ValidationSelect("spryselect2");

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
	mysql_free_result($propiedad);
	mysql_free_result($Recordset2);
?>
