<?php 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('Connections/dbo.php'); 
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

if ((isset($_GET['id'])) && ($_GET['id'] != "")) {

	mysql_select_db($database_dbo, $dbo);
	$sql= sprintf("SELECT codigocomprobante FROM ingresos WHERE codigocomprobante = %s UNION SELECT codigocomprobante FROM egresos WHERE codigocomprobante = %s",
						GetSQLValueString($_GET['id'], "text"),
						GetSQLValueString($_GET['id'], "text"));
	$result = mysql_query($sql, $dbo) or die(mysql_error());
	$row_Rec = mysql_fetch_assoc($result);
	$control = mysql_num_rows($result);

	if ($control > 0){
		header ("Location: comprobantes.php?error=1");
	} else {
		$deleteSQL = sprintf("DELETE FROM comprobantes WHERE codigocomprobante=%s",
							GetSQLValueString($_GET['id'], "text"));

		mysql_select_db($database_dbo, $dbo);
		$Result1 = mysql_query($deleteSQL, $dbo) or die(mysql_error());

		$nombre_c=$_GET['nombre'];
		// ----------------------Auditoria ----------------------//
		$_SQL = sprintf("INSERT INTO logging (usuario, fecha, tipotransaccion, descripcion) VALUES (%s, now(), %s, %s)",
					GetSQLValueString($_SESSION['MM_Username'], "text"),
					GetSQLValueString("Eliminar Comprobante", "text"),
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
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
</head>

<body>
</body>
</html>