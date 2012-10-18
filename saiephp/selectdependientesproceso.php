<?php
require_once('Connections/dbo.php');

// Array que vincula los IDs de los selects declarados en el HTML con el nombre de la tabla donde se encuentra su contenido
$listadoSelects=array(
"select1"=>"select_1",
"select2"=>"select_2",
"select3"=>"select_3"
);

function validaSelect($selectDestino)
{
	// Se valida que el select enviado via GET exista
	global $listadoSelects;
	if(isset($listadoSelects[$selectDestino])) return true;
	else return false;
}

function validaOpcion($opcionSeleccionada)
{
	// Se valida que la opcion seleccionada por el usuario en el select tenga un valor numerico
	if(is_numeric($opcionSeleccionada)) return true;
	else return false;
}

$selectDestino=$_GET["select"]; $opcionSeleccionada=$_GET["opcion"];

if(validaSelect($selectDestino) && validaOpcion($opcionSeleccionada))
{
	if ($_GET["select"]=='select2'){
		$tabla=$listadoSelects[$selectDestino];
		mysql_select_db($database_dbo, $dbo);
		//$consulta=mysql_query("SELECT id, opcion FROM $tabla WHERE relacion='$opcionSeleccionada'") or die(mysql_error());
		$consulta=mysql_query("SELECT codigotalonario, CONCAT(LPAD(numerodesde, 8, '0'), ' - ', LPAD(numerohasta, 8, '0')) FROM talonarios WHERE codigocomprobante='$opcionSeleccionada' AND estado = 1 ORDER BY numerodesde") or die(mysql_error());
	
		// Comienzo a imprimir el select
		echo "<select name='".$selectDestino."' id='".$selectDestino."' onChange='cargaContenido(this.id)'>";
		echo "<option value='0'>Seleccione un item..</option>";
		while($registro=mysql_fetch_row($consulta))
		{
			// Convierto los caracteres conflictivos a sus entidades HTML correspondientes para su correcta visualizacion
			$registro[1]=htmlentities($registro[1]);
			// Imprimo las opciones del select
			echo "<option value='".$registro[0]."'>".$registro[1]."</option>";
		}			
		echo "</select>";
		mysql_free_result($consulta);
	} else {
		$tabla=$listadoSelects[$selectDestino];
		mysql_select_db($database_dbo, $dbo);
		// Busco el rango de números del talonario
		$consulta=mysql_query("SELECT numerodesde, numerohasta, codigocomprobante FROM talonarios WHERE codigotalonario = $opcionSeleccionada") or die(mysql_error());
		$registro = mysql_fetch_row($consulta);
		
		// Comienzo a imprimir el select
		echo "<select name='".$selectDestino."' id='".$selectDestino."' onChange='cargaContenido(this.id)'>";
		echo "<option value='0'>Seleccione un item..</option>";
		for ($i=$registro[0]; $i<=$registro[1]; $i++){
			$filtro = mysql_query("SELECT numerocomprobante FROM ingresos WHERE codigocomprobante =".$registro[2]." and numerocomprobante =".$i) or die(mysql_error());
			$regi = mysql_fetch_row($filtro);
			if (!isset($regi[0])) {
				echo "<option value='".$i."'>".$i."</option>";
			}
		}
		echo "</select>";
		mysql_free_result($consulta);
	}
}
?>
