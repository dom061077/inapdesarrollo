<?php
ob_start();
require_once('Connections/dbo.php');

if (!isset($_SESSION)) {
  session_start();
}

if (isset($_POST['username'])) {
  $loginUsername=$_POST['username'];
  $password=$_POST['password'];
  $MM_redirectLoginSuccess = "principal.php";
  $MM_redirectLoginFailed = "error_login.php";
  $MM_redirecttoReferrer = false;
  
  mysql_select_db($database_dbo, $dbo);
  	
  $LoginRS__query=sprintf("SELECT usuario, password, codigogrupo FROM usuariosweb WHERE usuario='".$loginUsername."'AND password='".md5($password)."'");
  
  $LoginRS = mysql_query($LoginRS__query, $dbo) or die(mysql_error());
  $loginFoundUser = mysql_num_rows($LoginRS);

  if ($loginFoundUser) {
	$loginStrGroup  = mysql_result($LoginRS,0,'codigogrupo');    
	
	$_SESSION['MM_Username'] = $loginUsername;
	$_SESSION['MM_UserGroup'] = $loginStrGroup;	      
	
    if (isset($_SESSION['PrevUrl']) && false) {
      $MM_redirectLoginSuccess = $_SESSION['PrevUrl'];	
    }
	header("Location: " . $MM_redirectLoginSuccess );
  }else{
	$hasError = true;
	if($loginUsername == ""){
		$errormje = "Debe ingresar un nombre de usuario";
	}elseif ($password == ""){
		$errormje = "Debe ingresar la contrase&ntilde;a del usuario";
	}else{
		//header("Location: ". $MM_redirectLoginFailed );
		$errormje = "Usuario o contrase&ntilde;a incorrecta";
		}
	}	
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Login</title>
	<link rel="stylesheet" type="text/css" href="css/style.css"/>
	<link href="SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />

<style type="text/css">
body {
	background-color: #FFFFFF;
}
</style></head>
	
</head>

<body body onload="document.getElementById('nameid').focus()">
	<center>
	   <div id="login-box">
       <H2>SAIE.NET</H2>
		
		<?php 
			if(isset($hasError)){
				echo $errormje; 
				$hasError = false;
			} 
		?> 
<br />
<form id="form1" name="form1" method="POST" action="index.php">

		<table border="0" cellpadding=4 align="left">
		<tr><td align="right" class=rowhead>Usuario:</td>
		<td align=left>
		<input id="nameid" type="text" size=40 name="username" /></td></tr>
		<tr><td align="right" class=rowhead>Password:</td>
		<td align=left>	<span id="sprytextfield2">
		<input id="passid" type="password" size=40 name="password" /></td></tr>
		<tr><td colspan="2" align="right">
			<input type="submit" class="guardar" value="" />
			<!--<input type="submit" value="Aceptar" class=btn>
		<input type="Button" value="Cancelar" onclick="location.href='sesioncancelada.php'">-->
		</td></tr>
</table>

</form></div>

<p align="center"><b>Si tiene problemas con el ingreso al sistema cont&aacute;ctese con el <strong><a href="mailto:jorgeski@hotmail.com.ar">Soporte T&eacute;cnico</a></strong></b></p>
</div>
<div id="footer"><p><? include('includes/pie.php'); ?></p></div>
</body>
</html>