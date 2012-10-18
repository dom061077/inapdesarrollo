<?php
function fece($cad){
$uno=substr($cad, 0, 2);
$dos=substr($cad, 3, 2);
$tres=substr($cad, 6, 4);
$cad2 = ($tres."/".$dos."/".$uno);
return $cad2;
}

function fecs($cad2){
$tres=substr($cad2, 0, 4);
$dos=substr($cad2, 5, 2);
$uno=substr($cad2, 8, 2);
$cad = ($uno."/".$dos."/".$tres);
return $cad;
}

function fecshs($cad2){
$tres=substr($cad2, 0, 4);
$dos=substr($cad2, 5, 2);
$uno=substr($cad2, 8, 2);
$hh=substr($cad2, 11, 5);
$cad = ($uno."/".$dos."/".$tres." ".$hh);
return $cad;
}

?>