
<%@ page import="com.educacion.seguridad.RequestmapGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'requestmapGroup.label', default: 'RequestmapGroup')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript">
		    	$(document).ready(function(){
		
					//----requests---
					jQuery("#requestsId").jqGrid({ 
						url:'<%out<<createLink(controller:"requestmapGroup",action:"listrequest",params:[id:requestmapGroupInstance.id])%>'
						,editurl:'<%out<<createLink(controller:"requestmapGroup",action:"editrequests")%>'
						,datatype: "json"
						,width:600
						//,rownumbers:true
						,colNames:['Id','URL', 'Descripción']
						,colModel:[ 
							{name:'id',index:'id', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
							, {name:'url',index:'url', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
							, {name:'descripcion',index:'descripcion',hidden:false, width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:false}, sortable:false}						
						]
						, pager: '#pagerRequests'
						, sortname: 'id'
						, viewrecords: true, sortorder: "desc"
						, caption:"URLs"
						, height:140
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
                    
                            <div class="span-4 spanlabel"><g:message code="requestmapGroup.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: requestmapGroupInstance, field: "id")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="requestmapGroup.descripcion.label" default="Descripcion" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: requestmapGroupInstance, field: "descripcion")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="requestmapGroup.requests.label" default="Peticiones" /></div>
                            
                             
					   <div class="clear"></div>
					   <fieldset>
					   		<legend>URLs</legend>
							<g:hiddenField id="requestsSerializedId" name="requestsSerialized" value="${requestsSerialized}"/>
           					<div class="clear"></div>
                           <div class="span-18">
                           		<table id="requestsId"></table>
                           </div>
                           <div id="pagerRequests">	</div>						   		
					   </fieldset>

                    
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${requestmapGroupInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
