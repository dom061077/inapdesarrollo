<?php

// Calcula la edad (formato: año/mes/dia)
function edad($edad){
list($dia,$mes,$anio) = explode("/",$edad);
$anio_dif = date("Y") - $anio;
$mes_dif = date("m") - $mes;
$dia_dif = date("d") - $dia;
if ($dia_dif < 0 || $mes_dif < 0)
$anio_dif--;
return $anio_dif;
}

?>
<?=edad($_GET["edad"]);?>