<?php /* Smarty version Smarty-3.1.8, created on 2012-11-01 19:32:49
         compiled from "C:\xampp\htdocs\poomvc19\views\error\access.tpl" */ ?>
<?php /*%%SmartyHeaderCode:14215092c051d6b994-03447460%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '0dc2722a1066c2a62da129a12a3dbb83dce45518' => 
    array (
      0 => 'C:\\xampp\\htdocs\\poomvc19\\views\\error\\access.tpl',
      1 => 1335204734,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '14215092c051d6b994-03447460',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'mensaje' => 0,
    '_layoutParams' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_5092c051e73983_38329895',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5092c051e73983_38329895')) {function content_5092c051e73983_38329895($_smarty_tpl) {?><h2><?php if (isset($_smarty_tpl->tpl_vars['mensaje']->value)){?> <?php echo $_smarty_tpl->tpl_vars['mensaje']->value;?>
<?php }?></h2>

<p>&nbsp;</p>

<a href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
">Ir al Inicio</a> | 
<a href="javascript:history.back(1)">Volver a la p&aacute;gina anterior</a>

<?php if ((!Session::get('autenticado'))){?>

| <a href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
login">Iniciar Sesi&oacute;n</a>

<?php }?><?php }} ?>