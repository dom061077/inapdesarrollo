<?php
require_once('Connections/dbo.php');
?>

<?php

function SP_Cobrador($nombre, $direccion, $telefono){
$mysqli = mysqli_init();	
$mysqli->real_connect('localhost', 'root', '', 'barrio');
if (mysqli_connect_errno())
{
    printf("Fallo la conexión: %s\n", mysqli_connect_error());
    exit();
}
if($mysqli->real_query ("call SP_Cobrador ('$nombre','$direccion','$telefono')"))
{
	if($objResult = $mysqli->store_result())
	{
		while($row = $objResult->fetch_assoc())
		{
			$numero=$row["@p_codigocobrador"];
		}
		$objResult->free_result();
	}
	else
	{
		print "Sin resultado";
	}
}
else
{	
	print $mysqli->error;
}
$mysqli->close();	

return $numero;
}

function SP_Propietario($apellido, $nombre, $telefono, $mail, $codigopropiedad, $calle, $numerocalle, $tipopago, $deshabilitado){
$mysqli = mysqli_init();	
$mysqli->real_connect('localhost', 'root', '', 'barrio');
if (mysqli_connect_errno())
{
    printf("Fallo la conexión: %s\n", mysqli_connect_error());
    exit();
}
if($mysqli->real_query ("call SP_Propietario ('$apellido', '$nombre', '$telefono', '$mail', '$codigopropiedad', '$calle', '$numerocalle', '$tipopago', '$deshabilitado')"))
{
	if($objResult = $mysqli->store_result())
	{
		while($row = $objResult->fetch_assoc())
		{
			$numero=$row["@p_codigo"];
		}
		$objResult->free_result();
	}
	else
	{
		print "Sin resultado";
	}
}
else
{	
	print $mysqli->error;
}
$mysqli->close();	

return $numero;
}

function SP_Comprobante($descripcion, $tipo){
$mysqli = mysqli_init();	
$mysqli->real_connect('localhost', 'root', '', 'barrio');
if (mysqli_connect_errno())
{
    printf("Fallo la conexión: %s\n", mysqli_connect_error());
    exit();
}
if($mysqli->real_query ("call SP_Comprobante ('$descripcion', '$tipo')"))
{
	if($objResult = $mysqli->store_result())
	{
		while($row = $objResult->fetch_assoc())
		{
			$numero=$row["@p_codigo"];
		}
		$objResult->free_result();
	}
	else
	{
		print "Sin resultado";
	}
}
else
{	
	print $mysqli->error;
}
$mysqli->close();	

return $numero;
}

function SP_Talonario($codigocomprobante, $numerodesde, $numerohasta, $codigocobrador){
$mysqli = mysqli_init();	
$mysqli->real_connect('localhost', 'root', '', 'barrio');
if (mysqli_connect_errno())
{
    printf("Fallo la conexión: %s\n", mysqli_connect_error());
    exit();
}
if($mysqli->real_query ("call SP_Talonario ('$codigocomprobante', '$numerodesde', '$numerohasta', '$codigocobrador')"))
{
	if($objResult = $mysqli->store_result())
	{
		while($row = $objResult->fetch_assoc())
		{
			$numero=$row["@p_codigo"];
		}
		$objResult->free_result();
	}
	else
	{
		print "Sin resultado";
	}
}
else
{	
	print $mysqli->error;
}
$mysqli->close();	

return $numero;
}

function SP_Ingresos($fechacomprobante, $codigocomprobante, $numerocomprobante, $codigoconcepto, $propietario, $periodomes, $periodoano, $total){
$mysqli = mysqli_init();	
$mysqli->real_connect('localhost', 'root', '', 'barrio');
if (mysqli_connect_errno())
{
    printf("Fallo la conexión: %s\n", mysqli_connect_error());
    exit();
}
if($mysqli->real_query ("call SP_Ingreso ('$fechacomprobante', '$codigocomprobante', '$numerocomprobante', '$codigoconcepto', '$propietario', '$periodomes', '$periodoano', '$total')"))
{
	if($objResult = $mysqli->store_result())
	{
		while($row = $objResult->fetch_assoc())
		{
			$numero=$row["@p_codigo"];
		}
		$objResult->free_result();
	}
	else
	{
		print "Sin resultado";
	}
}
else
{	
	print $mysqli->error;
}
$mysqli->close();	

return $numero;
}

function SP_Egresos($fechacomprobante, $codigocomprobante, $numerocomprobante, $codigoconcepto, $descripcion, $total){
$mysqli = mysqli_init();	
$mysqli->real_connect('localhost', 'root', '', 'barrio');
if (mysqli_connect_errno())
{
    printf("Fallo la conexión: %s\n", mysqli_connect_error());
    exit();
}
if($mysqli->real_query ("call SP_Egreso ('$fechacomprobante', '$codigocomprobante', '$numerocomprobante', '$codigoconcepto', '$descripcion', '$total')"))
{
	if($objResult = $mysqli->store_result())
	{
		while($row = $objResult->fetch_assoc())
		{
			$numero=$row["@p_codigo"];
		}
		$objResult->free_result();
	}
	else
	{
		print "Sin resultado";
	}
}
else
{	
	print $mysqli->error;
}
$mysqli->close();	

return $numero;
}

function SP_Cuota($periodomes, $periodoano, $importe){
$mysqli = mysqli_init();	
$mysqli->real_connect('localhost', 'root', '', 'barrio');
if (mysqli_connect_errno())
{
    printf("Fallo la conexión: %s\n", mysqli_connect_error());
    exit();
}
if($mysqli->real_query ("call SP_Cuota ('$periodomes', '$periodoano', '$importe')"))
{
	if($objResult = $mysqli->store_result())
	{
		while($row = $objResult->fetch_assoc())
		{
			$numero=$row["@p_codigo"];
		}
		$objResult->free_result();
	}
	else
	{
		print "Sin resultado";
	}
}
else
{	
	print $mysqli->error;
}
$mysqli->close();	

return $numero;
}

function TraerImportePeriodo($mes, $ano){
$mysqli = mysqli_init();	
$mysqli->real_connect('localhost', 'root', '', 'barrio');
if (mysqli_connect_errno())
{
    printf("Fallo la conexión: %s\n", mysqli_connect_error());
    exit();
}
if($mysqli->real_query ("SELECT importe FROM cuotas WHERE periodomes = '$mes' AND periodoano = '$ano'"))
{
	if($objResult = $mysqli->store_result())
	{
		while($row = $objResult->fetch_assoc())
		{
			$numero=$row["importe"];
		}
		$objResult->free_result();
	}
	else
	{
		print "Sin resultado";
	}
}
else
{	
	print $mysqli->error;
}
$mysqli->close();	

return $numero;
}	

function TraerImporteCargado($mes, $ano, $prop){
$mysqli = mysqli_init();	
$mysqli->real_connect('localhost', 'root', '', 'barrio');
if (mysqli_connect_errno())
{
    printf("Fallo la conexión: %s\n", mysqli_connect_error());
    exit();
}
if($mysqli->real_query ("SELECT SUM(total) as importe FROM ingresos WHERE periodomes = '$mes' AND periodoano = '$ano' AND propietario = '$prop'"))
{
	if($objResult = $mysqli->store_result())
	{
		while($row = $objResult->fetch_assoc())
		{
			$numero=$row["importe"];
		}
		$objResult->free_result();
	}
	else
	{
		print "Sin resultado";
	}
}
else
{	
	print $mysqli->error;
}
$mysqli->close();	

return $numero;
}	

function ValidarTotal($conc){
$mysqli = mysqli_init();	
$mysqli->real_connect('localhost', 'root', '', 'barrio');
if (mysqli_connect_errno())
{
    printf("Fallo la conexión: %s\n", mysqli_connect_error());
    exit();
}
if($mysqli->real_query ("SELECT validatotal FROM conceptos WHERE codigoconcepto = '$conc'"))
{
	if($objResult = $mysqli->store_result())
	{
		while($row = $objResult->fetch_assoc())
		{
			$numero=$row["validatotal"];
		}
		$objResult->free_result();
	}
	else
	{
		print "Sin resultado";
	}
}
else
{	
	print $mysqli->error;
}
$mysqli->close();	

return $numero;
}	

?>
