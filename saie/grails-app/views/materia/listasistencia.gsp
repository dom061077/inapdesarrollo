
<%@ page import="com.educacion.academico.Materia" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'materia.label', default: 'Materia')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        

        <script type="text/javascript">
        	function clickreporte(id){
            	
            	    obj = jQuery("#list").getRowData(id);
            	
				    var anio = $('#'+obj.id+'_anio').val();
				    if(anio==undefined)
					    anio=obj.anio;
            	    window.location='reporteasistencia?id='+obj.id+'&aniolectivo='+anio+'&_target=blank'
            }

            jQuery(document).ready(function(){
            	
				var lastsel3;
        		jQuery("#list").jqGrid({
				   	url:'listjsonasistencia',
					datatype: "json",
					width:680,
					colNames:['Id','Nombre','Nivel','Carrera','Año', 'Asistencia'],
				   	colModel:[
				   		
				   		{name:'id',index:'id', width:40},
				   		{name:'denominacion',index:'denominacion', width:92,sortable:false},
				   		{name:'nivel_descripcion',index:'nivel_descripcion', width:100,search:true},
				   		{name:'nivel_carrera_denominacion',index:'nivel_carrera_denominacion', width:100,search:true},
				   		{name:'anio',index:'anio', width:45, editable:true, search:false, edittype:"select", editoptions:{value:"2011:2011;2012:2012;2013:2013;2014:2014;2015:2015;2016:2016"}},
				   		{name:'operaciones',index:'operaciones', width:40,search:false,sortable:false}
				   	],

				   	onSelectRow: function(id){ 
					   	if(id && id!==lastsel3){ 
						   	jQuery('#list').jqGrid('restoreRow',lastsel3); 
						   	jQuery('#list').jqGrid('editRow',id,true); 
						   	lastsel3=id; } 
					   },
				   	
				   	rowNum:10,
				   	//rownumbers:true,
				   	rowList:[10,20,30],
				   	pager: '#pager',
				   	sortname: 'id',
				    viewrecords: true,
				    sortorder: "desc",
					gridComplete: function(){ 
						var ids = jQuery("#list").jqGrid('getDataIDs');
						var obj; 
						for(var i=0;i < ids.length;i++){ 
							var cl = ids[i];
							obj = jQuery("#list").getRowData(ids[i]); 
							//var se = "<a title='Mostrar' href='reporteasistencia/"+ids[i]+"'><span class='ui-icon ui-icon-search' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
							var se = "<a title='Mostrar' href='#' onClick='clickreporte("+ids[i]+")'><span class='ui-icon ui-icon-contact' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
							jQuery("#list").jqGrid('setRowData',ids[i],{operaciones:se}); 
							}
						
						 
					}, 						    
				    caption:"Listado de ${message(code: 'materia.label', default: 'Materia')}"
				});
				jQuery("#list").jqGrid('navGrid','#pager',{search:false,edit:false,add:false,del:false,pdf:true});

				jQuery("#list").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});						
	
            });
		</script>        
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1>Reporte de Asistencia</h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2> ${flash.message}</H2> </div>
            </g:if>
			<table style="z-index:1"  id="list"></table>
			<div id="pager" ></div>
        </div>
    </body>
</html>
