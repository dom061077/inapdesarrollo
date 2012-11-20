<?php /* Smarty version Smarty-3.1.8, created on 2012-06-13 18:15:15
         compiled from "/var/www/mvc/views/acl/permisos_role.tpl" */ ?>
<?php /*%%SmartyHeaderCode:16601678264fd910f3213214-30842837%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'db5a87f896a155875ee7c675d61ac0a7e2b7e236' => 
    array (
      0 => '/var/www/mvc/views/acl/permisos_role.tpl',
      1 => 1338653146,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '16601678264fd910f3213214-30842837',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'role' => 0,
    'permisos' => 0,
    'pr' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_4fd910f3608533_23596633',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_4fd910f3608533_23596633')) {function content_4fd910f3608533_23596633($_smarty_tpl) {?><h2>Administracion de permisos de role</h2>

<h3>Role: <?php echo $_smarty_tpl->tpl_vars['role']->value['role'];?>
</h3>

<p>Permisos</p>

<form name="form1" method="post" action="">
    <input type="hidden" name="guardar" value="1" />
    
    <?php if (isset($_smarty_tpl->tpl_vars['permisos']->value)&&count($_smarty_tpl->tpl_vars['permisos']->value)){?>
        <table>
            <tr>
                <th>Permiso</th>
                <th>Habilitado</th>
                <th>Denegado</th>
                <th>Ignorar</th>
            </tr>
            <?php  $_smarty_tpl->tpl_vars['pr'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['pr']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['permisos']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['pr']->key => $_smarty_tpl->tpl_vars['pr']->value){
$_smarty_tpl->tpl_vars['pr']->_loop = true;
?>
                <tr>
                    <td><?php echo $_smarty_tpl->tpl_vars['pr']->value['nombre'];?>
</td>
                    <td>
                        <input type="radio" name="perm_<?php echo $_smarty_tpl->tpl_vars['pr']->value['id'];?>
" value="1" <?php if (($_smarty_tpl->tpl_vars['pr']->value['valor']==1)){?>checked="checked"<?php }?>/></td>
                        <td><input type="radio" name="perm_<?php echo $_smarty_tpl->tpl_vars['pr']->value['id'];?>
" value="" <?php if (($_smarty_tpl->tpl_vars['pr']->value['valor']=='')){?>checked="checked"<?php }?>/></td>
                        <td><input type="radio" name="perm_<?php echo $_smarty_tpl->tpl_vars['pr']->value['id'];?>
" value="x" <?php if (($_smarty_tpl->tpl_vars['pr']->value['valor']==="x")){?>checked="checked"<?php }?>/>
                    </td>
                </tr>
            <?php } ?>
        </table>
    <?php }?>
    
    <p><input type="submit" value="Guardar" /></p>
</form> <?php }} ?>