    function initsubmit(){
		var gridDataMatregcursar = jQuery("#matregcursarId").getRowData();
    	var postDataMatregcursar = JSON.stringify(gridDataMatregcursar);
    	$("#matregcursarSerializedId").val(postDataMatregcursar);
    	
    	//mataprobcursarSerializedId
		var gridDataMataprobcursar = jQuery("#mataprobcursarId").getRowData();
    	var postDataMataprobcursar = JSON.stringify(gridDataMataprobcursar);
    	$("#mataprobcursarSerializedId").val(postDataMataprobcursar);
    	
	   	//mataregrendirSerializedId
		var gridDataMatregrendir = jQuery("#matregrendirId").getRowData();
    	var postDataMatregrendir = JSON.stringify(gridDataMatregrendir);
    	$("#matregrendirSerializedId").val(postDataMatregrendir);
    	
	   	//mataaprobrendirSerializedId
		var gridDataMataprobrendir = jQuery("#mataprobrendirId").getRowData();
    	var postDataMataprobrendir = JSON.stringify(gridDataMataprobrendir);
    	$("#mataprobrendirSerializedId").val(postDataMataprobrendir);
    	
    }


$(document).ready(function(){
	$('#tabs').tabs();
	
	
	
    function bindmaterias(){
    	var griddata = [];
    	
    	var data = jQuery.parseJSON($("#matregcursarSerializedId").val());
    	if(data==null)
        		data=[];
    	for (var i = 0; i < data.length; i++) {
    	    griddata[i] = {};
    	    /*for (var j = 0; j < data[i].length; j++) {
    	        griddata[i][names[j]] = data[i][j];
    	    }*/
    	    griddata[i]["id"] = data[i].id;
    	    griddata[i]["idid"] = data[i].idid;	        	    
    	    griddata[i]["denominacion"] = data[i].denominacion;	        	    	        	    
    	    griddata[i]["nivel"] = data[i].nivel;
    	    griddata[i]["carrera"] = data[i].carrera;
    	}

    	for (var i = 0; i <= griddata.length; i++) {
    	    jQuery("#matregcursarId").jqGrid('addRowData', i + 1, griddata[i]);
    	}
    	
    	//mataprobcursarSerializedId
    	var data = jQuery.parseJSON($("#mataprobcursarSerializedId").val());
    	if(data==null)
        		data=[];
    	for (var i = 0; i < data.length; i++) {
    	    griddata[i] = {};
    	    /*for (var j = 0; j < data[i].length; j++) {
    	        griddata[i][names[j]] = data[i][j];
    	    }*/
    	    griddata[i]["id"] = data[i].id;
    	    griddata[i]["idid"] = data[i].idid;	        	    
    	    griddata[i]["denominacion"] = data[i].denominacion;	        	    	        	    
    	    griddata[i]["nivel"] = data[i].nivel;
    	    griddata[i]["carrera"] = data[i].carrera;
    	}

    	for (var i = 0; i <= griddata.length; i++) {
    	    jQuery("#mataprobcursarId").jqGrid('addRowData', i + 1, griddata[i]);
    	}
    	
    	//matregrendirSerializedId
    	var data = jQuery.parseJSON($("#matregrendirSerializedId").val());
    	if(data==null)
        		data=[];
    	for (var i = 0; i < data.length; i++) {
    	    griddata[i] = {};
    	    /*for (var j = 0; j < data[i].length; j++) {
    	        griddata[i][names[j]] = data[i][j];
    	    }*/
    	    griddata[i]["id"] = data[i].id;
    	    griddata[i]["idid"] = data[i].idid;	        	    
    	    griddata[i]["denominacion"] = data[i].denominacion;	        	    	        	    
    	    griddata[i]["nivel"] = data[i].nivel;
    	    griddata[i]["carrera"] = data[i].carrera;
    	}

    	for (var i = 0; i <= griddata.length; i++) {
    	    jQuery("#matregrendirId").jqGrid('addRowData', i + 1, griddata[i]);
    	}
    	
    	//mataprobrendirSerializedId
    	var data = jQuery.parseJSON($("#mataprobrendirSerializedId").val());
    	if(data==null)
        		data=[];
    	for (var i = 0; i < data.length; i++) {
    	    griddata[i] = {};
    	    griddata[i]["id"] = data[i].id;
    	    griddata[i]["idid"] = data[i].idid;	        	    
    	    griddata[i]["denominacion"] = data[i].denominacion;	        	    	        	    
    	    griddata[i]["nivel"] = data[i].nivel;
    	    griddata[i]["carrera"] = data[i].carrera;
    	}

    	for (var i = 0; i <= griddata.length; i++) {
    	    jQuery("#mataprobrendirId").jqGrid('addRowData', i + 1, griddata[i]);
    	}
    	
    	
    	
    }
	
	
	function initGridBusquedaMaterias(tabid,pagerid){
		//---------------inicializacion de la grilla de busqueda de Materias para sugerir las Materias
		var tablaId ='#'+tabid;
		var pagerId ='#'+pagerid; 
		$(tablaId).jqGrid({
			caption:'Búsqueda de Materias',
			url:locmateria,
		mtype:'POST',
		//postData:{nivel_id:$('#nivelIdId').val()},
		width:400,
		rownumbers:true,
		pager:pagerId,
		datatype:'json',
		colNames:['Id','Denominación','Nivel','Carrera'],
		colModel:[
				{name:'id',index:'id',width:10,hidden:true},
				{name:'denominacion',index:'denominacion',width:100,sorttype:'text',sortable:true},
				{name:'nivel_descripcion',index:'nivel_descripcion',width:100,sorttype:'text',sortable:true},
				{name:'nivel_carrera_denominacion',index:'nivel_carrera_denominacion',width:100,sorttype:'text',sortable:true}				
		]
		});
		jQuery(tablaId).jqGrid('navGrid',pagerId,{refresh:true,search:false,edit:false,add:false,del:false,pdf:true});
		jQuery(tablaId).jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});
		
		//var filter = { groupOp: "AND", rules: []};
		//filter.rules.push({field:"nivel_id",op:"eq",data:$('#nivelIdId').val()});
		var grid = $(tablaId) 
		grid[0].p._search = true;
		//$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
		
		//grid[0].refreshIndex();
		//grid.trigger("reloadGrid",[{page:1}]);
					
		
		//-----------------------------------------------------------------------------------------
		
	}
	

	jQuery("#matregcursarId").jqGrid({ 
		url:locmatregcursar
		,editurl:loceditmateria
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','Id','Denominación','Nivel','Carrera']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'idid',index:'idid', width:30,hidden:true, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
			, {name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
			, {name:'nivel',index:'nivel', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
			, {name:'carrera',index:'carrera', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
		]
		//, rowNum:10, rowList:[10,20,30]
		, pager: '#pagermatregcursarId'
		, sortname: 'id'
		, viewrecords: true, sortorder: "desc"
		, caption:"Materias Regulares para Cursar"  
		, height:130
	}); 
	
	jQuery("#matregcursarId").jqGrid('navGrid','#pagermatregcursarId', {add:true,edit:false,del:true,search:false,refresh:false}, //options 
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
			{height:450,width:450,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Materias Regulares para Cursar'
				/*,onclickSubmit: function(eparams){
						var obj=$('#tablaBusquedaRequisitoId').jqGrid('getGridParam','selrow');
						if(obj){
							return {descripcion:obj.descripcion};
						}else{
							return{}
						}
				}*/
				,beforeSubmit: function(postData,formId){

					var gridDataMatregcursar = jQuery("#matregcursarId").getRowData();
					var retornar=false;
					var id = $('#tablaBusquedaMateriaMatRegCursarId').jqGrid('getGridParam','selrow');
					var obj;
					if(!id){
						alert('Seleccione un Materia de la Grilla');
						return [false,''];
					}else{
						obj = $('#tablaBusquedaMateriaMatRegCursarId').getRowData(id);
						$.each( gridDataMatregcursar, function(i, row){
	   						 if(obj.id==row.idid){
	   						 	retornar=true;
	   						 	return;
	   						 }
						});
						if(retornar){
							alert('Ya agregó esta materia');
							return [false,'YA EXISTE LA MATERIA AGREGADA'];
						}
						
						postData.idid = obj.id;
						postData.denominacion = obj.denominacion;
						postData.nivel = obj.nivel_descripcion;
						postData.carrera = obj.nivel_carrera_denominacion;						
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
					$('#TblGrid_matregcursarId').hide();
					//$('#busquedaRequisitoId').show();
					$('#FrmGrid_matregcursarId').append('<table id="tablaBusquedaMateriaMatRegCursarId"></table><div id="pagerBusquedaMateriaMatRegCursarId"></div>');
					initGridBusquedaMaterias('tablaBusquedaMateriaMatRegCursarId','pagerBusquedaMateriaMatRegCursarId');
				}
				,bSubmit:'Agregar'
			
			}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		);
		
	//---------------------------------------------------------------------------
	jQuery("#mataprobcursarId").jqGrid({ 
		url:locmataprobcursar
		,editurl:loceditmateria
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','Id','Denominación','Nivel','Carrera']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'idid',index:'idid', width:30,hidden:true, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
			, {name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
			, {name:'nivel',index:'nivel', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
			, {name:'carrera',index:'carrera', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
		]
		//, rowNum:10, rowList:[10,20,30]
		, pager: '#pagermataprobcursarId'
		, sortname: 'id'
		, viewrecords: true, sortorder: "desc"
		, caption:"Materias Aprobadas para Cursar"  
		, height:130
	}); 
		
		
		
	jQuery("#mataprobcursarId").jqGrid('navGrid','#pagermataprobcursarId', {add:true,edit:false,del:true,search:false,refresh:false}, //options 
			{height:280,width:310,reloadAfterSubmit:false
				, recreateForm:true
				,modal:false
				,editCaption:'Modificar Materias'
				, beforeShowForm:function(form){
					}
				,bSubmit:'Modificar'
			
			}, // edit options 
			{height:450,width:450,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Materias Aprobadas para Cursar'
				,beforeSubmit: function(postData,formId){

					var gridDataMatregcursar = jQuery("#mataprobcursarId").getRowData();
					var retornar=false;
					var id = $('#tablaBusquedaMateriaMatAprobCursarId').jqGrid('getGridParam','selrow');
					var obj;
					if(!id){
						alert('Seleccione un Materia de la Grilla');
						return [false,''];
					}else{
						obj = $('#tablaBusquedaMateriaMatAprobCursarId').getRowData(id);
						$.each( gridDataMatregcursar, function(i, row){
	   						 if(obj.id==row.idid){
	   						 	retornar=true;
	   						 	return;
	   						 }
						});
						if(retornar){
							alert('Ya agregó esta materia');
							return [false,'YA EXISTE LA MATERIA AGREGADA'];
						}
						
						postData.idid = obj.id;
						postData.denominacion = obj.denominacion;
						postData.nivel = obj.nivel_descripcion;
						postData.carrera = obj.nivel_carrera_denominacion;						
						return [true,''];
					}
				}
				,beforeShowForm:function(form){
					$('#TblGrid_mataprobcursarId').hide();
					//$('#busquedaRequisitoId').show();
					$('#FrmGrid_mataprobcursarId').append('<table id="tablaBusquedaMateriaMatAprobCursarId"></table><div id="pagerBusquedaMateriaMatAprobCursarId"></div>');
					initGridBusquedaMaterias('tablaBusquedaMateriaMatAprobCursarId','pagerBusquedaMateriaMatAprobCursarId');
					
				}
				,bSubmit:'Agregar'
			
			}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		);	
	//-------------------------------------------------------------------	
		
	jQuery("#matregrendirId").jqGrid({ 
		url:locmatregrendir
		,editurl:loceditmateria
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','Id','Denominación','Nivel','Carrera']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'idid',index:'idid', width:30,hidden:true, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
			, {name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
			, {name:'nivel',index:'nivel', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
			, {name:'carrera',index:'carrera', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
		]
		//, rowNum:10, rowList:[10,20,30]
		, pager: '#pagermatregrendirId'
		, sortname: 'id'
		, viewrecords: true, sortorder: "desc"
		, caption:"Materias Regulares para Rendir"  
		, height:130
	}); 
		
		
		
	jQuery("#matregrendirId").jqGrid('navGrid','#pagermatregrendirId', {add:true,edit:false,del:true,search:false,refresh:false}, //options 
			{height:280,width:310,reloadAfterSubmit:false
				, recreateForm:true
				,modal:false
				,editCaption:'Modificar Materias'
				, beforeShowForm:function(form){
					}
				,bSubmit:'Modificar'
			
			}, // edit options 
			{height:450,width:450,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Materias Regulares para Rendir'
				,beforeSubmit: function(postData,formId){

					var gridDataMatregcursar = jQuery("#matregrendirId").getRowData();
					var retornar=false;
					var id = $('#tablaBusquedaMateriaMatRegRendirId').jqGrid('getGridParam','selrow');
					var obj;
					if(!id){
						alert('Seleccione un Materia de la Grilla');
						return [false,''];
					}else{
						obj = $('#tablaBusquedaMateriaMatRegRendirId').getRowData(id);
						$.each( gridDataMatregcursar, function(i, row){
	   						 if(obj.id==row.idid){
	   						 	retornar=true;
	   						 	return;
	   						 }
						});
						if(retornar){
							alert('Ya agregó esta materia');
							return [false,'YA EXISTE LA MATERIA AGREGADA'];
						}
						
						postData.idid = obj.id;
						postData.denominacion = obj.denominacion;
						postData.nivel = obj.nivel_descripcion;
						postData.carrera = obj.nivel_carrera_denominacion;						
						return [true,''];
					}
				}
				,beforeShowForm:function(form){
					$('#TblGrid_matregrendirId').hide();
					//$('#busquedaRequisitoId').show();
					$('#FrmGrid_matregrendirId').append('<table id="tablaBusquedaMateriaMatRegRendirId"></table><div id="pagerBusquedaMateriaMatRegRendirId"></div>');
					initGridBusquedaMaterias('tablaBusquedaMateriaMatRegRendirId','pagerBusquedaMateriaMatRegRendirId');
					
				}
				,bSubmit:'Agregar'
			
			}, // add options 
			{	reloadAfterSubmit:false
				,beforeSubmit:function(postData,formId){
					obj = $('#matregrendirId').getRowData(postData);
					if(obj.idid==$('#idMateria').val()){
						return[false,'No se puede eliminar. Recuerde que para rendir un final la materia debe estar regular '];
					}
					return[true,''];
				}
			}, // del options 
			{} // search options 
		);	
	//-------------------------------------------------------------------	
		

	jQuery("#mataprobrendirId").jqGrid({ 
		url:locmataprobrendir
		,editurl:loceditmateria
		,datatype: "json"
		,width:600
		,rownumbers:true
		,colNames:['Id','Id','Denominación','Nivel','Carrera']
		,colModel:[ 
			{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
			, {name:'idid',index:'idid', width:30,hidden:true, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
			, {name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
			, {name:'nivel',index:'nivel', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
			, {name:'carrera',index:'carrera', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
		]
		//, rowNum:10, rowList:[10,20,30]
		, pager: '#pagermataprobrendirId'
		, sortname: 'id'
		, viewrecords: true, sortorder: "desc"
		, caption:"Materias Aprobadas para Rendir"  
		, height:130
	}); 
		
		
		
	jQuery("#mataprobrendirId").jqGrid('navGrid','#pagermataprobrendirId', {add:true,edit:false,del:true,search:false,refresh:false}, //options 
			{height:280,width:310,reloadAfterSubmit:false
				, recreateForm:true
				,modal:false
				,editCaption:'Modificar Materias'
				, beforeShowForm:function(form){
					}
				,bSubmit:'Modificar'
			
			}, // edit options 
			{height:450,width:450,reloadAfterSubmit:false
				,recreateForm:true
				,modal:false
				,addCaption:'Agregar Materias Aprobadas para Rendir'
				,beforeSubmit: function(postData,formId){

					var gridDataMatregcursar = jQuery("#mataprobrendirId").getRowData();
					var retornar=false;
					var id = $('#tablaBusquedaMateriaMatAprobRendirId').jqGrid('getGridParam','selrow');
					var obj;
					if(!id){
						alert('Seleccione un Materia de la Grilla');
						return [false,''];
					}else{
						obj = $('#tablaBusquedaMateriaMatAprobRendirId').getRowData(id);
						$.each( gridDataMatregcursar, function(i, row){
	   						 if(obj.id==row.idid){
	   						 	retornar=true;
	   						 	return;
	   						 }
						});
						if(retornar){
							alert('Ya agregó esta materia');
							return [false,'YA EXISTE LA MATERIA AGREGADA'];
						}
						
						postData.idid = obj.id;
						postData.denominacion = obj.denominacion;
						postData.nivel = obj.nivel_descripcion;
						postData.carrera = obj.nivel_carrera_denominacion;						
						return [true,''];
					}
				}
				,beforeShowForm:function(form){
					$('#TblGrid_mataprobrendirId').hide();
					//$('#busquedaRequisitoId').show();
					$('#FrmGrid_mataprobrendirId').append('<table id="tablaBusquedaMateriaMatAprobRendirId"></table><div id="pagerBusquedaMateriaMatAprobRendirId"></div>');
					initGridBusquedaMaterias('tablaBusquedaMateriaMatAprobRendirId','pagerBusquedaMateriaMatAprobRendirId');
					
				}
				,bSubmit:'Agregar'
			
			}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		);	
		
	bindmaterias();
});