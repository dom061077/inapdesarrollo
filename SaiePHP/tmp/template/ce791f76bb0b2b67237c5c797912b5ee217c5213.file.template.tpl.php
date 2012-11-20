<?php /* Smarty version Smarty-3.1.8, created on 2012-11-19 20:08:33
         compiled from "C:\xampp\htdocs\poomvc19\views\layout\default\template.tpl" */ ?>
<?php /*%%SmartyHeaderCode:137650918084178f32-27000687%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'ce791f76bb0b2b67237c5c797912b5ee217c5213' => 
    array (
      0 => 'C:\\xampp\\htdocs\\poomvc19\\views\\layout\\default\\template.tpl',
      1 => 1353352109,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '137650918084178f32-27000687',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_50918084965ae6_32233276',
  'variables' => 
  array (
    'titulo' => 0,
    '_layoutParams' => 0,
    'js' => 0,
    'it' => 0,
    '_item_style' => 0,
    '_error' => 0,
    '_mensaje' => 0,
    '_contenido' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_50918084965ae6_32233276')) {function content_50918084965ae6_32233276($_smarty_tpl) {?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title><?php echo (($tmp = @$_smarty_tpl->tpl_vars['titulo']->value)===null||$tmp==='' ? "Sin titulo" : $tmp);?>
</title>
        
        <meta http-equiv="Content-Type" content="text/html; charset=utf8" />
        
        <link href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['ruta_css'];?>
blitzer/jquery-ui-1.8.16.custom.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['ruta_css'];?>
blueprint/screen.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['ruta_css'];?>
blueprint/print.css" rel="stylesheet" type="text/css" media="print"/>        
<!--[if lt IE 10]><link rel="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['ruta_css'];?>
blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->                
         <link rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['ruta_css'];?>
menu/flickr/helper.css" />
         <link rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['ruta_css'];?>
menu/dropdown.css" />    
         <link rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['ruta_css'];?>
menu/flickr/default.ultimate.css" />         
         <link rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['ruta_css'];?>
style.css" />
         <link rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['ruta_css'];?>
style.css" />         
         <link rel="stylesheet" href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['ruta_css'];?>
estilos.css"/>

        
        
        <script src="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
public/js/jquery/jquery-1.6.2.min.js" type="text/javascript"></script>
        <script src="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
public/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
        <script src="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
public/js/jquery-ui/jquery-ui-i18n.js" type="text/javascript"></script>        

    
        <?php if (isset($_smarty_tpl->tpl_vars['_layoutParams']->value['js'])&&count($_smarty_tpl->tpl_vars['_layoutParams']->value['js'])){?>
        <?php  $_smarty_tpl->tpl_vars['js'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['js']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['_layoutParams']->value['js']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['js']->key => $_smarty_tpl->tpl_vars['js']->value){
$_smarty_tpl->tpl_vars['js']->_loop = true;
?>
        
        <script src="<?php echo $_smarty_tpl->tpl_vars['js']->value;?>
" type="text/javascript"></script>
        
        <?php } ?>
        <?php }?>
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
                        <img src="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
/public/img/cabecera1.png" alt="Cargando..." />
                        <!-- h1><?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['configs']['app_name'];?>
</h1 -->
                    </div>
                    

                    <div id="menuh">
                            <ul id="nav" class="dropdown dropdown-horizontal">
                            <?php if (isset($_smarty_tpl->tpl_vars['_layoutParams']->value['menu'])){?>
                            <?php  $_smarty_tpl->tpl_vars['it'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['it']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['_layoutParams']->value['menu']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['it']->key => $_smarty_tpl->tpl_vars['it']->value){
$_smarty_tpl->tpl_vars['it']->_loop = true;
?>
                            
                            <?php if (isset($_smarty_tpl->tpl_vars['_layoutParams']->value['item'])&&$_smarty_tpl->tpl_vars['_layoutParams']->value['item']==$_smarty_tpl->tpl_vars['it']->value['id']){?>                                
                                <?php $_smarty_tpl->tpl_vars["_item_style"] = new Smarty_variable('current', null, 0);?>
                                
                            <?php }else{ ?>
                            
                                <?php $_smarty_tpl->tpl_vars["_item_style"] = new Smarty_variable('', null, 0);?>
                                
                            <?php }?>
                            
                            <li><a  class="<?php echo $_smarty_tpl->tpl_vars['_item_style']->value;?>
" href="<?php echo $_smarty_tpl->tpl_vars['it']->value['enlace'];?>
" title="Referencia"><?php echo $_smarty_tpl->tpl_vars['it']->value['titulo'];?>
</a></li>

                            <?php } ?>
                            <?php }?>
                            </ul>
                    </div>
                </div> <!-- div final del header -->
                <div class="clear"></div>
                
                <div class="span-20 prepend-2">
                    <noscript><p>Para el correcto funcionamiento debe tener el soporte de javascript habilitado</p></noscript>
                    
                    <?php if (isset($_smarty_tpl->tpl_vars['_error']->value)){?>
                    <div id="error"><?php echo $_smarty_tpl->tpl_vars['_error']->value;?>
</div>
                    <?php }?>

                    <?php if (isset($_smarty_tpl->tpl_vars['_mensaje']->value)){?>
                    <div id="mensaje"><?php echo $_smarty_tpl->tpl_vars['_mensaje']->value;?>
</div>
                    <?php }?>

                    <?php echo $_smarty_tpl->getSubTemplate ($_smarty_tpl->tpl_vars['_contenido']->value, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

                    
                </div>
                <div class="clear"></div>    
                <div style="padding-top:5px;height:25px;background:url(<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
/public/img/footer1.png) no-repeat"  class="span-24 prepend-top">
                    <p style="text-align:center">
                     &copy; Copyright 2011 &lt;INAP&gt; | Design by: Marca Registrada
                    </p>
                </div><!-- end footer -->
                <div class="clear"></div>

           </div>
       </body>
</html><?php }} ?>