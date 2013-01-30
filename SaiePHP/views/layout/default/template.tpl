<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>{$titulo|default:"Sin titulo"}</title>
        
        <meta http-equiv="Content-Type" content="text/html; charset=utf8" />
        
        <link href="{$_layoutParams.ruta_css}blitzer/jquery-ui-1.8.16.custom.css" rel="stylesheet" type="text/css" />

        <link href="{$_layoutParams.ruta_css}blueprint/screen.css" rel="stylesheet" type="text/css" />
        <link href="{$_layoutParams.ruta_css}blueprint/print.css" rel="stylesheet" type="text/css" media="print"/>        
<!--[if lt IE 10]><link rel="{$_layoutParams.ruta_css}blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->                
         <link rel="stylesheet" href="{$_layoutParams.ruta_css}menu/flickr/helper.css" />
         <link rel="stylesheet" href="{$_layoutParams.ruta_css}menu/dropdown.css" />    
         <link rel="stylesheet" href="{$_layoutParams.ruta_css}menu/flickr/default.ultimate.css" />         
         <link rel="stylesheet" href="{$_layoutParams.root}public/js/jqgrid/src/css/ui.jqgrid.css"/>         
         <link rel="stylesheet" href="{$_layoutParams.root}public/js/jqgrid/src/css/jquery.searchFilter.css"/>         

        <link rel="stylesheet" href="{$_layoutParams.ruta_css}estilos.css"/>
         
        
        <script src="{$_layoutParams.root}public/js/jquery/jquery-1.6.2.min.js" type="text/javascript"></script>
        <script src="{$_layoutParams.root}public/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
        <script src="{$_layoutParams.root}public/js/jquery-ui/jquery-ui-i18n.js" type="text/javascript"></script>        
        
        <script src="{$_layoutParams.root}public/js/jqgrid/src/i18n/grid.locale-es.js" type="text/javascript"> </script>                
        <script src="{$_layoutParams.root}public/js/jqgrid/jquery.jqGrid.min.js" type="text/javascript"> </script>        
        <script src="{$_layoutParams.root}public/js/jquery/jquery.jlookupfieldcascade.js" type="text/javascript"> </script>

    
        {if isset($_layoutParams.js) && count($_layoutParams.js)}
        {foreach item=js from=$_layoutParams.js}
        
        <script src="{$js}" type="text/javascript"></script>
        
        {/foreach}
        {/if}
        <script type="text/javascript">
                $(function(){
                    $.datepicker.setDefaults($.datepicker.regional[ 'es' ]);
                });
        </script>        
        <style type="text/css">
            body{
                font-size: 65%;
            }
        </style>
    </head>

        <body>
            <div class="container">
                <div class="span-24 prepend-top append-bottom">
                    <div class="span-24 prepend-top append-bottom">
                        <img src="{$_layoutParams.root}/public/img/cabecera1.png" alt="Cargando..." />
                        <!-- h1>{$_layoutParams.configs.app_name}</h1 -->
                    </div>
                    

                    <div id="menuh">
                            <ul id="nav" class="dropdown dropdown-horizontal">
                            {if isset($_layoutParams.menu)}
                            {foreach item=it from=$_layoutParams.menu}
                            
                            {if isset($_layoutParams.item) && $_layoutParams.item == $it.id}                                
                                {assign var="_item_style" value='current'}
                                
                            {else}
                            
                                {assign var="_item_style" value=''}
                                
                            {/if}
                            
                            <li><a  class="{$_item_style}" href="{$it.enlace}" title="Referencia">{$it.titulo}</a></li>

                            {/foreach}
                            {/if}
                            </ul>
                    </div>
                </div> <!-- div final del header -->
                <div class="clear"></div>
                
                <div class="span-20 prepend-2">
                    <noscript><p>Para el correcto funcionamiento debe tener el soporte de javascript habilitado</p></noscript>
                    <h1> {$titulo|default:"Sin titulo"} </h1>                       

                    {if isset($_mensaje)}
                    <div id="mensaje">{$_mensaje}</div>
                    {/if}
                    {include file=$_contenido}
                    
                </div>
                <div class="clear"></div>    
                <div style="padding-top:5px;height:25px;background:url({$_layoutParams.root}/public/img/footer1.png) no-repeat"  class="span-24 prepend-top">
                    <p style="text-align:center">
                     &copy; Copyright 2011 &lt;INAP&gt; | Design by: Marca Registrada
                    </p>
                </div><!-- end footer -->
                <div class="clear"></div>

           </div>
       </body>
</html>