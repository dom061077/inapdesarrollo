<?php
$pantalla="Usuarios"; 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php');
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
	$sql= sprintf("SELECT * FROM usuarios WHERE usuario = %s",
						GetSQLValueString($_POST['Usuario'], "text"));
	$result = mysql_query($sql, $dbo) or die(mysql_error());
	$row_Rec = mysql_fetch_assoc($result);
	$control = mysql_num_rows($result);
	mysql_free_result($result);
	if ($control > 0){
		$hasError = true;
		$errormje = "Ya existe el usuario '".strtoupper($_POST['Usuario'])."' en el sistema...";
	}
	
	$usu_ 	= $_POST['Usuario'];
	$nom_ 	= $_POST['Nombre'];
	$pas_ 	= $_POST['Password'];
	$grp_	= $_POST['Grupo'];
		
	if(!isset($hasError)) {
		$insertSQL = sprintf("INSERT INTO usuarios (usuario, nombrecompleto, password, codigogrupo) VALUES (%s, %s, %s, %s)",
					   GetSQLValueString($_POST['Usuario'], "text"),
					   GetSQLValueString($_POST['Nombre'], "text"),
                       GetSQLValueString(md5($_POST['Password']), "text"),
                       GetSQLValueString($_POST['Grupo'], "text"));
  
		mysql_select_db($database_dbo, $dbo);
		$Result1 = mysql_query($insertSQL, $dbo) or die(mysql_error());

		// ----------------------Auditoria ----------------------//
		$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
					GetSQLValueString($_SESSION['MM_Username'], "text"),
					GetSQLValueString("Agregar Usuario", "text"),
					GetSQLValueString($_POST['Usuario']." ".$_POST['Nombre'], "text"));
		$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
		// -----------------Fin de Auditoria ------------------//
  
		$insertGoTo = "usuarios.php";
  
		if (isset($_SERVER['QUERY_STRING'])) {
			$insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
			$insertGoTo .= $_SERVER['QUERY_STRING'];
		}
		//header(sprintf("Location: %s", $insertGoTo));
		unset($usu_);
		unset($nom_);
		unset($pas_);
		unset($grp_);
	}
} else {
	if (isset($_GET['error'])){
		if($_GET['error'] == 1){
			$hasError = true;
			$errormje = "No se puede eliminar el usuario ADMIN...";
		}
	}
}

mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = "SELECT u.usuario, u.nombrecompleto, u.password, u.codigogrupo, g.descripcion
FROM usuarios as u LEFT JOIN usuariogrupo as g ON (g.codigogrupo = u.codigogrupo)";
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

mysql_select_db($database_dbo, $dbo);
$query_Grupo = "SELECT codigogrupo, descripcion FROM usuariogrupo";
$Recordset2 = mysql_query($query_Grupo, $dbo) or die(mysql_error());
$row_Recordset2 = mysql_fetch_assoc($Recordset2);

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><? echo $pantalla;?></title>
<? include($path.'includes/cssyjs.php');?>
<script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script> 
<link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" /> 
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
      <td nowrap="nowrap" align="right">Usuario:</td>
      <td><span id="sprytextfield1">
        <input type="text" name="Usuario" value="<? echo $usu_; ?>" size="12" maxlength="20"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Nombre Completo:</td>
      <td><span id="sprytextfield2">
        <input type="text" name="Nombre" value="<? echo $nom_; ?>" size="12" maxlength="30"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Password:</td>
      <td><span id="sprytextfield3">
        <input type="password" name="Password" value="<? echo $pas_; ?>" size="12" maxlength="15"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<td nowrap="nowrap" align="right">Grupo:</td>	
		<td><span id="spryselect1">
	    <select name="Grupo" id="select1">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset2['codigogrupo']?>"<?php if (!(strcmp($row_Recordset2['codigogrupo'], htmlentities($grp_, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset2['descripcion']?></option>
					<?php
				} while ($row_Recordset2 = mysql_fetch_assoc($Recordset2));
				?>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
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
  <div id="sub">		
	<div id="example">
			<div class="tableFilter">
		  		<form name="form2" method="post" action="usuarios.php">Buscar por: 
					<select name="Tipo" id="column">
						<option value="1">Usuario</option>
						<option value="2">Nombre</option>
					</select>
					<input type="text" name="txtBusqueda" id="txtBusqueda" />
					<input type="submit" name="cmdBuscar" id="cmdBuscar" value="Buscar" />
					<input type="reset" value="Limpiar" />
				</form>
				<table id="myTable" cellpadding="0" cellpadding="0">
				<tr>
					<td><div align="center">Usuario</div></td>
					<td><div align="center">Nombre</div></td>
					<td><div align="center">Grupo</div></td>
				</tr>
<?php

if (isset($_POST['txtBusqueda'])) {
	$query_Recordset1 = "SELECT u.usuario, u.nombrecompleto, u.password, u.codigogrupo, g.descripcion
						FROM usuarios as u LEFT JOIN usuariogrupo as g ON (g.codigogrupo = u.codigogrupo)
						WHERE u.usuario like '%".$_POST['txtBusqueda']. "%' OR u.nombrecompleto like '%".$_POST['txtBusqueda']. "%' 
						ORDER BY u.usuario";
} else {
	$query_Recordset1 = "SELECT u.usuario, u.nombrecompleto, u.password, u.codigogrupo, g.descripcion
						FROM usuarios as u LEFT JOIN usuariogrupo as g ON (g.codigogrupo = u.codigogrupo)
						ORDER BY u.usuario";
}

$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

do {?>
	<tr>
		<td><?php echo $row_Recordset1['usuario']; ?></td>
		<td><?php echo $row_Recordset1['nombrecompleto']; ?></td>
		<td><?php echo $row_Recordset1['descripcion']; ?></td>
		<td><a href="usuarios_editar.php?id=<?php echo $row_Recordset1['usuario']; ?>"><strong><img src="images/edit.ico"/></strong></a></td>
		<td><a href="usuarios_borrar.php?id=<?php echo $row_Recordset1['usuario']; ?>" onclick="return confirm('Esta seguro que desea eliminar el usuario?');"><strong><img src="images/papel.ico"/></strong></a></td>
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

var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1");
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2");
var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3");
var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1");

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
	mysql_free_result($Recordset2);
?>