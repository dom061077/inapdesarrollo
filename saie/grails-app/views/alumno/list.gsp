
<%@ page import="com.educacion.alumno.Alumno" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'alumno.label', default: 'Alumno')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        

        <script type="text/javascript">
            function clickreporte(id){
                var obj = jQuery("#list").getRowData(id);
                window.location='reportealumno?id='+obj.id+'&_target=blank'
            }

        	jQuery(document).ready(function(){
				jQuery("#list").jqGrid({
				   	url:'listjson',
					datatype: "json",
					width:680,
					colNames:['Id','Apellido','Nombre','Tipo Documento','Nro. de Doc.','Fecha Nac.','Ver'],
				   	colModel:[
				   		
				   		{name:'id',index:'id', width:40,sorttype:'int',sortable:true,searchoptions:{sopt:['eq']}},
				   		{name:'apellido',index:'apellido', width:92,search:true,sortable:true},
				   		{name:'nombre',index:'nombre', width:92,search:true,sortable:true},
				   		{name:'tipoDocumento',index:'tipoDocumento', width:55,search:false},
				   		{name:'numeroDocumento',index:'numeroDocumento', width:55,search:true,sorttype:'int',sortable:true,searchoptions:{sopt:['eq']}},
				   		{name:'fechaNacimiento',index:'fechaNacimiento', width:55,search:false,sortable:false},
				   		{name:'operaciones',index:'operaciones', width:55,search:false,sortable:false}
				   	],
				   	
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
							obj = $("#list").getRowData(ids[i]); 
							be = "<a href='edit/"+ids[i]+"'><span class='ui-icon ui-icon-pencil' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
							var se = "<a href='show/"+ids[i]+"'><span class='ui-icon ui-icon-search' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
                            var re = "<a title='Mostrar' href='#' onClick='clickreporte("+ids[i]+")'><span class='ui-icon ui-icon-contact' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
							jQuery("#list").jqGrid('setRowData',ids[i],{operaciones:be+se+re});
							}
						 
					}, 	
				    caption:"Listado de Alumnos"
				});
				jQuery("#list").jqGrid('navGrid','#pager',{search:false,edit:false,add:false,del:false,pdf:true});

				jQuery("#list").jqGrid('navButtonAdd','#pager',{
				       caption:"Informe", 
				       onClickButton : function () {
                           window.location = '<%out << createLink(controller:"alumno",action:"reportealumnos") %>';
				       }
				});

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
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
			<table style="z-index:1"  id="list"></table>
			<div id="pager" ></div>
        </div>
    </body>
</html>
