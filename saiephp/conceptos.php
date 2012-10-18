<?php
$pantalla="Conceptos"; 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php');?>

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
	$sql= sprintf("SELECT * FROM conceptos WHERE codigoconcepto = %s",
						GetSQLValueString($_POST['Codigo'], "text"));
	$result = mysql_query($sql, $dbo) or die(mysql_error());
	$row_Rec = mysql_fetch_assoc($result);
	$control = mysql_num_rows($result);
	mysql_free_result($result);
	if ($control > 0){
		$hasError = true;
		$errormje = "Ya se asignó el código '".strtoupper($_POST['Codigo'])."' a otro concepto";
	}
	
	$cod 	= $_POST['Codigo'];
	$des 	= $_POST['Descripcion'];
	$tpo 	= $_POST['Tipo'];
		
	if(!isset($hasError)) {
			$insertSQL = sprintf("INSERT INTO conceptos (codigoconcepto, descripcion, tipo) VALUES (%s, %s, %s)",
						GetSQLValueString($_POST['Codigo'], "text"),
						GetSQLValueString($_POST['Descripcion'], "text"),
						GetSQLValueString($_POST['Tipo'], "text"));
  
			mysql_select_db($database_dbo, $dbo);
			$Result1 = mysql_query($insertSQL, $dbo) or die(mysql_error());

			// ----------------------Auditoria ----------------------//
			$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
						GetSQLValueString($_SESSION['MM_Username'], "text"),
						GetSQLValueString("Agregar Concepto", "text"),
						GetSQLValueString($_POST['Codigo']." ".$_POST['Descripcion'], "text"));
			$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
			// -----------------Fin de Auditoria ------------------//
  
  
			$insertGoTo = "conceptos.php";
  
			if (isset($_SERVER['QUERY_STRING'])) {
				$insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
				$insertGoTo .= $_SERVER['QUERY_STRING'];
			}
			//header(sprintf("Location: %s", $insertGoTo));
		unset($cod);
		unset($des);
		unset($tpo);
	}
} else {
	if (isset($_GET['error'])){
		if($_GET['error'] == 1){
			$hasError = true;
			$errormje = "No se puede eliminar este concepto porque hay datos que dependen de él...";
		}
	}
}

mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = "SELECT codigoconcepto, descripcion, tipo FROM conceptos ORDER BY codigoconcepto";
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
 
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
      <td nowrap="nowrap" align="right">Código:</td>
      <td><span id="sprytextfield1">
        <input type="text" name="Codigo" value="<? echo $cod; ?>" size="10" maxlength="3"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Descripción:</td>
      <td><span id="sprytextfield2">
		<input type="text" name="Descripcion" value="<? echo $des; ?>" size="32" maxlength="35"/>
		<span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
	<tr valign="baseline">
		<td nowrap="nowrap" align="right">Tipo:</td>	
		<td><span id="spryselect1">
	    <select name="Tipo" id="select1">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset2['tipo']?>"<?php if (!(strcmp($row_Recordset2['tipo'], htmlentities($tpo, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset2['descripcion']?></option>
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
		  		<form name="form2" method="post" action="conceptos.php">Buscar por: 
					<select name="Tipo" id="column">
						<option value="1">C&oacute;digo</option>
						<option value="2">Descripci&oacute;n</option>
					</select>
					<input type="text" name="txtBusqueda" id="txtBusqueda" />
					<input type="submit" name="cmdBuscar" id="cmdBuscar" value="Buscar" />
					<input type="reset" value="Limpiar" />
				</form>
				<table id="myTable" cellpadding="0" cellpadding="0">
				<tr>
					<td><div align="center">C&oacute;digo </div></td>
					<td><div align="center">Descripci&oacute;n</div></td>
					<td><div align="center">Tipo</div></td>
				</tr>
<?php

mysql_select_db($database_dbo, $dbo);

//SELECT codigoconcepto, descripcion, tipo FROM conceptos ORDER BY codigoconcepto

if (isset($_POST['txtBusqueda'])) {
	if ($_POST['Tipo']==1){
		$query_Recordset1 = "SELECT c.codigoconcepto, c.descripcion, c.tipo, t.descripcion as descri FROM conceptos as c, tipo as t WHERE c.tipo = t.tipo and c.codigoconcepto like '%".$_POST['txtBusqueda']."%' ORDER BY c.codigoconcepto ASC";
	}else{
		$query_Recordset1 = "SELECT c.codigoconcepto, c.descripcion, c.tipo, t.descripcion as descri FROM conceptos as c, tipo as t WHERE c.tipo = t.tipo and c.descripcion like '%".$_POST['txtBusqueda']. "%' ORDER BY codigoconcepto ASC";
	} 
} else {
	$query_Recordset1 = "SELECT c.codigoconcepto, c.descripcion, c.tipo, t.descripcion as descri FROM conceptos as c, tipo as t WHERE c.tipo = t.tipo ORDER BY c.codigoconcepto ASC";
}

$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

do {?>
	<tr>
		<td><?php echo $row_Recordset1['codigoconcepto']; ?></td>
		<td><?php echo strtoupper($row_Recordset1['descripcion']); ?></td>
		<td><?php echo $row_Recordset1['descri']; ?></td>
		<td><a href="conceptos_editar.php?id=<?php echo $row_Recordset1['codigoconcepto']; ?>"><strong><img src="images/edit.ico"/></strong></a></td>
		<td><a href="conceptos_borrar.php?id=<?php echo $row_Recordset1['codigoconcepto'].'&nombre='.$row_Recordset1['descripcion']; ?>" onclick="return confirm('Esta seguro que desea eliminar el registro?');"><strong><img src="images/papel.ico"/></strong></a></td>
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

var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1");
var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1");
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2");

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
	mysql_free_result($Recordset2);
?>
