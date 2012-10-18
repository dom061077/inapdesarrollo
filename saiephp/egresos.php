<?php
$pantalla="Egresos"; 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php');
include('includes/fechas.php');
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
	/*mysql_select_db($database_dbo, $dbo);
	$sql= sprintf("SELECT * FROM egresos WHERE codigocomprobante = %s AND numerocomprobante = %s",
						GetSQLValueString($_POST['Comprobante'], "text"),
						GetSQLValueString($_POST['Numero'], "text"));
	$result = mysql_query($sql, $dbo) or die(mysql_error());
	$row_Rec = mysql_fetch_assoc($result);
	$control = mysql_num_rows($result);
	mysql_free_result($result);*/
	if ($control > 0){
		$hasError = true;
		$errormje = "Ya se ingres&oacute; ese n&uacute;mero de comprobante";
	}
	
	$fcha 	= $_POST['Fecha'];
	$com	= $_POST['Comprobante'];
	$num 	= $_POST['Numero'];
	$con	= $_POST['Concepto'];
	$des	= $_POST['Descripcion'];
	$tot	= $_POST['Total'];
		
	if(!isset($hasError)) {
		$nro_generado = SP_Egresos(fece($_POST['Fecha']), $_POST['Comprobante'], $_POST['Numero'], $_POST['Concepto'], $_POST['Descripcion'], $_POST['Total']);

		mysql_select_db($database_dbo, $dbo);
		// ----------------------Auditoria ----------------------//
		$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Agregar Egreso", "text"),
				GetSQLValueString("Codigo: ".$nro_generado." ".$_POST['Fecha']." Nro:".$_POST['Numero']." Concepto:".$_POST['Concepto'], "text"));
		$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
		// -----------------Fin de Auditoria ------------------//

		$insertGoTo = "egresos.php";
  
		if (isset($_SERVER['QUERY_STRING'])) {
			$insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
			$insertGoTo .= $_SERVER['QUERY_STRING'];
		}
		unset($fcha);
		unset($com);
		unset($num);
		unset($con);
		unset($des);
		unset($tot);
		//header(sprintf("Location: %s", $insertGoTo));
	}
}

mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = "SELECT e.codigoegreso, e.fechacomprobante, e.fechacarga, e.codigocomprobante, e.numerocomprobante, e.codigoconcepto, e.estado, e.total
FROM egresos as e LEFT JOIN comprobantes as c ON (e.codigocomprobante = c.codigocomprobante)
LEFT JOIN conceptos as t ON (e.codigoconcepto = t.codigoconcepto)";
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

mysql_select_db($database_dbo, $dbo);
$query_Comprobantes = "SELECT codigocomprobante, descripcion FROM comprobantes WHERE tipo = 2 ORDER BY descripcion";
$Recordset2 = mysql_query($query_Comprobantes, $dbo) or die(mysql_error());
$row_Recordset2 = mysql_fetch_assoc($Recordset2);
 
mysql_select_db($database_dbo, $dbo);
$query_Conceptos = "SELECT codigoconcepto, descripcion FROM conceptos WHERE tipo = 2 ORDER BY codigoconcepto";
$Recordset3 = mysql_query($query_Conceptos, $dbo) or die(mysql_error());
$row_Recordset3 = mysql_fetch_assoc($Recordset3);

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><? echo $pantalla;?></title>
<? include($path.'includes/cssyjs.php');?>

<link type="text/css" rel="stylesheet" href="dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"></link>
<script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script> 
<link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>

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
			<td nowrap="nowrap" align="right">Fecha comprobante:</td>
			<td><span id="sprytextfield3">
			<input type="text" name="Fecha" value="<? echo $fcha; ?>" size="10" onChange="" onBlur="" />
			<span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span></span>
			<input type="button" value="Cal" onclick="displayCalendar(document.forms[0].Fecha,'dd/mm/yyyy',this)"></td>
        </tr>
		
		<td nowrap="nowrap" align="right">Comprobante:</td>	
		<td><span id="spryselect1">
	    <select name="Comprobante" id="spryselect1">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset2['codigocomprobante']?>"<?php if (!(strcmp($row_Recordset2['codigocomprobante'], htmlentities($com, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset2['descripcion']?></option>
					<?php
				} while ($row_Recordset2 = mysql_fetch_assoc($Recordset2));
				?>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
		</tr>

		<tr valign="baseline">
		<td nowrap="nowrap" align="right">N&uacute;mero:</td>
			<td><span id="sprytextfield1">
				<input type="text" name="Numero" value="<? echo $num; ?>" size="12" maxlength="8"/>
		<span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
		</tr>
	
		<td nowrap="nowrap" align="right">Concepto:</td>	
		<td><span id="spryselect2">
	    <select name="Concepto" id="spryselect2">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset3['codigoconcepto']?>"<?php if (!(strcmp($row_Recordset3['codigoconcepto'], htmlentities($con, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset3['descripcion']?></option>
					<?php
				} while ($row_Recordset3 = mysql_fetch_assoc($Recordset3));
				?>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
		</tr>

		<tr valign="baseline">
		<td nowrap="nowrap" align="right">Descripci&oacute;n:</td>
			<td><span id="sprytextfield1">
				<input type="text" name="Descripcion" value="<? echo $des; ?>" size="20" maxlength="50"/>
		</span></td>
		</tr>
		
		<tr valign="baseline">
		<td nowrap="nowrap" align="right">Total ($):</td>
		<td><span id="sprytextfield2">
			<input type="text" name="Total" value="<? echo $tot; ?>" size="12" maxlength="8"/>
		<span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
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
		  		<form name="form2" method="post" action="egresos.php">Buscar por: 
					<select name="Tipo" id="column">
						<option value="1">C&oacute;digo</option>
						<option value="2">Coprobante</option>
						<option value="3">N&uacute;mero</option>
					</select>
					<input type="text" name="txtBusqueda" id="txtBusqueda" />
					<input type="submit" name="cmdBuscar" id="cmdBuscar" value="Buscar" />
					<input type="reset" value="Limpiar" />
				</form>
				<table id="myTable" cellpadding="0" cellpadding="0">
				<tr>
					<td><div align="center">C&oacute;digo </div></td>
					<td><div align="center">Comprobante</div></td>
					<td><div align="center">N&uacute;mero</div></td>
				</tr>
<?php

mysql_select_db($database_dbo, $dbo);

$sql_count="SELECT MAX(codigoegreso) as total FROM egresos";
$Rec= mysql_query($sql_count, $dbo) or die(mysql_error());
$row_Rec= mysql_fetch_assoc($Rec);
$cant=$row_Rec['total']-10;

if (($_POST['Tipo']==1) ||($_POST['Tipo']==3)) {
	if (is_numeric($_POST['txtBusqueda'])) {
		$filtro="WHERE e.numerocomprobante = ".$_POST['txtBusqueda']." OR e.codigoegreso = ".$_POST['txtBusqueda'];
	}else{
		$filtro="";
	}
}else {
	$filtro="WHERE c.descripcion like '%".$_POST['txtBusqueda']."%'";
}

if (isset($_POST['txtBusqueda'])) {
	$query_Recordset1 = "SELECT e.codigoegreso, e.fechacomprobante, e.fechacarga, e.codigocomprobante, e.numerocomprobante, e.codigoconcepto, e.estado, e.total, c.descripcion as descricomprobante
						FROM egresos as e LEFT JOIN comprobantes as c ON (e.codigocomprobante = c.codigocomprobante)
						LEFT JOIN conceptos as t ON (e.codigoconcepto = t.codigoconcepto) ".$filtro;
} else {
	$query_Recordset1 = "SELECT e.codigoegreso, e.fechacomprobante, e.fechacarga, e.codigocomprobante, e.numerocomprobante, e.codigoconcepto, e.estado, e.total, c.descripcion as descricomprobante
						FROM egresos as e LEFT JOIN comprobantes as c ON (e.codigocomprobante = c.codigocomprobante)
						LEFT JOIN conceptos as t ON (e.codigoconcepto = t.codigoconcepto) WHERE e.codigoegreso >".$cant;
}

$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

do {?>
	<tr>
		<td><?php echo $row_Recordset1['codigoegreso']; ?></td>
		<td><?php echo $row_Recordset1['descricomprobante']; ?></td>
		<td><?php echo $row_Recordset1['numerocomprobante']; ?></td>
		<td><a href="egresos_editar.php?id=<?php echo $row_Recordset1['codigoegreso']; ?>"><strong><img src="images/edit.ico"/></strong></a></td>
		<td><a href="egresos_borrar.php?id=<?php echo $row_Recordset1['codigoegreso']."&numero=".$row_Recordset1['numerocomprobante']."&con=".$row_Recordset1['codigoconcepto']; ?>" onclick="return confirm('Esta seguro que desea eliminar el registro?');"><strong><img src="images/papel.ico"/></strong></a></td>
	</tr>
	<?php
} while ($row_Recordset1 = mysql_fetch_assoc($Recordset1));

?>
	  </tbody>
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

var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3", "date", {isRequired:true, useCharacterMasking:true, format:"dd/mm/yyyy"});
var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1");
var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "integer", {useCharacterMasking:true, validateOn:["change"]});
var spryselect2 = new Spry.Widget.ValidationSelect("spryselect2");
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "real", {useCharacterMasking:true, validateOn:["change"]});

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
	mysql_free_result($Recordset2);
	mysql_free_result($Recordset3);
?>
