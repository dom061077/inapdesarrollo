
$(document).ready(function(){
	jQuery("#listRequisitosId").jqGrid({ 
		url:'listrequisitos'
		,editurl:'editrequisitos'
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id', 'Código','Descripción','Clase Requisito']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'codigo',index:'codigo', width:100, align:"right",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
			, {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
			, {name:'claseRequisito_descripcion',index:'claseRequisito_descripcion', width:100,editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
		]
		//, rowNum:10, rowList:[10,20,30]
		, pager: '#pagerListRequisitosId'
		, sortname: 'id'
		, viewrecords: true, sortorder: "desc"
		, caption:"Requisitos",  
		height:130
	}); 
	
	jQuery("#listRequisitosId").jqGrid('navGrid','#pagerListRequisitosId', {add:true,edit:true,del:true,search:false,refresh:false}, //options 
			{height:280,width:310,reloadAfterSubmit:false
				, recreateForm:true
				,modal:false
				,editCaption:'Modificar Requisitos'
				, beforeShowForm:function(form){
					//$('#TblGrid_prescripcionesId').before('<a style="width:50px" id="searchlinkformgridId" href="#"><span  class="ui-icon ui-icon-search"></span>Vademecum</a>');
					$('#tr_codigo').append('<td><a  id="searchlinkformgridId" href="#"><span style="float:left;"  class="ui-icon ui-icon-search"></span></a></td>');
					$('#searchlinkformgridId').bind('click',function(){
		            	$('#busquedaRequisitoDialogId').dialog({
		            		title:'Buscar',
		            		modal:true,
		            		resizable:false,
		            		autoOpen:true,
		            		width : 600,
		            		height: 'auto',
		            		minHeight:350,
		            		position:'center'
		            	});
					});
				}
			
			}, // edit options 
			{height:280,width:310,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Requisito'
				,beforeSubmit: function(postData,formId){
					return [true,'']
				}
				,beforeShowForm:function(form){
					$('#tr_codigo').append('<td><a  id="searchlinkformgridId" href="#"><span style="float:left;"  class="ui-icon ui-icon-search"></span></a></td>');
					$('#searchlinkformgridId').bind('click',function(){
		            	$('#busquedaRequisitoDialogId').dialog({
		            		title:'Buscar',
		            		modal:true,
		            		resizable:false,
		            		autoOpen:true,
		            		width : 600,
		            		height: 'auto',
		            		minHeight:350,
		            		position:'center'
		            	});
					});
				}
			
			}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		);	
		
	//---------------inicializacion de la grilla de busqueda del requisito para sugerir los requisitos
	$('#tablaBusquedaRequisitoId').jqGrid({
		caption:'Búsqueda de Requisito',
		width:380,
		url:locrequisito,
	mtype:'POST',
	width:550,
	rownumbers:true,
	pager:'pagerBusquedaRequisitoId',
	datatype:'json',
	colNames:['Id','Código','Descripción','Clase'],
	colModel:[
			{name:'id',index:'id',width:10,hidden:true},
			{name:'codigo',index:'codigo',width:100,sorttype:'text',sortable:true},
			{name:'descripcion',index:'descripcion',width:100,sorttype:'text',sortable:true},
			{name:'claseRequisito.descripcion',index:'claseRequisito.descripcion',width:100,sorttype:'text',sortable:true}
	],
	ondblClickRow: function(id){
			var obj=$('#tablaBusquedaVademecumId').getRowData(id);
			$('#codigo').val(obj.nombreComercial);
			$('#descripcion').val(obj.principio_principioActivo);
			$('#claseRequisito_descripcion').val(obj.presentacion)
			$('#busquedaVademecumDialogId').dialog("close");
		} 
	});
	jQuery("#tablaBusquedaVademecumId").jqGrid('navGrid','#pagerBusquedaVademecumId',{search:false,edit:false,add:false,del:false,pdf:true});
	jQuery('#tablaBusquedaVademecumId').jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});
	jQuery("#tablaBusquedaVademecumId").jqGrid('navButtonAdd','#pagerBusquedaVademecumId',{
	       caption:"Informe", 
	       onClickButton : function () {
	    	   var id = jQuery('#tablaBusquedaVademecumId').jqGrid('getGridParam','selrow');
	    	   if(id)
	    		   window.location = locvademecdetalle+'?target=_blank&id='+id;
	    	   else
	    		   $('<div>Seleccione una fila para activar esta opción</div>').dialog({title:'Mensaje',modal: true});
	    	   
	       } 
	});	
	
});