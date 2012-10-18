<?php
$pantalla="Talonarios"; 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php');
require_once('sp_funciones.php');

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

$editFormAction = $_SERVER['PHP_SELF'];
if (isset($_SERVER['QUERY_STRING'])) {
  $editFormAction .= "?" . htmlentities($_SERVER['QUERY_STRING']);
}

if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "form1")) {
	mysql_select_db($database_dbo, $dbo);
	$sql= sprintf("SELECT * FROM talonarios WHERE (((numerodesde <= %s) AND (numerohasta > %s)) OR  (( numerodesde <= %s) 
				AND (numerohasta > %s)) OR ((numerohasta+1 > %s) AND (numerodesde <= %s))) AND codigocomprobante = %s",
				GetSQLValueString($_POST['Desde'], "text"),
				GetSQLValueString($_POST['Desde'], "text"),
				GetSQLValueString($_POST['Hasta'], "text"),
				GetSQLValueString($_POST['Hasta'], "text"),
				GetSQLValueString($_POST['Desde'], "text"),
				GetSQLValueString($_POST['Hasta'], "text"),
				GetSQLValueString($_POST['TipoComprobante'], "text"));
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
  
	$com_ 	= $_POST['TipoComprobante'];
	$des_ 	= $_POST['Desde'];
	$has_	= $_POST['Hasta'];
	$cob_	= $_POST['Cobrador'];

	if(!isset($hasError)) {
		$nro_generado = SP_Talonario($_POST['TipoComprobante'], $_POST['Desde'], $_POST['Hasta'], $_POST['Cobrador']);
		
		mysql_select_db($database_dbo, $dbo);
		// ----------------------Auditoria ----------------------//
		$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
					GetSQLValueString($_SESSION['MM_Username'], "text"),
					GetSQLValueString("Agregar Talonario", "text"),
					GetSQLValueString("Codigo: ".$nro_generado." Desde ".$_POST['Desde']." hasta ".$_POST['Hasta']." comprobante:".$_POST['TipoComprobante'], "text"));
		$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
		// -----------------Fin de Auditoria ------------------//
  
		$insertGoTo = "talonarios.php";
  
		if (isset($_SERVER['QUERY_STRING'])) {
			$insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
			$insertGoTo .= $_SERVER['QUERY_STRING'];
		}
		//header(sprintf("Location: %s", $insertGoTo));
		unset($com_);
		unset($des_);
		unset($has_);
		unset($cob_);

	}
} else {
	if (isset($_GET['error'])){
		if($_GET['error'] == 1){
			$hasError = true;
			$errormje = "No se puede eliminar este talonario porque hay datos que dependen de él...";
		}
	}
}

mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = "SELECT t.codigotalonario, t.codigocomprobante, t.numerodesde, t.numerohasta, t.codigocobrador, c.nombre, t.estado
FROM talonarios as t LEFT JOIN comprobantes AS m ON (t.codigocomprobante = m.codigocomprobante)
LEFT JOIN cobrador AS c ON (t.codigocobrador = c.codigocobrador)
ORDER BY t.codigocomprobante,t.numerodesde";
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
 
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
		<td nowrap="nowrap" align="right">Comprobante:</td>	
		<td><span id="spryselect1">
	    <select name="TipoComprobante" id="select1">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset3['codigocomprobante']?>"<?php if (!(strcmp($row_Recordset3['codigocomprobante'], htmlentities($com_, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset3['descripcion']?></option>
					<?php
				} while ($row_Recordset3 = mysql_fetch_assoc($Recordset3));
				?>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Desde:</td>
      <td><span id="sprytextfield1">
        <input type="text" name="Desde" value="<?echo $des_;?>" size="12" maxlength="8"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
    </tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Hasta:</td>
      <td><span id="sprytextfield2">
        <input type="text" name="Hasta" value="<?echo $has_;?>" size="12" maxlength="8"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	<tr valign="baseline">
		<td nowrap="nowrap" align="right">Cobrador:</td>	
		<td><span id="spryselect2">
	    <select name="Cobrador" id="select2">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset2['codigocobrador']?>"<?php if (!(strcmp($row_Recordset2['codigocobrador'], htmlentities($cob_, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset2['nombre']?></option>
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
		  		<form name="form2" method="post" action="talonarios.php">Buscar por: 
					<select name="Tipo" id="column">
						<option value="1">C&oacute;digo</option>
						<option value="2">Estado</option>
						<option value="3">Cobrador</option>
						<option value="4">Desde</option>
					</select>
					<input type="text" name="txtBusqueda" id="txtBusqueda" />
					<input type="submit" name="cmdBuscar" id="cmdBuscar" value="Buscar" />
					<input type="reset" value="Limpiar" />
				</form>
				<table id="myTable" cellpadding="0" cellpadding="0">
				<tr>
					<td><div align="center">C&oacute;digo </div></td>
					<td><div align="center">Comprobante</div></td>
					<td><div align="center">Desde</div></td>
					<td><div align="center">Hasta</div></td>
					<td><div align="center">Estado</div></td>
					<td><div align="center">Cobrador</div></td>
				</tr>
<?php

mysql_select_db($database_dbo, $dbo);

$Rec_qry = mysql_query("SELECT COUNT(*) AS maximo FROM talonarios", $dbo) or die(mysql_error());
$max_recordset = mysql_fetch_assoc($Rec_qry);
$max=$max_recordset['maximo'];
if ($max<=10){$max=0;} else {$max=$max-10;}
mysql_free_result($Rec_qry);

if ($_POST['Tipo']==1) {
	if (is_numeric($_POST['txtBusqueda'])) {
		$filtro="WHERE t.codigotalonario = ".$_POST['txtBusqueda']." ORDER BY t.codigotalonario ASC";
	}else{
		$filtro="WHERE t.codigotalonario >= ".$max." ORDER BY t.codigotalonario ASC";
	}
}elseif ($_POST['Tipo']==2) {
	if (strtoupper($_POST['txtBusqueda'])=='ACTIVO') {$estado=1;} else {$estado=2;}
	$filtro="WHERE t.estado = ".$estado. " ORDER BY t.codigocomprobante,t.numerodesde";
}elseif ($_POST['Tipo']==3) {
	$filtro="WHERE c.nombre like '%".$_POST['txtBusqueda']."%' ORDER BY t.codigocomprobante,t.numerodesde";
}else {
	$filtro="WHERE t.numerodesde = ".$_POST['txtBusqueda']." ORDER BY t.codigocomprobante,t.numerodesde";
}

if (isset($_POST['txtBusqueda'])) {
	$query_Recordset1 = "SELECT t.codigotalonario, t.codigocomprobante, t.numerodesde, t.numerohasta, t.codigocobrador, c.nombre, t.estado, m.descripcion
						FROM talonarios as t LEFT JOIN comprobantes AS m ON (t.codigocomprobante = m.codigocomprobante) LEFT JOIN cobrador AS c ON (t.codigocobrador = c.codigocobrador) ".$filtro;
} else {
	$query_Recordset1 = "SELECT t.codigotalonario, t.codigocomprobante, t.numerodesde, t.numerohasta, t.codigocobrador, c.nombre, t.estado, m.descripcion
						FROM talonarios as t LEFT JOIN comprobantes AS m ON (t.codigocomprobante = m.codigocomprobante) LEFT JOIN cobrador AS c ON (t.codigocobrador = c.codigocobrador)
						WHERE t.codigotalonario >= ".$max." ORDER BY t.codigocomprobante,t.numerodesde";
}
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

do {?>
	<tr>
		<td><?php echo $row_Recordset1['codigotalonario']; ?></td>
		<td><?php echo $row_Recordset1['descripcion']; ?></td>
		<td><?php echo $row_Recordset1['numerodesde']; ?></td>
		<td><?php echo $row_Recordset1['numerohasta']; ?></td>
		<td><?php if ($row_Recordset1['estado']=='1'){echo "ACTIVO";}elseif($row_Recordset1['estado']=='2'){echo "ANULADO";}else {echo "COMPLETADO";}?></td>
		<td><div align="left"> <?php echo "(".$row_Recordset1['codigocobrador'].") ".$row_Recordset1['nombre']; ?></div></td>
		<td><a href="talonarios_editar.php?id=<?php echo $row_Recordset1['codigotalonario']; ?>"><strong><img src="images/edit.ico"/></strong></a></td>
		<td><a href="talonarios_borrar.php?id=<?php echo $row_Recordset1['codigotalonario'].'&desde='.$row_Recordset1['numerodesde'].'&hasta='.$row_Recordset1['numerohasta'].'&compro='.$row_Recordset1['codigocomprobante']; ?>" onclick="return confirm('Esta seguro que desea eliminar el registro?');"><strong><img src="images/papel.ico"/></strong></a></td>
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
var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "integer", {useCharacterMasking:true, validateOn:["change"]});
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2", "integer", {useCharacterMasking:true, validateOn:["change"]});
var spryselect2 = new Spry.Widget.ValidationSelect("spryselect2");

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
	mysql_free_result($Recordset2);
	mysql_free_result($Recordset3);
?>
