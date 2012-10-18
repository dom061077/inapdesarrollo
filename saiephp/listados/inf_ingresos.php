<?php
$pantalla='Generar Informe de Ingresos';
 
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
  $insertGoTo = "imp_ingresos.php?concepto=".$_POST['concepto']."&pmes=".$_POST['pmes']."&panio=".$_POST['panio']."&desde=".$_POST['Desde']."&hasta=".$_POST['Hasta'];
 
	mysql_select_db($database_dbo, $dbo); 
	// ----------------------Auditoria ----------------------//
	$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Genera Informe", "text"),
				GetSQLValueString("Ingresos", "text"));
	$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
	// -----------------Fin de Auditoria ------------------//
 
  if (isset($_SERVER['QUERY_STRING'])) {
    $insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
    $insertGoTo .= $_SERVER['QUERY_STRING'];
  }
  header(sprintf("Location: %s", $insertGoTo));
}

mysql_select_db($database_dbo, $dbo);
$query_Conceptos = "SELECT codigoconcepto, descripcion FROM conceptos WHERE tipo = 1 ORDER BY codigoconcepto";
$Recordset4 = mysql_query($query_Conceptos, $dbo) or die(mysql_error());
$row_Recordset4 = mysql_fetch_assoc($Recordset4);

mysql_select_db($database_dbo, $dbo);
$query_Propietarios = "SELECT p.codigo, CONCAT(d.manzana, ' ', d.casa, ' ', p.apellido, ', ', p.nombre) AS nombre, p.codigopropiedad 
FROM propietarios as p LEFT JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad) 
WHERE p.deshabilitado = 0 ORDER BY d.manzana, d.casa";
$Recordset5 = mysql_query($query_Propietarios, $dbo) or die(mysql_error());
$row_Recordset5 = mysql_fetch_assoc($Recordset5);

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma"content="no-cache" />
<meta http-equiv="expires"content="0" />
<title>Informe de Ingresos</title>

<link type="text/css" rel="stylesheet" href="../dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"></link>
<script src="../SpryAssets/SpryValidationSelect.js" type="text/javascript"></script> 
<link href="../SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" /> 

<script src="../SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<link href="../SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />

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

  <td nowrap="nowrap" align="right">Desde:</td>
      <td><span id="sprytextfield1">
      <input type="text" name="Desde" value="" size="10" onChange="" onBlur="" />
		<span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span></span>
        <input type="button" value="Cal" onclick="displayCalendar(document.forms[0].Desde,'dd/mm/yyyy',this)"></td>
        </tr>
	<td nowrap="nowrap" align="right">Hasta:</td>
      <td><span id="sprytextfield2">
      <input type="text" name="Hasta" value="" size="10" onChange="" onBlur="" />
		<span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span></span>
        <input type="button" value="Cal" onclick="displayCalendar(document.forms[0].Hasta,'dd/mm/yyyy',this)"></td>
	</tr>
	<td nowrap="nowrap" align="right">Concepto:</td>	
		<td><span id="spryselect1">
	    <select name="concepto" id="spryselect1">
		    <option value="0">Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset4['codigoconcepto']?>"><?php echo $row_Recordset4['descripcion']?></option>
					<?php
				} while ($row_Recordset4 = mysql_fetch_assoc($Recordset4));
				?>
			</select>
	    </span></td>
	</tr>
	<td nowrap="nowrap" align="right">Per&iacute;odo (Mes):</td>	
		<td><span id="spryselect2">
	    <select name="pmes" id="select2">
		    <option value="0">Seleccione un item..</option>
			<option value="1">Enero</option>
			<option value="2">Febrero</option>
			<option value="3">Marzo</option>
			<option value="4">Abril</option>
			<option value="5">Mayo</option>
			<option value="6">Junio</option>
			<option value="7">Julio</option>
			<option value="8">Agosto</option>
			<option value="9">Septiembre</option>
			<option value="10">Octubre</option>
			<option value="11">Noviembre</option>
			<option value="12">Diciembre</option>
			</select>
	    </span></td>
	</tr>
	
	<tr valign="baseline">
		<td nowrap="nowrap" align="right">Per&iacute;odo (A&ntilde;o):</td>	
		<td><span id="spryselect3">
	    <select name="panio" id="select3" value "<? echo date("Y");?>">
			<option value="0">Seleccione..</option>
			<?php 
				$ano = date("Y");
				for ($i = $ano-10; $i <= $ano + 20; $i++) {
				?>	
					<option value="<?php echo $i ?>"><?php echo $i ?></option>
				<?
				}
			?>
			</select>
	    </span></td>
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
</div>
  <br class="clearfloat" />
  <p class="cerrar"><a href="../principal.php">Cerrar</a></p>
  <br class="clearfloat" />
  <div id="footer"><p><? include('../includes/pie.php');?></p></div>
</div>

<script type="text/javascript">

var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "date", {isRequired:true, useCharacterMasking:true, format:"dd/mm/yyyy"});
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "date", {isRequired:true, useCharacterMasking:true, format:"dd/mm/yyyy"});

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset4);
	mysql_free_result($Recordset5);
?>
