<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php'); 

$pantalla="Editar Usurios Nombre: ".$_GET['id']; 
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
	$SQL="SELECT password FROM usuarios WHERE usuario = '".$_GET['id']."'";
	mysql_select_db($database_dbo, $dbo);
	$Record = mysql_query($SQL, $dbo) or die(mysql_error());
	$R1 = mysql_fetch_assoc($Record);
	$cont1= $R1['password'];
	$cont2= $_POST['Password'];
	if ($cont1!=$cont2){
		$cont2=md5($cont2);
	}
	
  $insertSQL = sprintf("UPDATE usuarios SET nombrecompleto=%s, password=%s, codigogrupo=%s WHERE usuario =%s",
                       GetSQLValueString($_POST['Nombre'], "text"),
                       GetSQLValueString($cont2, "text"),
                       GetSQLValueString($_POST['Grupo'], "text"),
					   GetSQLValueString($_GET['id'], "text"));
  
  mysql_select_db($database_dbo, $dbo);
  $Result1 = mysql_query($insertSQL, $dbo) or die(mysql_error());

	$nombre_us=$_POST['Nombre'];

	// ----------------------Auditoria ----------------------//
	$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Modificar Usuario", "text"),
				GetSQLValueString($_GET['id']." ".$nombre_us, "text"));
	$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
	// -----------------Fin de Auditoria ------------------//
  
  $deleteGoTo = "usuarios.php";
  
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
$query_Recordset1 = sprintf("SELECT u.usuario, u.nombrecompleto, u.password, u.codigogrupo, g.descripcion
FROM usuarios as u LEFT JOIN usuariogrupo as g ON (g.codigogrupo = u.codigogrupo) WHERE u.usuario = %s", GetSQLValueString($colname_Recordset1, "text"));
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
<? include($path.'includes/cssyjs.php');
?>
<script src="../SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<link href="../SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
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
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Nombre Completo:</td>
      <td><span id="sprytextfield2">
        <input type="text" name="Nombre" value="<?php echo $row_Recordset1['nombrecompleto']; ?>" size="30" maxlength="30"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Password:</td>
      <td><span id="sprytextfield3">
        <input type="password" name="Password" value="<?php echo $row_Recordset1['password']; ?>" size="30" maxlength="60"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<td nowrap="nowrap" align="right">Grupo:</td>	
		<td><span id="spryselect1">
	    <select name="Grupo" id="spryselect1">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset2['codigogrupo']?>"<?php if (!(strcmp($row_Recordset2['codigogrupo'], htmlentities($row_Recordset1['codigogrupo'], ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset2['descripcion']?></option>
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
  <p class="cerrar"><a href="<?echo $path;?>usuarios.php">Volver</a></p>
  <br class="clearfloat" />
  <div id="footer"><p><? include($path.'includes/pie.php');?></p></div>
</div>
<p>&nbsp;</p>
<script type="text/javascript">

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
