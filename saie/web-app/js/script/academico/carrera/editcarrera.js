			var arrayDeletedNiveles = [];
			var arrayDeletedAnios = [];
			
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
	        	//$('#submitButtonId').attr('disabled','true')
	        	$("#requisitosSerializedId").val(postDataRequisitos);
				
	        	var gridDataNiveles = jQuery("#listNivelesId").getRowData();
	        	var postDataNiveles = JSON.stringify(gridDataNiveles);
	        	$("#nivelesSerializedId").val(postDataNiveles);
	        	$("#nivelesDeletedSerializedId").val(JSON.stringify(arrayDeletedNiveles));

	        	var gridDataAnios = jQuery("#listAniosId").getRowData();
	        	var postDataAnios = JSON.stringify(gridDataAnios);
	        	$("#aniosSerializedId").val(postDataAnios);
	        	$("#aniosDeletedSerializedId").val(JSON.stringify(arrayDeletedAnios));
	        	
	        	
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
	        	    griddata[i]["claseRequisito_descripcion"] = data[i].claseRequisito_descripcion;
	        	}

	        	for (var i = 0; i <= griddata.length; i++) {
	        	    jQuery("#listRequisitosId").jqGrid('addRowData', i + 1, griddata[i]);
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
	        	    griddata[i]["idNivel"] = data[i].id
	        	    griddata[i]["descripcion"] = data[i].descripcion;	     
	        	    griddata[i]["claseRequisito_descripcion"] = data[i].claseRequisito_descripcion;
	        	    griddata[i]["esprimernivel"] = data[i].esprimernivel;
	        	    griddata[i]["esprimernivelvalue"] = data[i].esprimernivelvalue;
	        	}

	        	for (var i = 0; i <= griddata.length; i++) {
	        	    jQuery("#listNivelesId").jqGrid('addRowData', i + 1, griddata[i]);
	        	}
	        }

	        function bindanios(){
	        	var griddata = [];
	        	
	        	var data = jQuery.parseJSON($("#aniosSerializedId").val());
	        	if(data==null)
		        		data=[];
	        	for (var i = 0; i < data.length; i++) {
	        	    griddata[i] = {};
	        	    griddata[i]["id"] = data[i].id
	        	    griddata[i]["idid"] = data[i].idid
	        	    griddata[i]["anioLectivo"] = data[i].anioLectivo;	        	    	        	    
	        	    griddata[i]["cupo"] = data[i].cupo;	        	    
	        	    griddata[i]["cupoSuplentes"] = data[i].cupoSuplentes;
	        	    griddata[i]["costoMatricula"] = data[i].costoMatricula;	        	    
	        	    griddata[i]["fechaInicio"] = data[i].fechaInicio;
	        	    griddata[i]["fechaFin"] = data[i].fechaFin;
	        	    griddata[i]["carreraId"] = $('#idCarreraId').val();
	        	}

	        	for (var i = 0; i <= griddata.length; i++) {
	        	    jQuery("#listAniosId").jqGrid('addRowData', i + 1, griddata[i]);
	        	}
	        }
	        

$(document).ready(function(){
	jQuery("#listRequisitosId").jqGrid({ 
		url:'listrequisitos'
		,editurl:loceditrequisito
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','Id','Descripción','Clase Requisito']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'idid',index:'idid', width:30,hidden:true, align:"left",editable:true,editoptions:{size:30},editrules:{required:false}, sortable:false}			
			, {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{readonly:true,size:30},editrules:{required:false}, sortable:false}
			, {name:'claseRequisito_descripcion',index:'claseRequisito_descripcion', width:100,editable:true,editoptions:{readonly:true,size:30},editrules:{required:false}, sortable:false}
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
				}
				,bSubmit:'Modificar'
			}, // edit options 
			{height:300,width:450,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Requisito'
				,beforeSubmit: function(postData,formId){
					var id = $('#tablaBusquedaRequisitoId').jqGrid('getGridParam','selrow');
					var obj;
					if(!id){
						alert('Seleccione un requisito de la Grilla');
						return [false,''];
					}else{
						obj = $('#tablaBusquedaRequisitoId').getRowData(id);						
						postData.idid = obj.id;
						postData.descripcion = obj.descripcion;
						postData.claseRequisito_descripcion = obj.claseRequisito_descripcion;
						return [true,''];
					}
				}
				,beforeShowForm:function(form){
					$('#TblGrid_listRequisitosId').hide();
					$('#FrmGrid_listRequisitosId').append('<table id="tablaBusquedaRequisitoId"></table><div id="pagerBusquedaRequisitoId"></div>');
					initGridBusquedaRequisitos();
				}
				,bSubmit:'Agregar'
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
	colNames:['Id','Descripción','Estado','Clase'],
	colModel:[
			{name:'id',index:'id',width:10,hidden:true},
			{name:'descripcion',index:'descripcion',width:100,sorttype:'text',sortable:true},
			{name:'estado',index:'estado',width:50,sorttype:'text',sortable:true},			
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
	bindrequisitos();
	
	//-----------------------------------------------------------------------------------------
	jQuery("#listNivelesId").jqGrid({ 
		url:'listniveles'
		,editurl:loceditnivel
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','Id Nivel','Descripción de Nivel','Es primer nivel valor','Nivel Introductorio']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'idNivel',index:'idNivel', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10},editrules:{required:true}, sortable:false}
			, {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{readOnly:false,size:30},editrules:{required:true}, sortable:false}
			, {name:'esprimernivelvalue',index:'esprimernivelvalue',hidden:true}
			, {name:'esprimernivel',index:'esprimernivel', width:30, align:"left",editable:true
					,editoptions:{readOnly:false,size:30,value:'false:No es Nivel Introductorio;true:Es Nivel Introductorio'}
					,edittype:'select'
					,editrules:{required:true}, sortable:false}
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
				,beforeSubmit: function(postData,formId){
					postData.esprimernivelvalue = $('#esprimernivel').val();
					return [true,'']
				}
				,bSubmit:'Modificar'
			
			}, // edit options 
			{height:280,width:310,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Nivel'
				,beforeSubmit: function(postData,formId){
					postData.esprimernivelvalue = $('#esprimernivel').val();
					return [true,'']
				}
				,bSubmit:'Agregar'
			
			}, // add options 
			{reloadAfterSubmit:false
				,beforeSubmit:function(postData,formId){
					var row = $("#listNivelesId").getRowData(postData);
					arrayDeletedNiveles.push({id:row.idNivel});
					return [true,'']
				}
			}, // del options agregar una validacion ajax para saber si se puede eliminar
			{} // search options 
		);	
	
	bindniveles();
	
	
	//-----------------------------------------------------------------------------------------
	jQuery("#listAniosId").jqGrid({ 
		url:'listanios'
		,editurl:loceditanio
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','IdId','CarreraId','Año Lectivo','Cupo','Cupo Suplentes','Costo Matrícula','Fecha Inicio','Fecha Fin']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			,{name:'idid',index:'idid', width:55,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'carreraId',index:'carreraId',editable:true,hidden:true,editrules:{integer:true,required:false}}
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
		, caption:"Niveles",  
		height:130
	}); 
	
	jQuery("#listAniosId").jqGrid('navGrid','#pagerListAniosId', {add:true,edit:true,del:true,search:false,refresh:false}, //options 
			{height:200,width:310,reloadAfterSubmit:false
				, recreateForm:true
				,modal:false
				,editCaption:'Modificar Años Lectivos'
				,bSubmit:'Modificar'
				,afterSubmit: function(response,postdata){
					var responseJson = $.parseJSON(response.responseText);
					if(responseJson.success=='true')
						return[true,''];
					else
						return[false,responseJson.message];

				}
			
			}, // edit options 
			{height:200,width:310,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Año Lectivo'
				,bSubmit:'Agregar'
				,afterSubmit: function(response,postdata){
					var responseJson = $.parseJSON(response.responseText);
					if(responseJson.success=='true')
						return[true,''];
					else
						return[false,responseJson.message];
				}
				,beforeSubmit: function(postData,formId){
					postData.carreraId=$('#idCarreraId').val();
					return[true,''];
				}
			
			}, // add options 
			{reloadAfterSubmit:false
				,afterSubmit: function(response,postdata){
					var responseJson = $.parseJSON(response.responseText);
					if(responseJson.success=='true')
						return[true,''];
					else
						return[false,responseJson.message];
				}
				,beforeSubmit:function(postData,formId){
					var row = $("#listAniosId").getRowData(postData);
					arrayDeletedAnios.push({id:row.idid});
					return [true,'']
				}
			}, // del options agregar una validacion ajax para saber si se puede eliminar
			{} // search options 
		);	
	
	bindanios();
	
	$('#tabs').tabs();
	
	
});