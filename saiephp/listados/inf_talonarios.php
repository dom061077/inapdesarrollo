<?php
$pantalla='Listado de Talonarios';
 
if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
}

require_once('../Connections/dbo.php');

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

if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "form1")) {
	$conc	= $_POST['Concepto'];
	$desd 	= $_POST['Desde'];
	$hast 	= $_POST['Hasta'];

	if ($_POST['select2'] == 0) {
		$hasError = true;
		$errormje = "Seleccione un talonario...";
	}elseif (!isset($hasError)) {
		
		$insertGoTo = "imp_talonarios.php?concepto=".$_POST['Concepto']."&desde=".$_POST['Desde']."&hasta=".$_POST['Hasta']."&comp=".$_POST['select1']."&tal=".$_POST['select2'];
		mysql_select_db($database_dbo, $dbo); 
		// ----------------------Auditoria ----------------------//
		$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Genera Informe", "text"),
				GetSQLValueString($pantalla, "text"));
		$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
		// -----------------Fin de Auditoria ------------------//
 
		if (isset($_SERVER['QUERY_STRING'])) {
			$insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
			$insertGoTo .= $_SERVER['QUERY_STRING'];
		}
		header(sprintf("Location: %s", $insertGoTo));
		unset($comp);
		unset($conc);
		unset($desd);
		unset($hast);
		$hasError = false;
	}
}

mysql_select_db($database_dbo, $dbo);
$query_Comprobantes = "SELECT codigocomprobante, descripcion FROM comprobantes WHERE tipo = 1 ORDER BY descripcion";
$Recordset3 = mysql_query($query_Comprobantes, $dbo) or die(mysql_error());
$row_Recordset3 = mysql_fetch_assoc($Recordset3);

mysql_select_db($database_dbo, $dbo);
$query_Conceptos = "SELECT codigoconcepto, descripcion FROM conceptos WHERE tipo = 1 ORDER BY codigoconcepto";
$Recordset4 = mysql_query($query_Conceptos, $dbo) or die(mysql_error());
$row_Recordset4 = mysql_fetch_assoc($Recordset4);

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma"content="no-cache" />
<meta http-equiv="expires"content="0" />
<title>Informe de Talonarios</title>

<? include($path.'../includes/cssyjs.php');?>

<link type="text/css" rel="stylesheet" href="../dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"></link>
<script src="../SpryAssets/SpryValidationSelect.js" type="text/javascript"></script> 
<link href="../SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" /> 

<script src="../SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<link href="../SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../js/selectdependientes.js"></script>

<script type="text/javascript" src="../dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<link href="../css/style.css" rel="stylesheet" type="text/css" />

</head>

<body>
<div id="contenedor">
 <div id="container1" >
  <h1><?php echo $pantalla;?></h1>
<form action="<?php echo $editFormAction; ?>" method="post" name="form1" id="form1">
  <table align="center">
  <tr valign="baseline">
		<td nowrap="nowrap" align="right">Comprobante:</td>	
		<td><span id="spryselect1">
	    <select name="select1" id="select1" onChange="cargaContenido(this.id)">
		    <option value="0">Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset3['codigocomprobante']?>"<?php if (!(strcmp($row_Recordset3['codigocomprobante'], htmlentities($comp, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset3['descripcion']?></option>
					<?php
				} while ($row_Recordset3 = mysql_fetch_assoc($Recordset3));
				?>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
		</tr>
		<td nowrap="nowrap" align="right">Talonario:</td>	
		<td><span id="spryselect7">
	    <select disabled="disabled" name="select2" id="select2" onChange="cargaContenido(this.id)">
		    <option value="0">Seleccione un item..</option>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
		</tr>
	<td nowrap="nowrap" align="right">Concepto:</td>	
		<td><span id="spryselect1">
	    <select name="Concepto" id="spryselect1">
		    <option value="0">Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset4['codigoconcepto']?>"<?php if (!(strcmp($row_Recordset4['codigoconcepto'], htmlentities($conc, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset4['descripcion']?></option>					
					<?php
				} while ($row_Recordset4 = mysql_fetch_assoc($Recordset4));
				?>
			</select>
	    </span></td>
	</tr>

	<td nowrap="nowrap" align="right">Desde:</td>
      <td><span id="sprytextfield1">
      <input type="text" name="Desde" value="<?php echo $desd; ?>" size="10" onChange="" onBlur="" />
		<span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span></span>
        <input type="button" value="Cal" onclick="displayCalendar(document.forms[0].Desde,'dd/mm/yyyy',this)"></td>
        </tr>
	<td nowrap="nowrap" align="right">Hasta:</td>
      <td><span id="sprytextfield2">
      <input type="text" name="Hasta" value="<?php echo $hast; ?>" size="10" onChange="" onBlur="" />
		<span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span></span>
        <input type="button" value="Cal" onclick="displayCalendar(document.forms[0].Hasta,'dd/mm/yyyy',this)"></td>
        </tr>
	
    <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><div align="left">
            <input name="submit" type="submit" tabindex="4" value="Generar Informe" />
          </div></td>
        </tr>
  </table>

  </div>
  <p>&nbsp;    </p>
  <p>
    <input type="hidden" name="MM_insert" value="form1" />
    </p>
</form>

	<center>
	<?php if(isset($hasError)) { ?>
			<p id="mensaje"><? echo $errormje; ?></p>
	<?php } ?> 
	</center>

</div>
  <br class="clearfloat" />
  <p class="cerrar"><a href="../principal.php">Cerrar</a></p>
  <br class="clearfloat" />
  <div id="footer"><p><? include('../includes/pie.php');?></p></div>
</div>

<script type="text/javascript">

var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1");
var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "date", {isRequired:true, useCharacterMasking:true, format:"dd/mm/yyyy"});
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "date", {isRequired:true, useCharacterMasking:true, format:"dd/mm/yyyy"});

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset3);
	mysql_free_result($Recordset4);
?>
