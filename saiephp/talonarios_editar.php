<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php'); 

mysql_select_db($database_dbo, $dbo);
$query = sprintf("SELECT c.nombre FROM cobrador as c, talonarios as t WHERE c.codigocobrador = t.codigocobrador and t.codigotalonario=".$_GET['id']);
$Recordset = mysql_query($query, $dbo) or die(mysql_error());
$row = mysql_fetch_assoc($Recordset);

$pantalla="Editar Talonario código: ".$_GET['id']." asignado a: ".$row[nombre]; 
mysql_free_result($Recordset);
?>
<?php

function validarEntero($valor)
{
	return ((int) $valor);
}

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
	mysql_select_db($database_dbo, $dbo);
	$sql= sprintf("SELECT * FROM talonarios WHERE (((numerodesde <= %s) AND (numerohasta > %s)) OR  (( numerodesde <= %s) 
				AND (numerohasta > %s)) OR ((numerohasta+1 > %s) AND (numerodesde <= %s))) AND codigocomprobante = %s AND codigotalonario <> %s",
				GetSQLValueString($_POST['Desde'], "text"),
				GetSQLValueString($_POST['Desde'], "text"),
				GetSQLValueString($_POST['Hasta'], "text"),
				GetSQLValueString($_POST['Hasta'], "text"),
				GetSQLValueString($_POST['Desde'], "text"),
				GetSQLValueString($_POST['Hasta'], "text"),
				GetSQLValueString($_POST['TipoComprobante'], "text"),
				GetSQLValueString($_GET['id'], "text"));
	$result = mysql_query($sql, $dbo) or die(mysql_error());
	$row_Rec = mysql_fetch_assoc($result);
	$control = mysql_num_rows($result);
	mysql_free_result($result);
	
	if ((!isset($hasError)) && ($control > 0)) {
		$hasError = true;
		$errormje = "Verifique el rango de numeraci&oacute;n ingresada...";
	}
  
	$i_de = validarEntero($_POST['Desde']);
	$i_ha = validarEntero($_POST['Hasta']);
	
	if ((!isset($hasError)) && ($i_de >= $i_ha)) {
		$hasError = true;
		$errormje = "El n&uacute;mero 'desde' debe ser mayo al n&uacute;mero 'hasta'...";
	}
  
	if(!isset($hasError)) {
		$insertSQL = sprintf("UPDATE talonarios SET codigocomprobante=%s, numerodesde=%s, numerohasta=%s, estado=%s, codigocobrador=%s WHERE codigotalonario =%s",
                       GetSQLValueString($_POST['TipoComprobante'], "text"),
					   GetSQLValueString($_POST['Desde'], "text"),
                       GetSQLValueString($_POST['Hasta'], "text"),
					   GetSQLValueString($_POST['Estado'], "text"),
					   GetSQLValueString($_POST['Cobrador'], "text"),
					   GetSQLValueString($_GET['id'], "text"));
  
		mysql_select_db($database_dbo, $dbo);
		$Result1 = mysql_query($insertSQL, $dbo) or die(mysql_error());

		$datos_="Desde ".$_POST['Desde']." hasta ".$_POST['Hasta']." comprobante:".$_POST['TipoComprobante'];
		// ----------------------Auditoria ----------------------//
		$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Modificar Talonario", "text"),
				GetSQLValueString("Codigo: ".$_GET['id']." ".$datos_, "text"));
		$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
		// -----------------Fin de Auditoria ------------------//
  
		$deleteGoTo = "talonarios.php";
  
		if (isset($_SERVER['QUERY_STRING'])) {
			$deleteGoTo .= (strpos($deleteGoTo, '?')) ? "&" : "?";
			$deleteGoTo .= $_SERVER['QUERY_STRING'];
		}
		header(sprintf("Location: %s", $deleteGoTo));
	}
}

$colname_Recordset1 = "-1";
if (isset($_GET['id'])) {
  $colname_Recordset1 = $_GET['id'];
}
mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = sprintf("SELECT codigotalonario, codigocomprobante, numerodesde, numerohasta, codigocobrador, estado FROM talonarios WHERE codigotalonario = %s", GetSQLValueString($colname_Recordset1, "text"));
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
$totalRows_Recordset1 = mysql_num_rows($Recordset1);

mysql_select_db($database_dbo, $dbo);
$query_Cobradores = "SELECT codigocobrador, nombre FROM cobrador ORDER BY nombre";
$Recordset2 = mysql_query($query_Cobradores, $dbo) or die(mysql_error());
$row_Recordset2 = mysql_fetch_assoc($Recordset2);

mysql_select_db($database_dbo, $dbo);
$query_Comprobantes = "SELECT codigocomprobante, descripcion FROM comprobantes WHERE tipo = 1 ORDER BY descripcion";
$Recordset3 = mysql_query($query_Comprobantes, $dbo) or die(mysql_error());
$row_Recordset3 = mysql_fetch_assoc($Recordset3);

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
      <td nowrap="nowrap" align="right">Comprobante:</td>
      <td><select name="TipoComprobante">
      <?php 
		do {  ?>
			<option value="<?php echo $row_Recordset3['codigocomprobante']?>"<?php if (!(strcmp($row_Recordset3['codigocomprobante'], htmlentities($row_Recordset1['codigocomprobante'], ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset3['descripcion']?></option>
			<?php
			} while ($row_Recordset3 = mysql_fetch_assoc($Recordset3));
			 ?>
		</select><div id="codigocomprobante" /></div>
	  </td>
    </tr>
	<tr valign="baseline">
	  <td nowrap="nowrap" align="right">Desde:</td>
      <td><span id="sprytextfield1">
		<input type="text" name="Desde" value="<?php echo $row_Recordset1['numerodesde']; ?>" size="12" maxlength="8"/>
		<span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
	<tr valign="baseline">
	  <td nowrap="nowrap" align="right">Hasta:</td>
      <td><span id="sprytextfield2">
		<input type="text" name="Hasta" value="<?php echo $row_Recordset1['numerohasta']; ?>" size="12" maxlength="8"/>
		<span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Cobrador:</td>
      <td><select name="Cobrador">
      <?php 
		do {  ?>
			<option value="<?php echo $row_Recordset2['codigocobrador']?>"<?php if (!(strcmp($row_Recordset2['codigocobrador'], htmlentities($row_Recordset1['codigocobrador'], ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset2['nombre']?></option>
			<?php
			} while ($row_Recordset2 = mysql_fetch_assoc($Recordset2));
			 ?>
		</select><div id="propiedad" /></div>
	  </td>
    </tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Estado:</td>
      <td><label>
        <select tabindex="27" name="Estado" id="Estado">
          <option value="1" <?php if (!(strcmp(1, $row_Recordset1['estado']))) {echo "selected=\"selected\"";} ?>>Activo</option>
		  <option value="2" <?php if (!(strcmp(2, $row_Recordset1['estado']))) {echo "selected=\"selected\"";} ?>>Anulado</option>
          <option value="3" <?php if (!(strcmp(2, $row_Recordset1['estado']))) {echo "selected=\"selected\"";} ?>>Completado</option>
        </select>
      </label></td>
    </tr>	
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">&nbsp;</td>
      <td><input type="submit" value="Aceptar" /></td>
    </tr>
  </table>
  <input type="hidden" name="MM_update" value="form1" />
  <input type="hidden" name="Codigo" value="<?php echo $row_Recordset1['codigotalonario']; ?>" />
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
  <p class="cerrar"><a href="<?echo $path;?>talonarios.php">Volver</a></p>
  <br class="clearfloat" />
  <div id="footer"><p><? include($path.'includes/pie.php');?></p></div>
</div>
<p>&nbsp;</p>
<script type="text/javascript">

var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "integer", {useCharacterMasking:true, validateOn:["change"]});
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "integer", {useCharacterMasking:true, validateOn:["change"]});

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
	mysql_free_result($Recordset2);
	mysql_free_result($Recordset3);
?>
