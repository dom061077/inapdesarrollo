<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php'); 

$pantalla="Editar Comprobantes Código: ".$_GET['id']; 
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
$query_Recordset1 = sprintf("SELECT codigocomprobante, descripcion, tipo FROM comprobantes WHERE codigocomprobante = %s", GetSQLValueString($colname_Recordset1, "text"));
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
$totalRows_Recordset1 = mysql_num_rows($Recordset1);

mysql_select_db($database_dbo, $dbo);
$sql= sprintf("SELECT codigocomprobante FROM ingresos WHERE codigocomprobante = %s UNION SELECT codigocomprobante FROM egresos WHERE codigocomprobante = %s",
			GetSQLValueString($colname_Recordset1, "text"),
			GetSQLValueString($colname_Recordset1, "text"));
$result = mysql_query($sql, $dbo) or die(mysql_error());
$row_Rec = mysql_fetch_assoc($result);
$control = mysql_num_rows($result);
mysql_free_result($result);

if ((isset($_POST["MM_update"])) && ($_POST["MM_update"] == "form1")) {
  
  if ($control > 0){
	$tipo_=$row_Recordset1['tipo'];
  } else {
	$tipo_=$_POST['Tipo'];
  }
  
  $insertSQL = sprintf("UPDATE comprobantes SET descripcion=%s, tipo=%s WHERE codigocomprobante =%s",
                       GetSQLValueString($_POST['Descripcion'], "text"),
                       GetSQLValueString($tipo_, "text"),
					   GetSQLValueString($_GET['id'], "text"));
  
  mysql_select_db($database_dbo, $dbo);
  $Result1 = mysql_query($insertSQL, $dbo) or die(mysql_error());

	$nombre_c=$_POST['Descripcion'];
	// ----------------------Auditoria ----------------------//
	$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Modificar Comprobante", "text"),
				GetSQLValueString($_GET['id']." ".$nombre_c, "text"));
	$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
	// -----------------Fin de Auditoria ------------------//
  
  $deleteGoTo = "comprobantes.php";
  
  if (isset($_SERVER['QUERY_STRING'])) {
    $deleteGoTo .= (strpos($deleteGoTo, '?')) ? "&" : "?";
    $deleteGoTo .= $_SERVER['QUERY_STRING'];
  }
  header(sprintf("Location: %s", $deleteGoTo));
}

mysql_select_db($database_dbo, $dbo);
$query_Recordset2 = "SELECT tipo, descripcion FROM tipo";
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
      <td nowrap="nowrap" align="right">Descripción:</td>
      <td><span id="sprytextfield2">
		<input type="text" name="Descripcion" value="<?php echo $row_Recordset1['descripcion']; ?>" size="32" maxlength="35"/>
		<span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Tipo:</td>
      <td><label>
        <select <? if ($control > 0){ echo "disabled='disabled'";}?> tabindex="27" name="Tipo" id="Tipo">
		<?php 
		do {  ?>
			<option value="<?php echo $row_Recordset2['tipo']?>"<?php if (!(strcmp($row_Recordset2['tipo'], htmlentities($row_Recordset1['tipo'], ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset2['descripcion']?></option>
			<?php
			} while ($row_Recordset2 = mysql_fetch_assoc($Recordset2));
		 ?>
        </select>
      </label></td>
    </tr>	
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">&nbsp;</td>
      <td><input type="submit" value="Aceptar" /></td>
    </tr>
  </table>
  <input type="hidden" name="MM_update" value="form1" />
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
  <p class="cerrar"><a href="<?echo $path;?>comprobantes.php">Volver</a></p>
  <br class="clearfloat" />
  <div id="footer"><p><? include($path.'includes/pie.php');?></p></div>
</div>
<p>&nbsp;</p>
<script type="text/javascript">

var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2");

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
	mysql_free_result($Recordset2);
?>
