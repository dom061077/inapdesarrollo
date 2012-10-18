<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php'); 

$pantalla="Editar Egresos Código: ".$_GET['id']; 
include('includes/fechas.php');
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

$colname_Recordset1 = "-1";
if (isset($_GET['id'])) {
  $colname_Recordset1 = $_GET['id'];
}

mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = sprintf("SELECT e.codigoegreso, e.fechacomprobante, e.fechacarga, e.codigocomprobante, e.numerocomprobante, e.codigoconcepto, e.estado, e.descripcion, e.total
FROM egresos as e LEFT JOIN comprobantes as c ON (e.codigocomprobante = c.codigocomprobante)
LEFT JOIN conceptos as t ON (e.codigoconcepto = t.codigoconcepto) WHERE codigoegreso = %s", GetSQLValueString($colname_Recordset1, "text"));
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

$fcha 	= $row_Recordset1['fechacomprobante'];
$com	= $row_Recordset1['codigocomprobante'];
$num 	= $row_Recordset1['numerocomprobante'];
$con	= $row_Recordset1['codigoconcepto'];
$des	= $row_Recordset1['descripcion'];
$tot	= $row_Recordset1['total'];

if ((isset($_POST["MM_update"])) && ($_POST["MM_update"] == "form1")) {
	mysql_select_db($database_dbo, $dbo);
	$sql= sprintf("SELECT * FROM egresos WHERE codigocomprobante = %s AND numerocomprobante = %s AND codigoegreso <> %s",
						GetSQLValueString($_POST['Comprobante'], "text"),
						GetSQLValueString($_POST['Numero'], "text"),
						GetSQLValueString($_GET['id'], "text"));
	$result = mysql_query($sql, $dbo) or die(mysql_error());
	$row_Rec = mysql_fetch_assoc($result);
	$control = mysql_num_rows($result);
	mysql_free_result($result);
	if ($control > 0){
		$hasError = true;
		$errormje = "Ya se ingres&oacute; ese n&uacute;mero de comprobante";
	}
	
	$fcha 	= fece($_POST['Fecha']);
	$com	= $_POST['Comprobante'];
	$num 	= $_POST['Numero'];
	$con	= $_POST['Concepto'];
	$des	= $_POST['Descripcion'];
	$tot	= $_POST['Total'];
	
	if(!isset($hasError)) {
		$insertSQL = sprintf("UPDATE egresos SET fechacomprobante=%s, codigocomprobante=%s, numerocomprobante=%s, codigoconcepto=%s, descripcion=%s, total=%s WHERE codigoegreso =%s",
                       GetSQLValueString(fece($_POST['Fecha']), "text"),
					   GetSQLValueString($_POST['Comprobante'], "text"),
					   GetSQLValueString($_POST['Numero'], "text"),
                       GetSQLValueString($_POST['Concepto'], "text"),
					   GetSQLValueString($_POST['Descripcion'], "text"),
					   GetSQLValueString($_POST['Total'], "text"),
					   GetSQLValueString($_GET['id'], "text"));
  
		mysql_select_db($database_dbo, $dbo);
		$Result1 = mysql_query($insertSQL, $dbo) or die(mysql_error());

		$nro = $_GET['id'];
		// ----------------------Auditoria ----------------------//
		$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Modificar Egreso", "text"),
				GetSQLValueString("Codigo: ".$nro." ".$_POST['Fecha']." Nro:".$_POST['Numero']." Concepto:".$_POST['Concepto'], "text"));
		$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
		// -----------------Fin de Auditoria ------------------//
		
		$deleteGoTo = "egresos.php";
  
		if (isset($_SERVER['QUERY_STRING'])) {
			$deleteGoTo .= (strpos($deleteGoTo, '?')) ? "&" : "?";
			$deleteGoTo .= $_SERVER['QUERY_STRING'];
		}
		header(sprintf("Location: %s", $deleteGoTo));
	}
}

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><? echo $pantalla;?></title>
<? include($path.'includes/cssyjs.php');
?>

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
			<input type="text" name="Fecha" value="<?php echo fecs($fcha); ?>" size="10" onChange="" onBlur="" />
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
				<input type="text" name="Numero" value="<?php echo $num; ?>" size="12" maxlength="8"/>
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
			<input type="text" name="Total" value="<?php echo $tot; ?>" size="12" maxlength="8"/>
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

	<center>
	<?php if(isset($hasError)) { ?>
			<p id="mensaje"><? echo $errormje; ?></p>
	<?php } ?> 
	</center>

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
  <p class="cerrar"><a href="<?echo $path;?>egresos.php">Volver</a></p>
  <br class="clearfloat" />
  <div id="footer"><p><? include($path.'includes/pie.php');?></p></div>
</div>
<p>&nbsp;</p>

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
