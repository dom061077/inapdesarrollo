<?php /* Smarty version Smarty-3.1.8, created on 2012-11-06 20:13:28
         compiled from "C:\xampp\htdocs\poomvc19\modules\usuarios\views\registro\index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:18215509961584e27a7-63414577%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '63e0a2cbe1c4914222f921db955f8b99d40bac34' => 
    array (
      0 => 'C:\\xampp\\htdocs\\poomvc19\\modules\\usuarios\\views\\registro\\index.tpl',
      1 => 1350429330,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '18215509961584e27a7-63414577',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'datos' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_509961585cbe87_71856139',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_509961585cbe87_71856139')) {function content_509961585cbe87_71856139($_smarty_tpl) {?><h2>Registro</h2>

<form name="form1" method="post" action="">
    <input type="hidden" value="1" name="enviar" />
    
    <p>
        <label>Nombre: </label>
        <input type="text" name="nombre" value="<?php echo (($tmp = @$_smarty_tpl->tpl_vars['datos']->value['nombre'])===null||$tmp==='' ? '' : $tmp);?>
" />
    </p>
    
    <p>
        <label>Usuario: </label>
        <input type="text" name="usuario" value="<?php echo (($tmp = @$_smarty_tpl->tpl_vars['datos']->value['usuario'])===null||$tmp==='' ? '' : $tmp);?>
" />
    </p>
    
    <p>
        <label>Email: </label>
        <input type="text" name="email" value="<?php echo (($tmp = @$_smarty_tpl->tpl_vars['datos']->value['email'])===null||$tmp==='' ? '' : $tmp);?>
" />
    </p>
    
    <p>
        <label>Password: </label>
        <input type="password" name="pass" />
    </p>
    
    <p>
        <label>Confirmar: </label>
        <input type="password" name="confirmar" />
    </p>    
        
    <p>
        <input type="submit" value="enviar" />
    </p>
</form><?php }} ?>