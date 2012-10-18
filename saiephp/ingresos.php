<?php
$pantalla="Ingresos"; 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php');
include('includes/fechas.php');
require_once('sp_funciones.php');

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

$editFormAction = $_SERVER['PHP_SELF'];
if (isset($_SERVER['QUERY_STRING'])) {
  $editFormAction .= "?" . htmlentities($_SERVER['QUERY_STRING']);
}

if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "form1")) {
	mysql_select_db($database_dbo, $dbo);
	$sql= sprintf("SELECT * FROM cuotas WHERE periodomes = %s AND periodoano = %s",
						GetSQLValueString($_POST['PMes'], "text"),
						GetSQLValueString($_POST['PAnio'], "text"));
	$result = mysql_query($sql, $dbo) or die(mysql_error());
	$row_Rec = mysql_fetch_assoc($result);
	$control = mysql_num_rows($result);
	mysql_free_result($result);
	
	$nro	= $_POST['Select3'];
	$fcha 	= $_POST['Fecha'];
	$comp 	= $_POST['Select1'];
	$tal 	= $_POST['Select2'];
	$conc	= $_POST['Concepto'];
	$prop	= $_POST['CodPropietario'];
	$mes	= $_POST['PMes'];
	$ano	= $_POST['PAnio'];
	$tot	= $_POST['Total'];

	if ($control == 0){
		$hasError = true;
		$errormje = "Error. Debe cargar antes el valor de la cuota para el per&iacute;odo ".$_POST['PMes']."/".$_POST['PAnio']."...";
	} elseif (($_POST['select3'] == 0) || (!isset($_POST['select3']))) {
		$hasError = true;
		$errormje = "Seleccione un n&uacute;mero de comprobante...";
	}
	
	$valida_total = ValidarTotal($_POST['Concepto']);
	
	if ((!isset($hasError)) && ($valida_total == 1)) {
		$periodo = TraerImportePeriodo($mes, $ano);
		$ingreso = TraerImporteCargado($mes, $ano, $prop) + $tot;
		if ($ingreso > $periodo){
		   $hasError = true;
		   $errormje = "Est&aacute; ingresando un monto superior al del per&iacute;odo...";
		}
	}
	
	if (!isset($hasError)) {
		$nro_generado = SP_Ingresos(fece($_POST['Fecha']), $_POST['select1'], $_POST['select3'], $_POST['Concepto'], $_POST['CodPropietario'], $_POST['PMes'], $_POST['PAnio'], $_POST['Total']);

		mysql_select_db($database_dbo, $dbo);
		// ----------------------Auditoria ----------------------//
		$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Agregar Ingreso", "text"),
				GetSQLValueString("Codigo: ".$nro_generado." ".$_POST['Fecha']." Nro:".$_POST['select3']." Concepto:".$_POST['Concepto']." Propietario:".$_POST['CodPropietario'], "text"));
		$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
		// -----------------Fin de Auditoria ------------------//

		$insertGoTo = "ingresos.php";
  
		if (isset($_SERVER['QUERY_STRING'])) {
			$insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
			$insertGoTo .= $_SERVER['QUERY_STRING'];
		}
		//header(sprintf("Location: %s", $insertGoTo));
		unset($fcha);
		unset($comp);
		unset($tal);
		unset($nro);
		unset($conc);
		unset($prop);
		unset($mes);
		unset($ano);
		unset($tot);
	}
}

mysql_select_db($database_dbo, $dbo);
$query_Recordset1 = "SELECT i.codigoingreso, i.fechacomprobante, i.fechacarga, 
i.codigocomprobante, i.numerocomprobante, i.codigoconcepto, i.propietario, i.periodomes, i.periodoano, i.estado, 
c.descripcion as descricomprobante, t.descripcion as descriconcepto, p.apellido, p.nombre
FROM ingresos as i LEFT JOIN comprobantes as c ON (i.codigocomprobante = c.codigocomprobante)
LEFT JOIN conceptos as t ON (i.codigoconcepto = t.codigoconcepto and t.tipo = 1)
LEFT JOIN propietarios as p ON (i.propietario = p.codigo)";
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
 
mysql_select_db($database_dbo, $dbo);
$query_Conceptos = "SELECT codigoconcepto, descripcion FROM conceptos WHERE tipo = 1 ORDER BY codigoconcepto";
$Recordset4 = mysql_query($query_Conceptos, $dbo) or die(mysql_error());
$row_Recordset4 = mysql_fetch_assoc($Recordset4);

mysql_select_db($database_dbo, $dbo);
$query_Propietarios = "SELECT p.codigo, CONCAT(d.manzana, ' ',  d.casa, ' ', UPPER(p.apellido), ', ', UPPER(p.nombre)) AS nombre, p.codigopropiedad 
FROM propietarios as p LEFT JOIN propiedad as d ON (p.codigopropiedad = d.codigopropiedad) 
WHERE p.deshabilitado = 0 ORDER BY d.manzana, d.casa";
$Recordset5 = mysql_query($query_Propietarios, $dbo) or die(mysql_error());
$row_Recordset5 = mysql_fetch_assoc($Recordset5);

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><? echo $pantalla;?></title>
<? include($path.'includes/cssyjs.php');?>

<link type="text/css" rel="stylesheet" href="dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"></link>
<script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script> 

<link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="js/selectdependientes.js"></script>
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
      <input type="text" name="Fecha" value="<? echo $fcha; ?>" size="10" onChange="" onBlur="" />
		<span class="textfieldInvalidFormatMsg">Formato no v&aacute;lido.</span></span>
        <input type="button" value="Cal" onclick="displayCalendar(document.forms[0].Fecha,'dd/mm/yyyy',this)"></td>
        </tr>
		
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

		<td nowrap="nowrap" align="right">N&uacute;mero:</td>	
		<td><span id="spryselect8">
	    <select disabled="disabled" name="select3" id="select3" onChange="cargaContenido(this.id)">
		    <option value="0">Seleccione un item..</option>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
		</tr>		
	
	<td nowrap="nowrap" align="right">Concepto:</td>	
		<td><span id="spryselect2">
	    <select name="Concepto" id="spryselect2">
		    <option>Seleccione un item..</option>
			<?php 
				do {  ?>
					<option value="<?php echo $row_Recordset4['codigoconcepto']?>"<?php if (!(strcmp($row_Recordset4['codigoconcepto'], htmlentities($conc, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset4['descripcion']?></option>
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
					<option value="<?php echo $row_Recordset5['codigo']?>"<?php if (!(strcmp($row_Recordset5['codigo'], htmlentities($prop, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $row_Recordset5['nombre']?></option>
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
            <option value="1" <?php if (!(strcmp(1, $mes))) {echo "selected=\"selected\"";} ?>>Enero</option>
            <option value="2" <?php if (!(strcmp(2, $mes))) {echo "selected=\"selected\"";} ?>>Febrero</option>
            <option value="3" <?php if (!(strcmp(3, $mes))) {echo "selected=\"selected\"";} ?>>Marzo</option>
            <option value="4" <?php if (!(strcmp(4, $mes))) {echo "selected=\"selected\"";} ?>>Abril</option>
            <option value="5" <?php if (!(strcmp(5, $mes))) {echo "selected=\"selected\"";} ?>>Mayo</option>
            <option value="6" <?php if (!(strcmp(6, $mes))) {echo "selected=\"selected\"";} ?>>Junio</option>
            <option value="7" <?php if (!(strcmp(7, $mes))) {echo "selected=\"selected\"";} ?>>Julio</option>
            <option value="8" <?php if (!(strcmp(8, $mes))) {echo "selected=\"selected\"";} ?>>Agosto</option>
            <option value="9" <?php if (!(strcmp(9, $mes))) {echo "selected=\"selected\"";} ?>>Septiembre</option>
            <option value="10"<?php if (!(strcmp(10,$mes))) {echo "selected=\"selected\"";} ?>>Octubre</option>
            <option value="11"<?php if (!(strcmp(11,$mes))) {echo "selected=\"selected\"";} ?>>Noviembre</option>
            <option value="12"<?php if (!(strcmp(12,$mes))) {echo "selected=\"selected\"";} ?>>Diciembre</option>
			</select>
	    <span class="selectRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
	
	<tr valign="baseline">
		<td nowrap="nowrap" align="right">Per&iacute;odo (A&ntilde;o):</td>	
		<td><span id="spryselect6">
	    <select name="PAnio" id="select2" value "<? echo date("Y");?>">
			<?php 
				$ano = date("Y");
				for ($i = $ano-5; $i <= $ano + 10; $i++) {
				?>	
					<option value="<?php echo $i ?>"<?php if (!(strcmp($i, htmlentities($ano, ENT_COMPAT, 'utf-8')))) {echo "SELECTED";} ?>><?php echo $i ?></option>
				<?
				}
			?>
			</select>
	    </span></td>
	</tr>
	<tr valign="baseline">
      <td nowrap="nowrap" align="right">Total ($):</td>
      <td><span id="sprytextfield4">
        <input type="text" name="Total" value="<? echo $tot; ?>" size="12" maxlength="8"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
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
		  		<form name="form2" method="post" action="ingresos.php">Buscar por: 
					<select name="Tipo" id="column">
						<option value="1">C&oacute;digo</option>
						<option value="2">Coprobante</option>
						<option value="3">N&uacute;mero</option>
					</select>
					<input type="text" name="txtBusqueda" id="txtBusqueda" />
					<input type="submit" name="cmdBuscar" id="cmdBuscar" value="Buscar" />
					<input type="reset" value="Limpiar" />
				</form>
				<table id="myTable" cellpadding="0" cellpadding="0">
				<tr>
					<td><div align="center">C&oacute;digo </div></td>
					<td><div align="center">Comprobante</div></td>
					<td><div align="center">Per&iacute;odo</div></td>
					<td><div align="center">N&uacute;mero</div></td>
					<td><div align="center">Propietario</div></td>
				</tr>
<?php

mysql_select_db($database_dbo, $dbo);

$sql_count="SELECT MAX(codigoingreso) as total FROM ingresos";
$Rec= mysql_query($sql_count, $dbo) or die(mysql_error());
$row_Rec= mysql_fetch_assoc($Rec);
$cant=$row_Rec['total']-10;

if (($_POST['Tipo']==1) || ($_POST['Tipo']==3)) {
	if (is_numeric($_POST['txtBusqueda'])) {
		$filtro="WHERE i.numerocomprobante = ".$_POST['txtBusqueda']." OR i.codigoingreso = ".$_POST['txtBusqueda'];
	}else{
		$filtro="";
	}
}else {
	$filtro="WHERE c.descripcion like '%".$_POST['txtBusqueda']."%'";
}

if (isset($_POST['txtBusqueda'])) {
	$query_Recordset1 = "SELECT i.codigoingreso, i.fechacomprobante, i.fechacarga, 
						i.codigocomprobante, i.numerocomprobante, i.codigoconcepto, 
						i.propietario, i.periodomes, i.periodoano, i.estado, 
						c.descripcion as descricomprobante, t.descripcion as descriconcepto, p.apellido, p.nombre
						FROM ingresos as i LEFT JOIN comprobantes as c ON (i.codigocomprobante = c.codigocomprobante)
						LEFT JOIN conceptos as t ON (i.codigoconcepto = t.codigoconcepto and t.tipo = 1)
						LEFT JOIN propietarios as p ON (i.propietario = p.codigo) ".$filtro;
} else {
	$query_Recordset1 = "SELECT i.codigoingreso, i.fechacomprobante, i.fechacarga, 
						i.codigocomprobante, i.numerocomprobante, i.codigoconcepto, 
						i.propietario, i.periodomes, i.periodoano, i.estado,
						c.descripcion as descricomprobante, t.descripcion as descriconcepto, p.apellido, p.nombre
						FROM ingresos as i LEFT JOIN comprobantes as c ON (i.codigocomprobante = c.codigocomprobante)
						LEFT JOIN conceptos as t ON (i.codigoconcepto = t.codigoconcepto and t.tipo = 1)
						LEFT JOIN propietarios as p ON (i.propietario = p.codigo) WHERE i.codigoingreso >".$cant;
}
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);

do {?>
	<tr>
		<td><?php echo $row_Recordset1['codigoingreso']; ?></td>
		<td><?php echo $row_Recordset1['descricomprobante']; ?></td>
		<td><?php echo $row_Recordset1['periodomes'].'/'.$row_Recordset1['periodoano']; ?></td>
		<td><?php echo $row_Recordset1['numerocomprobante']; ?></td>
		<td><?php echo strtoupper($row_Recordset1['apellido']).','.strtoupper($row_Recordset1['nombre']); ?></td>
		<td><a href="ingresos_editar.php?id=<?php echo $row_Recordset1['codigoingreso']; ?>"><strong><img src="images/edit.ico"/></strong></a></td>
		<td><a href="ingresos_borrar.php?id=<?php echo $row_Recordset1['codigoingreso']."&numero=".$row_Recordset1['numerocomprobante']."&con=".$row_Recordset1['codigoconcepto']."&pro=".$row_Recordset1['propietario']; ?>" onclick="return confirm('Esta seguro que desea eliminar el registro?');"><strong><img src="images/papel.ico"/></strong></a></td>
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

var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3", "date", {isRequired:true, useCharacterMasking:true, format:"dd/mm/yyyy"});
var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "integer", {useCharacterMasking:true, validateOn:["change"]});
var spryselect2 = new Spry.Widget.ValidationSelect("spryselect2");
var spryselect3 = new Spry.Widget.ValidationSelect("spryselect3");
var spryselect5 = new Spry.Widget.ValidationSelect("spryselect5");
var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4", "real", {useCharacterMasking:true, validateOn:["change"]});

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
	mysql_free_result($Recordset2);
	mysql_free_result($Recordset3);
	mysql_free_result($Recordset4);
	mysql_free_result($Recordset5);
?>
