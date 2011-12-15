    function initsubmit(){
		var gridDataMatregcursar = jQuery("#matregcursarId").getRowData();
    	var postDataMatregcursar = JSON.stringify(gridDataMatregcursar);
    	$("#matregcursarSerializedId").val(postDataMatregcursar);
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
    }
	
	
	function initGridBusquedaMaterias(){
		//---------------inicializacion de la grilla de busqueda de Materias para sugerir las Materias
		$('#tablaBusquedaMateriaId').jqGrid({
			caption:'Búsqueda de Materias',
			url:locmateria,
		mtype:'POST',
		width:400,
		rownumbers:true,
		pager:'pagerBusquedaMateriaId',
		datatype:'json',
		colNames:['Id','Denominación','Nivel','Carrera'],
		colModel:[
				{name:'id',index:'id',width:10,hidden:true},
				{name:'denominacion',index:'denominacion',width:100,sorttype:'text',sortable:true},
				{name:'nivel_descripcion',index:'nivel_descripcion',width:100,sorttype:'text',sortable:true},
				{name:'nivel_carrera_denominacion',index:'nivel_carrera_denominacion',width:100,sorttype:'text',sortable:true}				
		]
		});
		jQuery("#tablaBusquedaMateriaId").jqGrid('navGrid','#pagerBusquedaRequisitoId',{search:false,edit:false,add:false,del:false,pdf:true});
		jQuery('#tablaBusquedaMateriaId').jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});
		jQuery("#tablaBusquedaMateriaId").jqGrid('navButtonAdd','#pagerBusquedaMateriaId',{
		       caption:"Informe", 
		       onClickButton : function () {
		    	   var id = jQuery('#tablaBusquedaMateriaId').jqGrid('getGridParam','selrow');
		    	   if(id)
		    		   window.location = locvademecdetalle+'?target=_blank&id='+id;
		    	   else
		    		   $('<div>Seleccione una fila para activar esta opción</div>').dialog({title:'Mensaje',modal: true});
		    	   
		       } 
		});	
		
		//-----------------------------------------------------------------------------------------
		
	}
	

	jQuery("#matregcursarId").jqGrid({ 
		url:'listmatregcursar'
		,editurl:'editmat'
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
		, caption:"Materias Regulares para Rendir"  
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
				,addCaption:'Agregar Materias Regulares para Rendir'
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
					var id = $('#tablaBusquedaMateriaId').jqGrid('getGridParam','selrow');
					var obj;
					if(!id){
						alert('Seleccione un Materia de la Grilla');
						return [false,''];
					}else{
						obj = $('#tablaBusquedaMateriaId').getRowData(id);
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
					$('#FrmGrid_matregcursarId').append('<table id="tablaBusquedaMateriaId"></table><div id="pagerBusquedaMateriaId"></div>');
					initGridBusquedaMaterias();
					
				}
				,bSubmit:'Agregar'
			
			}, // add options 
			{reloadAfterSubmit:false}, // del options 
			{} // search options 
		);	
	bindmaterias();
});