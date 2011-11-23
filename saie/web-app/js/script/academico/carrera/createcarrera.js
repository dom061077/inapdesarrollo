
	        function initsubmit(){
	    		var gridDataRequisitos = jQuery("#listRequisitosId").getRowData();
	        	var postDataRequisitos = JSON.stringify(gridDataRequisitos);
	        	$("#requisitosSerializedId").val(postDataRequisitos);
	        	
	    		var gridDataNiveles = jQuery("#listNivelesId").getRowData();
	        	var postDataNiveles = JSON.stringify(gridDataNiveles);
	        	$("#nivelesSerializedId").val(postDataNiveles);
	        	
	    		var gridDataAnios = jQuery("#listAniosId").getRowData();
	        	var postDataAnios = JSON.stringify(gridDataAnios);
	        	$("#aniosSerializedId").val(postDataAnios);
	        	
	        	
	        }
	        
	        function bindanios(){
	        	var griddata = [];
	        	
	        	var data = jQuery.parseJSON($("#aniosSerializedId").val());
	        	if(data==null)
		        		data=[];
	        	for (var i = 0; i < data.length; i++) {
	        	    griddata[i] = {};
	        	    griddata[i]["id"] = data[i].id 
	        	    griddata[i]["anio"] = data[i].descripcion;	        	    	        	    
	        	}

	        	for (var i = 0; i <= griddata.length; i++) {
	        	    jQuery("#listAniosId").jqGrid('addRowData', i + 1, griddata[i]);
	        	}
	        }
	        
	        
	        function bindniveles(){
	        	var griddata = [];
	        	
	        	var data = jQuery.parseJSON($("#nivelesSerializedId").val());
	        	if(data==null)
		        		data=[];
	        	for (var i = 0; i < data.length; i++) {
	        	    griddata[i] = {};
	        	    griddata[i]["id"] = data[i].id 
	        	    griddata[i]["descripcion"] = data[i].descripcion;	        	    	        	    
	        	}

	        	for (var i = 0; i <= griddata.length; i++) {
	        	    jQuery("#listNivelesId").jqGrid('addRowData', i + 1, griddata[i]);
	        	}
	        }

	        function bindrequisitos(){
	        	var griddata = [];
	        	
	        	var data = jQuery.parseJSON($("#requisitosSerializedId").val());
	        	if(data==null)
		        		data=[];
	        	for (var i = 0; i < data.length; i++) {
	        	    griddata[i] = {};
	        	    /*for (var j = 0; j < data[i].length; j++) {
	        	        griddata[i][names[j]] = data[i][j];
	        	    }*/
	        	    griddata[i]["id"] = data[i].id;
	        	    griddata[i]["idid"] = data[i].idid;	        	    
	        	    griddata[i]["codigo"] = data[i].codigo;
	        	    griddata[i]["descripcion"] = data[i].descripcion;	        	    	        	    
	        	}

	        	for (var i = 0; i <= griddata.length; i++) {
	        	    jQuery("#listRequisitosId").jqGrid('addRowData', i + 1, griddata[i]);
	        	}
	        }


$(document).ready(function(){
	jQuery("#listRequisitosId").jqGrid({ 
		url:'listrequisitos'
		,editurl:'editrequisitos'
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','Id', 'Código','Descripción','Clase Requisito']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'idid',index:'idid', width:30,hidden:true, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
			, {name:'codigo',index:'codigo', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:true}, sortable:false}
			, {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:true}, sortable:false}
			, {name:'claseRequisito_descripcion',index:'claseRequisito_descripcion', width:100,editable:true,editoptions:{readOnly:true,size:30},editrules:{required:true}, sortable:false}
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
			{name:'claseRequisito_descripcion',index:'claseRequisito_descripcion',width:100,sorttype:'text',sortable:true}
	],
	ondblClickRow: function(id){
			var obj=$('#tablaBusquedaRequisitoId').getRowData(id);
			$('#idid').val(obj.id)
			$('#codigo').val(obj.codigo);
			$('#descripcion').val(obj.descripcion);
			$('#claseRequisito_descripcion').val(obj.claseRequisito_descripcion)
			$('#busquedaRequisitoDialogId').dialog("close");
		} 
	});
	jQuery("#tablaBusquedaRequisitoId").jqGrid('navGrid','#pagerBusquedaRequisitoId',{search:false,edit:false,add:false,del:false,pdf:true});
	jQuery('#tablaBusquedaRequisitoId').jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});
	jQuery("#tablaBusquedaRequisitoId").jqGrid('navButtonAdd','#pagerBusquedaRequisitoId',{
	       caption:"Informe", 
	       onClickButton : function () {
	    	   var id = jQuery('#tablaBusquedaRequisitoId').jqGrid('getGridParam','selrow');
	    	   if(id)
	    		   window.location = locvademecdetalle+'?target=_blank&id='+id;
	    	   else
	    		   $('<div>Seleccione una fila para activar esta opción</div>').dialog({title:'Mensaje',modal: true});
	    	   
	       } 
	});	
	bindrequisitos();
	
	//-----------------------------------------------------------------------------------------
	jQuery("#listNivelesId").jqGrid({ 
		url:'listniveles'
		,editurl:'editniveles'
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','Descripción de Nivel']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{readOnly:false,size:30},editrules:{required:true}, sortable:false}
		]
		//, rowNum:10, rowList:[10,20,30]
		, pager: '#pagerListNivelesId'
		, sortname: 'id'
		, viewrecords: true, sortorder: "desc"
		, caption:"Niveles",  
		height:130
	}); 
	
	jQuery("#listNivelesId").jqGrid('navGrid','#pagerListNivelesId', {add:true,edit:true,del:true,search:false,refresh:false}, //options 
			{height:280,width:310,reloadAfterSubmit:false
				, recreateForm:true
				,modal:false
				,editCaption:'Modificar Niveles'
			
			}, // edit options 
			{height:280,width:310,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Nivel'
				,beforeSubmit: function(postData,formId){
					return [true,'']
				}
			
			}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		);	
	
	bindniveles();
	
	//-----------------------------------------------------------------------------------------
	jQuery("#listAniosId").jqGrid({ 
		url:'listanios'
		,editurl:'editanios'
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','Año Lectivo','Cupo','Cupo Suplentes','Costo Matricula','Fecha Inicio','Fecha Fin']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'anioLectivo',index:'anioLectivo', width:100, align:"left",editable:true,editoptions:{readOnly:false,size:30},editrules:{minValue:2012,integer:true,required:true}, sortable:false}
			, {name:'cupo',index:'cupo', width:100, align:"left",editable:true,editoptions:{readOnly:false,size:30},editrules:{integer:true,required:true}, sortable:false}
			, {name:'cupoSuplentes',index:'cupoSuplentes', width:100, align:"left",editable:true,editoptions:{readOnly:false,size:30},editrules:{integer:true,required:true}, sortable:false}
			, {name:'costoMatricula',index:'costoMatricula', width:100, align:"left",editable:true,editoptions:{readOnly:false,size:30},editrules:{number:true,required:true}, sortable:false}
			, {name:'fechaInicio',index:'fechaInicio', width:100, align:"left",editable:true,editoptions:{readOnly:false,size:30},datefmt:'dd/MM/yyyy',editrules:{date:true,required:true}, sortable:false}
			, {name:'fechaFin',index:'fechaFin', width:100, align:"left",editable:true,editoptions:{readOnly:false,size:30},datefmt:'dd/MM/yyyy',editrules:{date:true,required:true}, sortable:false}			
		]
		//, rowNum:10, rowList:[10,20,30]
		, pager: '#pagerListAniosId'
		, sortname: 'id'
		, viewrecords: true, sortorder: "desc"
		, caption:"Años Lectivos",  
		height:130
	}); 
	
	jQuery("#listAniosId").jqGrid('navGrid','#pagerListAniosId', {add:true,edit:true,del:true,search:false,refresh:false}, //options 
			{height:280,width:310,reloadAfterSubmit:false
				, recreateForm:true
				,modal:false
				,editCaption:'Modificar Año Lectivo'
				,bSubmit:'Agregar'
			
			}, // edit options 
			{height:280,width:310,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,bSubmit:'Agregar'
				,addCaption:'Agregar Año Lectivo'
				,beforeSubmit: function(postData,formId){
					return [true,'']
				}
			
			}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		);	
	
	bindanios();
	
	
	$('#tabs').tabs();
});