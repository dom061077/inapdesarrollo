
<%@ page import="com.medfire.AntecedenteLabel" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'antecedenteLabel.label', default: 'AntecedenteLabel')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jquery-ui/js/src/css',file:'jquery.searchFilter.css')}" />        
        <script type="text/javascript" src="${g.resource(dir:'js/jquery-ui/js/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jquery-ui/js',file:'jquery.jqGrid.min.js')}"></script>

        <script type="text/javascript">
		    	$(document).ready(
						function(){
							jQuery("#list").jqGrid({
							   	url:'<%out<< "${createLink(controller:"antecedenteLabel",action:"listjson")}"%>',
								datatype: "json",
								width:680,
							   	colNames:['Id','Nombre del Profesional', 'Matrícula','Operaciones'],
							   	colModel:[
							   		
							   		{name:'id',index:'id', width:40,search:false},
							   		{name:'profesional_nombre',index:'profesional_nombre', width:92,sortable:true},
							   		{name:'profesional_matricula',index:'profesional_matricula', width:100,sortable:true},
							   		{name:'operaciones',index:'operaciones', width:55,sortable:false,search:false}
							   	],
							   	
							   	rowNum:10,
							   	rownumbers:true,
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
										be = "<a href='<%out << "${createLink(controller:"antecedenteLabel",action:"edit")}"%>/"+ids[i]+"'><span class='ui-icon ui-icon-pencil' style='margin: 3px 3px 3px 10px'  ></span></a>";
										jQuery("#list").jqGrid('setRowData',ids[i],{operaciones:be}); 
										} 
								}, 						    
							    caption:"Listado de Profesionales con Etiquetas"
							});
							jQuery("#list").jqGrid('navGrid','#pager',{search:false,edit:false,add:false,del:false,pdf:true});
							jQuery("#list").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});
							jQuery("#list").jqGrid('navButtonAdd','#pager',{
							       caption:"Excel", 
							       onClickButton : function () { 
							           //jQuery("#list").excelExport();
							           jQuery("#list").jqGrid("excelExport",{url:"excelexport"});
							       } 
							});
							
							
						}
		        );
        
        
        </script>
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
<%--            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>--%>
        </div>        
        <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
        </g:if>
             
        <div class="body">
            <h1><g:message code="antecedenteLabel.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><h3>${flash.message}</h3></div>
            </g:if>
			<table style="z-index:1"  id="list"></table>
			<div id="pager" ></div>
            
        </div>
            
     </body>
</html>
