
<%@ page import="com.educacion.academico.Aula" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'aula.label', default: 'Aula')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
		<script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>        
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript">
        	$(document).ready(function(){
        		$("#detalleaulaId").jqGrid({ 
        			url:'<%out << createLink(controller:'aula',action:'listcarreras')%>'
        			,editurl:'<%out << createLink(controller:"aula",action:"editcarreras")%>'
            		,postData: {id: <%out << aulaInstance.id %>}
        			,datatype: "json"
        			,width:600
        			,rownumbers:true
        			,colNames:['Id','Denominación','Observación']
        			,colModel:[ 
        				{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
        				, {name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        				, {name:'observacion',index:'observacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        			]
        			//, rowNum:10, rowList:[10,20,30]
        			, pager: '#pagerdetalleaulaId'
        			, sortname: 'id'
        			, viewrecords: true, sortorder: "desc"
        			, caption:"Carreras vinculadas con esta aula"  
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
                   
                            <div class="span-4 spanlabel"><g:message code="aula.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: aulaInstance, field: "id")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="aula.nombre.label" default="Nombre" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: aulaInstance, field: "nombre")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="aula.cupo.label" default="Cupo" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: aulaInstance, field: "cupo")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="aula.estado.label" default="Estado" /></div>
                            
                            <div class="span-4 spanlabel">${aulaInstance?.estado?.name?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="aula.localizacion.label" default="Localizacion" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: aulaInstance, field: "localizacion")}</div>
                            
							<div class="clear"></div>


						   <fieldset>
						   		<legend>Carreras del Aula</legend>
						   		<g:hiddenField id="detalleaulaSerializedId" name="detalleaulaSerialized" value="${detalleaulaSerialized}"/>
						   		<table id="detalleaulaId"></table>
						   		<div id="pagerdetalleaulaId"></div>
						   </fieldset>
                    
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="aulaId" value="${aulaInstance?.id}" />
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
