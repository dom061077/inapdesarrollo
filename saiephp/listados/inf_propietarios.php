<?php
$pantalla='Generar Informe de Propietarios';

require_once('../Connections/dbo.php');
  
if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:../index.php");
	exit;
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

if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "form1")) {
  $insertGoTo = "imp_propietarios.php?orden=".$_POST['orden']."&activo=".$_POST['activo'];
 
	mysql_select_db($database_dbo, $dbo);
	// ----------------------Auditoria ----------------------//
	$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
				GetSQLValueString($_SESSION['MM_Username'], "text"),
				GetSQLValueString("Genera Informe", "text"),
				GetSQLValueString("Propietarios", "text"));
	$R_auditoria = mysql_query($_SQL, $dbo) or die(mysql_error());
	// -----------------Fin de Auditoria ------------------//
 
  if (isset($_SERVER['QUERY_STRING'])) {
    $insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
    $insertGoTo .= $_SERVER['QUERY_STRING'];
  }
  header(sprintf("Location: %s", $insertGoTo));
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma"content="no-cache" />
<meta http-equiv="expires"content="0" />
<title>Informe de Propietarios</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="../dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"></link>


<link href="../SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
<script src="../SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>

</head>

<body>
<div id="contenedor">
 <div id="container1" >
  <h1><?php echo $pantalla;?></h1>
<form action="<?php echo $editFormAction; ?>" method="post" name="form1" id="form1">
  <div align="center"></div>
  <div align="center">
    <table width="303" border="0">
      <!--DWLayoutTable-->
        <tr>
          <td width="113">Orden del listado </td>
          <td width="180"><div align="left">
            <select name="orden" id="orden" tabindex="1">
                <option value="Codigo">Codigo</option>
                <option value="Apellido">Apellido</option>
                <option value="Manzana">Manzana</option>
            </select>
          </div></td>
        </tr>
        <tr>
          <td height="60" valign="top">Filtrado por: </td>
		  <td><p align="left">
                <fieldset><legend>Elija opci&oacute;n</legend>
				
				<div align="left">
                <label>
                <input name="activo" type="radio" id="activo" tabindex="20" value="1" checked />
				Todos</label>
                <br />            
                <label>
                <input tabindex="21" type="radio" name="activo" value="2" id="activo" />
				Habilitados</label>
                <br />
                <input tabindex="21" type="radio" name="activo" value="3" id="activo" />
                Deshabilitados
				
				</div>
                </fieldset>
			</p></td>
			
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
</body>
</html>