<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php'); 

$pantalla="Editar Propietario Código: ".$_GET['id']; 
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

	mysql_select_db($database_dbo, $dbo);
	$sql= sprintf("SELECT codigo FROM propietarios WHERE codigopropiedad = %s AND codigo <> %s",
						GetSQLValueString($_POST['CodigoPropiedad'], "text"),
						GetSQLValueString($_GET['id'], "text"));
	$result = mysql_query($sql, $dbo) or die(mysql_error());
	$row_Rec = mysql_fetch_assoc($result);
	$control = mysql_num_rows($result);
	mysql_free_result($result);
	if ($control > 0){
		$hasError = true;
		$errormje = "Ya se asignó esa propiedad a otro propietario";
	}
		
	if(!isset($hasError)) {
			$insertSQL = sprintf("UPDATE propietarios SET apellido=%s, nombre=%s, telefono=%s, mail=%s, codigopropiedad=%s, calle=%s, numerocalle=%s, tipopago=%s, deshabilitado=%s WHERE codigo =%s",
                       GetSQLValueString($_POST['Apellido'], "text"),
                       GetSQLValueString($_POST['Nombre'], "text"),
                       GetSQLValueString($_POST['Telefono'], "text"),
                       GetSQLValueString($_POST['Mail'], "text"),
                       GetSQLValueString($_POST['CodigoPropiedad'], "text"),
                       GetSQLValueString($_POST['Calle'], "text"),
                       GetSQLValueString($_POST['Numerocalle'], "text"),
                       GetSQLValueString($_POST['Tipopago'], "text"),
					   GetSQLValueString(isset($_POST['Deshabilitado']) ? "true" : "", "defined","1","0"),
					   GetSQLValueString($_GET['id'], "text"));
  
			mysql_select_db($database_dbo, $dbo);
			$Result1 = mysql_query($insertSQL, $dbo) or die(mysql_error());
			
			$nombre_prop=$_POST['Apellido']." ".$_POST['Nombre'];
			
			// ----------------------Auditoria ----------------------//
			$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
						GetSQLValueString($_SESSION['MM_Username'], "text"),
						GetSQLValueString("Modificar Propietario", "text"),
						GetSQLValueString($_GET['id']." ".$nombre_prop, "text"));
			$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
			// -----------------Fin de Auditoria ------------------//
			
			$deleteGoTo = "propietarios.php";
  
			if (isset($_SERVER['QUERY_STRING'])) {
				$deleteGoTo .= (strpos($deleteGoTo, '?')) ? "&" : "?";
				$deleteGoTo .= $_SERVER['QUERY_STRING'];
			}
			header(sprintf("Location: %s", $deleteGoTo));
	}
}

mysql_select_db($database_dbo, $dbo);
$query_propiedad = "SELECT codigopropiedad, manzana, casa FROM propiedad ORDER BY Manzana, casa";
$propiedad = mysql_query($query_propiedad, $dbo) or die(mysql_error());
$row_propiedad = mysql_fetch_assoc($propiedad);
$totalRows_propiedad = mysql_num_rows($propiedad);

$colname_Recordset1 = "-1";
if (isset($_GET['id'])) {
  $colname_Recordset1 = $_GET['id'];
}
mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = sprintf("SELECT p.codigo, p.apellido, p.nombre, p.telefono, p.mail, p.codigopropiedad, p.calle, p.numerocalle, p.deshabilitado, d.casa, d.manzana, p.tipopago FROM propietarios AS p LEFT JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad) WHERE p.Codigo = %s", GetSQLValueString($colname_Recordset1, "text"));
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
$totalRows_Recordset1 = mysql_num_rows($Recordset1);

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
        <input type="text" name="Apellido" value="<?php echo $row_Recordset1['apellido']; ?>" size="32" maxlength="50"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Nombre:</td>
      <td><span id="sprytextfield4">
        <input type="text" name="Nombre" value="<?php echo $row_Recordset1['nombre']; ?>" size="32" maxlength="50"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Teléfono:</td>
      <td><input type="text" name="Telefono" value="<?php echo $row_Recordset1['telefono']; ?>" size="32" maxlength="50"/></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Mail:</td>
      <td><input type="text" name="Mail" value="<?php echo $row_Recordset1['mail']; ?>" size="32" maxlength="50"/></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Propiedad:</td>
      <td><select name="CodigoPropiedad">
        <?php 
			do {  ?>
				<option value="<?php echo $row_propiedad['codigopropiedad']?>"<?php if (!(strcmp($row_propiedad['codigopropiedad'], htmlentities($row_Recordset1['codigopropiedad'], ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_propiedad['manzana']." ".$row_propiedad['casa']?></option>
				<?php
			} while ($row_propiedad = mysql_fetch_assoc($propiedad));
			?>
      </select></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Calle:</td>
      <td><input type="text" name="Calle" value="<?php echo $row_Recordset1['calle']; ?>" size="32" maxlength="50"/></td>
    </tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Calle Nº:</td>
      <td><span id="sprytextfield6">
	  <input type="text" name="Numerocalle" value="<?php echo $row_Recordset1['numerocalle']; ?>" size="12" maxlength="8"/></span></td>
    </tr>
	<tr valign="baseline">
		<td nowrap="nowrap" align="right">Tipo pago:</td>	
		<td><span id="spryselect2">
	    <select name="Tipopago" id="select1">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset2['tipopago']?>"<?php if (!(strcmp($row_Recordset2['tipopago'], htmlentities($row_Recordset1['tipopago'], ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset2['descripcion']?></option>
					<?php
				} while ($row_Recordset2 = mysql_fetch_assoc($Recordset2));
			 ?>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">Deshabilitado:</td>
      <td><input type="checkbox" name="Deshabilitado" value="<?php if ($row_Recordset1['deshabilitado']==1) {echo "checked=\"checked\"";} ?>" /></td>
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
			<p id="mensaje"><? echo "Ya se asignó esa propiedad a otro propietario"; ?></p>
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
  <p class="cerrar"><a href="<?echo $path;?>propietarios.php">Volver</a></p>
  <br class="clearfloat" />
  <div id="footer"><p><? include($path.'includes/pie.php');?></p></div>
</div>
<p>&nbsp;</p>
<script type="text/javascript">

var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3");
var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4");
var sprytextfield5 = new Spry.Widget.ValidationTextField("sprytextfield5", "integer", {useCharacterMasking:true, validateOn:["change"]});
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
