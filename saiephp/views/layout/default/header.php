<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title><?php if(isset($this->titulo)) echo $this->titulo; ?></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf8" />

        <link href="<?php echo $_layoutParams['ruta_css']; ?>blitzer/jquery-ui-1.8.16.custom.css" rel="stylesheet" type="text/css" />        
        
        <link href="<?php echo $_layoutParams['ruta_css']; ?>blueprint/screen.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $_layoutParams['ruta_css']; ?>blueprint/print.css" rel="stylesheet" type="text/css" />        
<!--[if lt IE 10]><link rel="<?php echo $_layoutParams['ruta_css']; ?>blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->        
        
        
        <script src="<?php echo $_layoutParams['js']; ?>jquery/jquery-1.6.2.min.js" type="text/javascript"></script>
    
        <?php if(isset($_layoutParams['js']) && count($_layoutParams['js'])): ?>
        <?php for($i=0; $i < count($_layoutParams['js']); $i++): ?>
        
        <script src="<?php echo $_layoutParams['js'][$i] ?>" type="text/javascript"></script>
        
        <?php endfor; ?>
        <?php endif; ?>
    
    </head>

    <body>
            <div class="container showgrid">
                <div class="span-24 prepend-top append-bottom">
                    <img src="<?php echo $_layoutParams['ruta_img']; ?>cabecera1.png" alt="cargando..." />
                </div>
                <div class="clear"></div>

                      