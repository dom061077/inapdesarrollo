<? 
$pantalla="Ingreso al Sistema"; 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}


?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>SAIE.NET</title>
    <meta name="description" content="Description" />
    <meta name="keywords" content="Keywords" />
    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="script.js"></script>
	<link rel="stylesheet" href="css/slide-out-menu-new.css" media="screen" type="text/css">
	<script type="text/javascript" src="js/slide-out-menu-new.js"></script>


</head>

<body>



</body>
</html>
