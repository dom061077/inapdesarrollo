<? 
$pantalla="Ingreso al Sistema"; 

if (!isset($_SESSION)) {
  session_start();
}  

if (!isset($_SESSION['MM_Username'])) {
	header("location:index.php");
	exit;
}

require_once('includes/menu.php');

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>AVBC</title>
    <meta name="description" content="Description" />
    <meta name="keywords" content="Keywords" />
    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="script.js"></script>
	<link rel="stylesheet" href="css/slide-out-menu-new.css" media="screen" type="text/css">
	<script type="text/javascript" src="js/slide-out-menu-new.js"></script>

<script language="JavaScript" type="text/JavaScript">
	function MM_reloadPage(init) {  //reloads the window if Nav4 resized
		if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
				document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
		else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
	}
	MM_reloadPage(true);
</script>

</head>

<body>
		<?
		$userid=$_SESSION['MM_Username'];
		$groupid=$_SESSION['MM_UserGroup'];
		?>
<div id="art-page-background-glare">
    <div id="art-page-background-glare-image"> </div>
</div>
<div id="art-main">
    <div class="art-sheet">
        <div class="art-sheet-tl"></div>
        <div class="art-sheet-tr"></div>
        <div class="art-sheet-bl"></div>
        <div class="art-sheet-br"></div>
        <div class="art-sheet-tc"></div>
        <div class="art-sheet-bc"></div>
        <div class="art-sheet-cl"></div>
        <div class="art-sheet-cr"></div>
        <div class="art-sheet-cc"></div>
        <div class="art-sheet-body">
            <div class="art-header">
                <div class="art-header-clip">
                <div class="art-header-center">
                    <div class="art-header-png"></div>
                    <div class="art-header-jpeg"></div>
                </div>
                </div>
                <div class="art-logo">
                                <!--<h1 class="art-logo-name"><a href="salir.php">AVBC.NET</a></h1>
                                <h2 class="art-logo-text">Barrio Congreso </h2> -->
								<td><img src="images/logo.png"></td>
								<h2 class="art-logo-text">AVBC.NET</h2>
          </div>
            </div>
            <div class="cleared reset-box"></div>
<div class="art-nav">
	<div class="art-nav-l"></div>
	<div class="art-nav-r"></div>
<div class="art-nav-outer">
	<ul class="art-hmenu">
		<li>
		<!--	<a href="#" class="active"><span class="l"></span><span class="r"></span><span class="t">Contenido</span></a> -->
		</li>	
	</ul>
</div>
	<div class="art-vmenublockheader">
       <h3 class="t" align="right">Usuario registrado: <?echo $userid. "  ".date("d/m/Y H:i");?></h3>
    </div>	
</div>
<div class="cleared reset-box"></div>
<div class="art-content-layout">
                <div class="art-content-layout-row">
                    <div class="art-layout-cell art-sidebar1">
<div class="art-vmenublock">
    <div class="art-vmenublock-body">
                <div class="art-vmenublockheader">
                    <h3 class="t">Menu principal</h3>
                </div>
				
	<div>
		<!--- START MENU HTML -->
		<?php
			switch ($groupid) { 
				case '1': echo $menu_admin; break;
				case '2': echo $menu_super; break;
				case '3': echo $menu_oper; break;
			}
		?>
		<!-- END MENU HTML-->
	</div>
				
		<div class="cleared"></div>
    </div>
</div>
<div class="art-block">
    <div class="art-block-body">
                <div class="art-blockheader">
                    <h3 class="t">Contenido</h3>
                </div>
                <div class="art-blockcontent">
                    <div class="art-blockcontent-body">
                <p>Nuevas actualizaciones...</p>
<p>Usted puede comenzar a usar la nueva versión del sistema y administrar su consorcio de la mejor manera. </p>                
                                		<div class="cleared"></div>
                    </div>
                </div>
		<div class="cleared"></div>
    </div>
</div>

                      <div class="cleared"></div>
                    </div>
                    <div class="art-layout-cell art-content">
					
<?php 
	$anio  = date("Y"); 
	$mes   = date("m")-1;
	$desde = "01/".$mes."/".$anio;
	$hasta = date("d")."/".date("m")."/".$anio;
	$ref = "listados/imp_ing_egragrupado.php?desde=".$desde."&hasta=".$hasta;
?>

<div class="art-post">
    <div class="art-post-body">
<div class="art-post-inner art-article">
                                <h2 class="art-postheader">Administrador Barrio Congreso
                                </h2>
                <div class="cleared"></div>
                                <div class="art-postcontent">
<p><strong>Lea por favor el contenido...</strong></p>
<p>Este sistema fue diseñado para el registro, control y elaboración de información de los movimientos de ingresos y egresos de <strong>AVBC</strong>. </p>
<p>Encontrara en &eacute;l diversas secciones de distinto interés todas ellas interrelacionadas a fin de agilizar y consolidar la información resultante de las registraciones realizadas. </p>
<p>Para mayor información comunicarse por teléfono al (<strong>0381</strong>)155465637 o por <strong><a href="mailto:jorgeski@hotmail.com.ar">mail</a></strong></p>
<!--<p><img src="images/chart.png" alt="an image" style="float:left" /><strong>Nuevas opciones:</strong> presente en el menú listados/Chart Ingresos-Egresos, muestra de forma muy sencilla y rápida los importes totales de lo que ingresa y lo que egresa del sistema.</p> -->
<HR>
<p><img src="images/chart.png" alt="an image" style="float:left" /><strong>Nuevas opciones:</strong> presentes en el menú listados. <a href="<?php echo $ref;?>">Movimientos</a>, se pueden mostrar agrupados por concepto y detallados. <a href="listados/imp_chartingreso.php?anio=<?php echo $anio;?>">Chart Ingresos-Egresos</a>, muestra de forma rápida los importes totales de lo que ingresa y lo que egresa del sistema.</p>
                </div>
                <div class="cleared"></div>
                </div>

		<div class="cleared"></div>
    </div>
</div>

                      <div class="cleared"></div>
                    </div>
                </div>
            </div>
            <div class="cleared"></div>
            <div class="art-footer">
                <div class="art-footer-t"></div>
                <div class="art-footer-l"></div>
                <div class="art-footer-b"></div>
                <div class="art-footer-r"></div>
                <div class="art-footer-body">
                    <a href="#" class="art-rss-tag-icon" title="RSS"></a>
                            <div class="art-footer-text">
                                <p><a href="http://www.barriocongresotuc.com.ar">principal</a></p><p>Copyright © 2011. Todos los derechos reservados.</p>
                            </div>
                    <div class="cleared"></div>
                </div>
            </div>
    		<div class="cleared"></div>
        </div>
    </div>
    <div class="cleared"></div>
    <!--<p class="art-page-footer"><a href="http://www.inap.com.ar">Creado por INAP.</a> </p>-->
</div>

</body>
</html>
