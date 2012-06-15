
<%@ page import="com.educacion.academico.Division" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'division.label', default: 'Division')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
		<script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>        
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript">
        	$(document).ready(function(){
        		$("#divisionId").jqGrid({ 
        			url:'<%out << createLink(controller:'division',action:'listdivisiones')%>'
        			,editurl:'<%out << createLink(controller:"division",action:"editdivisiones")%>'
            		,postData: {id: <%out << nivelInstance.id %>}
        			,datatype: "json"
        			,width:600
        			,rownumbers:true
        			,colNames:['Descripción','Letra','Turno', 'Descripción Turno', 'Cupo']
        			,colModel:[ 
   						  {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
   					    , {name:'letra',index:'letra', width:50, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}						
   					    , {name:'turno',index:'turno', width:50, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}						
   					    , {name:'descriturno',index:'descriturno', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:false}, sortable:false}						
   					    , {name:'cupo',index:'cupo', width:50, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}						
  					]
        			, pager: '#pagerdivisionId'
        			, sortname: 'descripcion'
        			, viewrecords: true, sortorder: "desc"
        			, caption:"Divisiones"  
        			, height:130
        		}); 

        		
        	});
        	</script>        
        
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <div class="dialog">
                    
                            <div class="span-4 spanlabel"><g:message code="nivel.carrera.id.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: nivelInstance.carrera, field: "denominacion")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="nivel.label" default="Nivel" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: nivelInstance, field: "descripcion")}</div>
                            
							<div class="clear"></div>
                    		

						    <fieldset>
						   		<legend>Divisiones</legend>
						   		<table id="divisionId"></table>
						   		<div id="pagerdivisionId"></div>
						    </fieldset>

            </div>
        </div>
    </body>
</html>
