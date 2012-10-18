<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php'); 
include('includes/fechas.php');

$pantalla="Editar Ingreso Código: ".$_GET['id']; 
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

if ((isset($_POST["MM_update"])) && ($_POST["MM_update"] == "form1")) {
  $insertSQL = sprintf("UPDATE ingresos SET fechacomprobante=%s, numerocomprobante=%s, codigoconcepto=%s, propietario=%s, periodomes=%s ,periodoano=%s , total=%s WHERE codigoingreso =%s",
                       GetSQLValueString(fece($_POST['Fecha']), "text"),
					   GetSQLValueString($_POST['Numero'], "text"),
                       GetSQLValueString($_POST['Concepto'], "text"),
                       GetSQLValueString($_POST['CodPropietario'], "text"),
					   GetSQLValueString($_POST['PMes'], "text"),
                       GetSQLValueString($_POST['PAnio'], "text"),
					   GetSQLValueString($_POST['Total'], "text"),
					   GetSQLValueString($_GET['id'], "text"));
  
  mysql_select_db($database_dbo, $dbo);
  $Result1 = mysql_query($insertSQL, $dbo) or die(mysql_error());

	$nro = $_GET['id'];
	// ----------------------Auditoria ----------------------//
	$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Modificar Ingreso", "text"),
				GetSQLValueString("Codigo: ".$nro." ".$_POST['Fecha']." Nro:".$_POST['Numero']." Concepto:".$_POST['Concepto']." Propietario:".$_POST['CodPropietario'], "text"));
	$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
	// -----------------Fin de Auditoria ------------------//
  
  $deleteGoTo = "ingresos.php";
  
  if (isset($_SERVER['QUERY_STRING'])) {
    $deleteGoTo .= (strpos($deleteGoTo, '?')) ? "&" : "?";
    $deleteGoTo .= $_SERVER['QUERY_STRING'];
  }
  header(sprintf("Location: %s", $deleteGoTo));
}

$colname_Recordset1 = "-1";
if (isset($_GET['id'])) {
  $colname_Recordset1 = $_GET['id'];
}
mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = sprintf("SELECT * FROM ingresos WHERE codigoingreso = %s", GetSQLValueString($colname_Recordset1, "text"));
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

mysql_select_db($database_dbo, $dbo);
$query_Conceptos = "SELECT codigoconcepto, descripcion FROM conceptos WHERE tipo = 1 ORDER BY codigoconcepto";
$Recordset4 = mysql_query($query_Conceptos, $dbo) or die(mysql_error());
$row_Recordset4 = mysql_fetch_assoc($Recordset4);

mysql_select_db($database_dbo, $dbo);
$query_Propietarios = "SELECT p.codigo, CONCAT(d.manzana, ' ', d.casa, ' ', UPPER(p.apellido), ', ', UPPER(p.nombre)) AS nombre, p.codigopropiedad 
FROM propietarios as p LEFT JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad)
ORDER BY d.manzana, d.casa";
$Recordset5 = mysql_query($query_Propietarios, $dbo) or die(mysql_error());
$row_Recordset5 = mysql_fetch_assoc($Recordset5);

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><? echo $pantalla;?></title>
<? include($path.'includes/cssyjs.php'); ?>

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
      <input type="text" name="Fecha" value="<?php echo fecs($row_Recordset1['fechacomprobante']); ?>" size="10" onChange="" onBlur="" />
		<span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span></span>
        <input type="button" value="Cal" onclick="displayCalendar(document.forms[0].Fecha,'dd/mm/yyyy',this)"></td>
        </tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">N&uacute;mero:</td>
      <td><span id="sprytextfield1">
        <input type="text" name="Numero" value="<?php echo $row_Recordset1['numerocomprobante']; ?>" size="12" maxlength="8"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<td nowrap="nowrap" align="right">Concepto:</td>	
		<td><span id="spryselect2">
	    <select name="Concepto" id="select1">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset4['codigoconcepto']?>"<?php if (!(strcmp($row_Recordset4['codigoconcepto'], htmlentities($row_Recordset1['codigoconcepto'], ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset4['descripcion']?></option>
					<?php
				} while ($row_Recordset4 = mysql_fetch_assoc($Recordset4));
				?>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<td nowrap="nowrap" align="right">Propietario:</td>	
		<td><span id="spryselect3">
	    <select name="CodPropietario" id="select1">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset5['codigo']?>"<?php if (!(strcmp($row_Recordset5['codigo'], htmlentities($row_Recordset1['propietario'], ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset5['nombre']?></option>
					<?php
				} while ($row_Recordset5 = mysql_fetch_assoc($Recordset5));
				?>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<td nowrap="nowrap" align="right">Per&iacute;odo (Mes):</td>	
		<td><span id="spryselect5">
	    <select name="PMes" id="select1">
		    <option>Seleccione un item..</option>
            <option value="1" <?php if (!(strcmp(1, $row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Enero</option>
            <option value="2" <?php if (!(strcmp(2, $row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Febrero</option>
            <option value="3" <?php if (!(strcmp(3, $row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Marzo</option>
            <option value="4" <?php if (!(strcmp(4, $row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Abril</option>
            <option value="5" <?php if (!(strcmp(5, $row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Mayo</option>
            <option value="6" <?php if (!(strcmp(6, $row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Junio</option>
            <option value="7" <?php if (!(strcmp(7, $row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Julio</option>
            <option value="8" <?php if (!(strcmp(8, $row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Agosto</option>
            <option value="9" <?php if (!(strcmp(9, $row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Septiembre</option>
            <option value="10"<?php if (!(strcmp(10,$row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Octubre</option>
            <option value="11"<?php if (!(strcmp(11,$row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Noviembre</option>
            <option value="12"<?php if (!(strcmp(12,$row_Recordset1['periodomes']))) {echo "selected=\"selected\"";} ?>>Diciembre</option>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<tr valign="baseline">
		<td nowrap="nowrap" align="right">Per&iacute;odo (A&ntilde;o):</td>	
		<td><span id="spryselect6">
	    <select name="PAnio" id="select2" value "<? echo date("Y");?>">
			<?php 
				$ano = date("Y");
				for ($i = $ano-10; $i <= $ano + 20; $i++) {
				?>	
					<option value="<?php echo $i ?>"<?php if (!(strcmp($i, htmlentities($row_Recordset1['periodoano'], ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $i ?></option>
					
				<?
				}
			?>
			</select>
	    </span></td>
	</tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Total ($):</td>
      <td><span id="sprytextfield4">
        <input type="text" name="Total" value="<?php echo $row_Recordset1['total']; ?>" size="12" maxlength="8"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">&nbsp;</td>
      <td><input type="submit" value="Aceptar" /></td>
    </tr>
  </table>
  <input type="hidden" name="MM_update" value="form1" />
  <input type="hidden" name="Codigo" value="<?php echo $row_Recordset1['Codigo']; ?>" />
</form>
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
  <p class="cerrar"><a href="<?echo $path;?>ingresos.php">Volver</a></p>
  <br class="clearfloat" />
  <div id="footer"><p><? include($path.'includes/pie.php');?></p></div>
</div>
<p>&nbsp;</p>
<script type="text/javascript">

var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3", "date", {isRequired:true, useCharacterMasking:true, format:"dd/mm/yyyy"});
var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "integer", {useCharacterMasking:true, validateOn:["change"]});
var spryselect2 = new Spry.Widget.ValidationSelect("spryselect2");
var spryselect3 = new Spry.Widget.ValidationSelect("spryselect3");
var spryselect5 = new Spry.Widget.ValidationSelect("spryselect5");
var spryselect6 = new Spry.Widget.ValidationSelect("spryselect6");
var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4", "real", {useCharacterMasking:true, validateOn:["change"]});

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
	mysql_free_result($Recordset4);
	mysql_free_result($Recordset5);
?>
