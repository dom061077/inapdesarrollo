<?php /* Smarty version Smarty-3.1.8, created on 2012-10-16 20:20:47
         compiled from "/var/www/mvc/modules/usuarios/views/login/index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1378278910507df9df0e25e9-27744433%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '26f6b26c44b91250b7a5bb42287fc2f0b879f41e' => 
    array (
      0 => '/var/www/mvc/modules/usuarios/views/login/index.tpl',
      1 => 1350432923,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1378278910507df9df0e25e9-27744433',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'datos' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_507df9df3ea178_74879637',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_507df9df3ea178_74879637')) {function content_507df9df3ea178_74879637($_smarty_tpl) {?><h2>Iniciar Sesi&oacute;n</h2>

<form name="form1" method="post" action="">
    <input type="hidden" value="1" name="enviar" />
    
    <p>
        <label>Usuario: </labe>
        <input type="text" name="usuario" value="<?php echo (($tmp = @$_smarty_tpl->tpl_vars['datos']->value['usuario'])===null||$tmp==='' ? '' : $tmp);?>
" />
    </p>
    
    <p>
        <label>Password: </labe>
        <input type="password" name="pass" />
    </p>
    
    <p>
        <input type="submit" value="enviar" />
    </p>
</form><?php }} ?>