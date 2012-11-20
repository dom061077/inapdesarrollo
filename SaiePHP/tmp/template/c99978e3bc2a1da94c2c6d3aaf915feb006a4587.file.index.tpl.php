<?php /* Smarty version Smarty-3.1.8, created on 2012-10-31 22:28:03
         compiled from "C:\xampp\htdocs\poomvc19\views\post\index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:9133509197e36de356-65685565%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c99978e3bc2a1da94c2c6d3aaf915feb006a4587' => 
    array (
      0 => 'C:\\xampp\\htdocs\\poomvc19\\views\\post\\index.tpl',
      1 => 1338244830,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '9133509197e36de356-65685565',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'posts' => 0,
    'datos' => 0,
    '_layoutParams' => 0,
    'paginacion' => 0,
    '_acl' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_509197e3978082_49001791',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_509197e3978082_49001791')) {function content_509197e3978082_49001791($_smarty_tpl) {?><h2>Ultimos Posts</h2>

<?php if (isset($_smarty_tpl->tpl_vars['posts']->value)&&count($_smarty_tpl->tpl_vars['posts']->value)){?>

<table>
    
    <?php  $_smarty_tpl->tpl_vars['datos'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['datos']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['posts']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['datos']->key => $_smarty_tpl->tpl_vars['datos']->value){
$_smarty_tpl->tpl_vars['datos']->_loop = true;
?>
    
    <tr>
        <td><?php echo $_smarty_tpl->tpl_vars['datos']->value['id'];?>
</td>
        <td><?php echo $_smarty_tpl->tpl_vars['datos']->value['titulo'];?>
</td>
        <td><?php echo $_smarty_tpl->tpl_vars['datos']->value['cuerpo'];?>
</td>
        <td>
            <?php if (isset($_smarty_tpl->tpl_vars['datos']->value['imagen'])){?>
            
                <a href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
public/img/post/<?php echo $_smarty_tpl->tpl_vars['datos']->value['imagen'];?>
">
                    <img src="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
public/img/post/thumb/thumb_<?php echo $_smarty_tpl->tpl_vars['datos']->value['imagen'];?>
" />
                </a>
            
            <?php }?>
        </td>
        <td><a href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
post/editar/<?php echo $_smarty_tpl->tpl_vars['datos']->value['id'];?>
">Editar</a></td>
        <td><a href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
post/eliminar/<?php echo $_smarty_tpl->tpl_vars['datos']->value['id'];?>
">Eliminar</a></td>
    </tr>
    
    <?php } ?>
</table>

<?php }else{ ?>

<p><strong>No hay posts!</strong></p>

<?php }?>

<?php echo (($tmp = @$_smarty_tpl->tpl_vars['paginacion']->value)===null||$tmp==='' ? '' : $tmp);?>


<?php if ($_smarty_tpl->tpl_vars['_acl']->value->permiso('nuevo_post')){?>
<p><a href="<?php echo $_smarty_tpl->tpl_vars['_layoutParams']->value['root'];?>
post/nuevo">Agregar Post</a></p>
<?php }?><?php }} ?>