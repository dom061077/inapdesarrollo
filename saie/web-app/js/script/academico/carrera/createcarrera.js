
			function initGridBusquedaRequisitos(){
				//---------------inicializacion de la grilla de busqueda del requisito para sugerir los requisitos
				$('#tablaBusquedaRequisitoId').jqGrid({
					caption:'Búsqueda de Requisito',
					url:locrequisito,
				mtype:'POST',
				width:400,
				rownumbers:true,
				pager:'pagerBusquedaRequisitoId',
				datatype:'json',
				colNames:['Id','Descripción','Clase'],
				colModel:[
						{name:'id',index:'id',width:10,hidden:true},
						{name:'descripcion',index:'descripcion',width:100,sorttype:'text',sortable:true},
						{name:'claseRequisito_descripcion',index:'claseRequisito_descripcion',width:100,sorttype:'text',sortable:true}
				],
				ondblClickRow: function(id){
						var obj=$('#tablaBusquedaRequisitoId').getRowData(id);
						$('#idid').val(obj.id)
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
				
				//-----------------------------------------------------------------------------------------
				
			}

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
	        	    griddata[i]["anioLectivo"] = data[i].anioLectivo;	        	    	        	    
	        	    griddata[i]["cupo"] = data[i].cupo;
	        	    griddata[i]["cupoSuplentes"] = data[i].cupoSuplentes;
	        	    griddata[i]["costoMatricula"] = data[i].costoMatricula;
	        	    griddata[i]["fechaInicio"] = data[i].fechaInicio;
	        	    griddata[i]["fechaFin"] = data[i].fechaFin;
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
	        	    griddata[i]["esprimernivel"] = data[i].esprimernivel;
	        	    griddata[i]["esprimernivelvalue"] = data[i].esprimernivelvalue;
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
		,colNames:['Id','Id','Descripción','Clase Requisito']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'idid',index:'idid', width:30,hidden:true, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
			, {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
			, {name:'claseRequisito_descripcion',index:'claseRequisito_descripcion', width:100,editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
		]
		//, rowNum:10, rowList:[10,20,30]
		, pager: '#pagerListRequisitosId'
		, sortname: 'id'
		, viewrecords: true, sortorder: "desc"
		, caption:"Requisitos",  
		height:130
	}); 
	
	jQuery("#listRequisitosId").jqGrid('navGrid','#pagerListRequisitosId', {add:true,edit:false,del:true,search:false,refresh:false}, //options 
			{height:280,width:310,reloadAfterSubmit:false
				, recreateForm:true
				,modal:false
				,editCaption:'Modificar Requisitos'
				, beforeShowForm:function(form){
					//$('#TblGrid_prescripcionesId').before('<a style="width:50px" id="searchlinkformgridId" href="#"><span  class="ui-icon ui-icon-search"></span>Vademecum</a>');
					/*listRequisitosId
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
					});*/
				}
				,bSubmit:'Modificar'
			
			}, // edit options 
			{height:320,width:400,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Requisito'
				/*,onclickSubmit: function(eparams){
						var obj=$('#tablaBusquedaRequisitoId').jqGrid('getGridParam','selrow');
						if(obj){
							return {descripcion:obj.descripcion};
						}else{
							return{}
						}
				}*/
				,beforeSubmit: function(postData,formId){
					var id = $('#tablaBusquedaRequisitoId').jqGrid('getGridParam','selrow');
					var retornar = false;
					var obj;
					if(!id){
						alert('Seleccione un requisito de la Grilla');
						return [false,''];
					}else{
						obj = $('#tablaBusquedaRequisitoId').getRowData(id);
						var gridDataRequisitos = $('#listRequisitosId').getRowData();
						$.each( gridDataRequisitos, function(i, row){
	   						 if(obj.id==row.idid){
	   						 	retornar=true;
	   						 	return;
	   						 }
						});
						if(retornar){
							alert('Ya agregó este Requisito');
							return [false,'YA EXISTE EL REQUISITO AGREGADO'];
						}
						
						
						postData.idid = obj.id;
						postData.descripcion = obj.descripcion;
						postData.claseRequisito_descripcion = obj.claseRequisito_descripcion;
						return [true,''];
					}
				}
				,beforeShowForm:function(form){
					/*$('#tr_codigo').append('<td><a  id="searchlinkformgridId" href="#"><span style="float:left;"  class="ui-icon ui-icon-search"></span></a></td>');
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
					});*/
					$('#TblGrid_listRequisitosId').hide();
					//$('#busquedaRequisitoId').show();
					$('#FrmGrid_listRequisitosId').append('<table id="tablaBusquedaRequisitoId"></table><div id="pagerBusquedaRequisitoId"></div>');
					initGridBusquedaRequisitos();
					
				}
				,bSubmit:'Agregar'
			
			}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		);	
		
	jQuery("#listNivelesId").jqGrid({ 
		url:'listniveles'
		,editurl:'editniveles'
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','Descripción de Nivel','Es primer nivel value','Nivel Introductorio?']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{readOnly:false,size:30},editrules:{required:true}, sortable:false}
			, {name:'esprimernivelvalue',index:'esprimernivelvalue',hidden:true}
			, {name:'esprimernivel',index:'esprimernivel', width:100, align:"left",editable:true
					,editoptions:{readOnly:false,size:30,value:'false:No es Nivel Introductorio;true:Es Nivel Introductorio'}
					,edittype:'select'
					,editrules:{required:true}, sortable:false}
		]
		//, rowNum:10, rowList:[10,20,30]
		, pager: '#pagerListNivelesId'
		, sortname: 'id'
		, viewrecords: true, sortorder: "desc"
		, caption:"Niveles"  
		, height:130
	}); 
	
	jQuery("#listNivelesId").jqGrid('navGrid','#pagerListNivelesId', {add:true,edit:true,del:true,search:false,refresh:false}, //options 
			{height:180,width:310,reloadAfterSubmit:false
				, recreateForm:true
				,modal:false
				,editCaption:'Modificar Niveles'
				,beforeSubmit: function(postData,formId){
					postData.esprimernivelvalue = $('#esprimernivel').val();
					return [true,'']
				}				
				,bSubmit:'Modificar'
			}, // edit options 
			{height:180,width:310,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Nivel'
				,beforeSubmit: function(postData,formId){
					postData.esprimernivelvalue = $('#esprimernivel').val();
					return [true,'']
				}
				,bSumit:'Agregar'
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
		,colNames:['Id','IdId xxxx','Año Lectivo','Cupo','Cupo Suplentes','Costo Matricula','Fecha Inicio','Fecha Fin']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'idid',index:'idid', width:100, align:"left",hidden:true,editable:true,editoptions:{readOnly:false,size:30},editrules:{integer:true,required:false}, sortable:false}
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
			{height:200,width:310,reloadAfterSubmit:false
				, recreateForm:true
				,modal:false
				,editCaption:'Modificar Año Lectivo'
				,bSubmit:'Modificar'
			
			}, // edit options 
			{height:200,width:310,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,bSubmit:'Agregar'
				,addCaption:'Agregar Año Lectivo'
				,beforeSubmit: function(postData,formId){
					return [true,''];
				}
				,afterSubmit: function(postData,formId){
					return[true,''];
				}
				,bSubmit:'Agregar'
			
			}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		);	
	
	bindanios();
	bindrequisitos();
	
	
	$('#tabs').tabs();
});