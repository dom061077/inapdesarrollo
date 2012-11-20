<?php /* Smarty version Smarty-3.1.8, created on 2012-11-06 20:12:59
         compiled from "C:\xampp\htdocs\poomvc19\modules\usuarios\views\login\index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:166905099613b233ab8-24351963%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4013dc8f590df45138948752e0718612057bcd55' => 
    array (
      0 => 'C:\\xampp\\htdocs\\poomvc19\\modules\\usuarios\\views\\login\\index.tpl',
      1 => 1350429322,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '166905099613b233ab8-24351963',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'datos' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_5099613b381321_82037618',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5099613b381321_82037618')) {function content_5099613b381321_82037618($_smarty_tpl) {?><h2>Iniciar Sesi&oacute;n</h2>

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