<?php /* Smarty version Smarty-3.1.8, created on 2012-06-02 17:45:04
         compiled from "/var/www/mvc/views/acl/roles.tpl" */ ?>
<?php /*%%SmartyHeaderCode:12076463234fca896090e834-72508803%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'd5a08adafea4c3f60f2d9aa2a007cad0bca46704' => 
    array (
      0 => '/var/www/mvc/views/acl/roles.tpl',
      1 => 1338672774,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '12076463234fca896090e834-72508803',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'roles' => 0,
    'rl' => 0,
    '_layoutParams' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_4fca8960d13f87_12857467',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_4fca8960d13f87_12857467')) {function content_4fca8960d13f87_12857467($_smarty_tpl) {?><h2>Administracion de roles</h2>

<?php if (isset($_smarty_tpl->tpl_vars['roles']->value)&&count($_smarty_tpl->tpl_vars['roles']->value)){?>
    <table>
        <tr>
            <th>ID</th>
            <th>Role</th>
            <th></th>
            <th></th>
        </tr>
        <?php  $_smarty_tpl->tpl_vars['rl'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['rl']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['roles']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['rl']->key => $_smarty_tpl->tpl_vars['rl']->value){
$_smarty_tpl->tpl_vars['rl']->_loop = true;
?>
            <tr>
                <td><?php echo $_smarty_tpl->tpl_vars['rl']->value['id_role'];?>
</td>
                <td><?php echo $_smarty_tpl->tpl_vars['rl']->value['role'];?>
</td>
                <td>
                    <a href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
acl/permisos_role/<?php echo $_smarty_tpl->tpl_vars['rl']->value['id_role'];?>
">Permisos</a>
                </td>
                <td>Editar</td>
            </tr>
        <?php } ?>
    </table>
<?php }?>

<p><a href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
acl/nuevo_role">Agregar Role</a></p><?php }} ?>