<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php'); 

$pantalla="Editar Cuota Código: ".$_GET['id']; 
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
$query_Recordset1 = sprintf("SELECT periodomes, periodoano, importe FROM cuotas WHERE codigo = %s", GetSQLValueString($colname_Recordset1, "text"));
$Recordset1 = mysql_query($query_Recordset1, $dbo) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
$totalRows_Recordset1 = mysql_num_rows($Recordset1);

$mes 	= $row_Recordset1['periodomes'];
$anio 	= $row_Recordset1['periodoanio'];
$tol 	= $row_Recordset1['importe'];

if ((isset($_POST["MM_update"])) && ($_POST["MM_update"] == "form1")) {
	$sql= sprintf("SELECT * FROM cuotas WHERE periodomes = %s AND periodoano = %s AND codigo <> %s",
						GetSQLValueString($_POST['PMes'], "text"),
						GetSQLValueString($_POST['PAnio'], "text"),
						GetSQLValueString($colname_Recordset1, "text"));
	$result = mysql_query($sql, $dbo) or die(mysql_error());
	$row_Rec = mysql_fetch_assoc($result);
	$control = mysql_num_rows($result);
	mysql_free_result($result);
	if ($control > 0){
		$hasError = true;
		$errormje = "Ya se ingres&oacute esta cuota para el pe&iacute;odo ".$_POST['PMes']."/".$_POST['PAnio']."...";
	}

	$mes 	= $_POST['PMes'];
	$anio 	= $_POST['PAnio'];
	$tol 	= $_POST['Total'];
	
	if(!isset($hasError)) {
		$insertSQL = sprintf("UPDATE cuotas SET periodomes=%s, periodoano=%s, importe=%s WHERE codigo=%s",
				GetSQLValueString($_POST['PMes'], "text"),
				GetSQLValueString($_POST['PAnio'], "text"),
				GetSQLValueString($_POST['Total'], "text"),
				GetSQLValueString($_GET['id'], "text"));
  
		mysql_select_db($database_dbo, $dbo);
		$Result1 = mysql_query($insertSQL, $dbo) or die(mysql_error());

		$datos=" Periodo: ".$_POST['PMes']."/".$_POST['PAnio'];
	
		// ----------------------Auditoria ----------------------//
		$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
					GetSQLValueString($_SESSION['MM_Username'], "text"),
					GetSQLValueString("Modificar Cuota", "text"),
					GetSQLValueString("Codigo: ".$_GET['id']." ".$datos, "text"));
		$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
		// -----------------Fin de Auditoria ------------------//
  
		$deleteGoTo = "cuotas.php";
  
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
	<td nowrap="nowrap" align="right">Per&iacute;odo (Mes):</td>	
		<td><span id="spryselect1">
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
		<td><span id="spryselect2">
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
      <td><span id="sprytextfield1">
        <input type="text" name="Total" value="<? echo $tol; ?>" size="12" maxlength="8"/>
      <span class="textfieldRequiredMsg">Se necesita un valor.</span></span></td>
	</tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">&nbsp;</td>
      <td><input type="submit" value="Aceptar" /></td>
    </tr>
  </table>
  <input type="hidden" name="MM_update" value="form1" />
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
  <p class="cerrar"><a href="<?echo $path;?>cuotas.php">Volver</a></p>
  <br class="clearfloat" />
  <div id="footer"><p><? include($path.'includes/pie.php');?></p></div>
</div>
<p>&nbsp;</p>
<script type="text/javascript">

var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "real", {useCharacterMasking:true, validateOn:["change"]});
var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1");
var spryselect2 = new Spry.Widget.ValidationSelect("spryselect2");

</script>

</body>
</html>
<?php
	mysql_free_result($Recordset1);
?>
