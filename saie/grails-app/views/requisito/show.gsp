
<%@ page import="com.educacion.academico.Requisito" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'requisito.label', default: 'Requisito')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript">
        	$(document).ready(function(){
				//----subrequisitos---
				jQuery("#subrequisitosId").jqGrid({ 
					url:'<%out << createLink(controller:'requisito',action:'listsubrequisitos',params:[id:requisitoInstance.id])%>'
					,editurl:'editsubrequisitos'
					,datatype: "json"
					,width:600
					,rownumbers:true
					,colNames:['Id','Id','Código', 'Descripción']
					,colModel:[ 
						{name:'id',index:'id', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
						, {name:'id',index:'id', width:30,editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
						, {name:'codigo',index:'codigo', width:30,editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
						, {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
					]
					//, rowNum:10, rowList:[10,20,30]
					, pager: '#pagerSubrequisitos'
					, sortname: 'id'
					, viewrecords: true, sortorder: "desc"
					, caption:"Subrequisitos",  height:210
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
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
            	<div class="span-10">
	                <table>
	                    <tbody>
	                    
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="requisito.id.label" default="Id" /></td>
	                            
	                            <td valign="top" class="value">${fieldValue(bean: requisitoInstance, field: "id")}</td>
	                            
	                        </tr>
	                    
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="requisito.codigo.label" default="Codigo" /></td>
	                            
	                            <td valign="top" class="value">${fieldValue(bean: requisitoInstance, field: "codigo")}</td>
	                            
	                        </tr>
	                    
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="requisito.descripcion.label" default="Descripcion" /></td>
	                            
	                            <td valign="top" class="value">${fieldValue(bean: requisitoInstance, field: "descripcion")}</td>
	                            
	                        </tr>
	                    
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="requisito.claseRequisito.label" default="Clase Requisito" /></td>
	                            
	                            <td valign="top" class="value"><g:link controller="claseRequisito" action="show" id="${requisitoInstance?.claseRequisito?.id}">${requisitoInstance?.claseRequisito?.descripcion?.encodeAsHTML()}</g:link></td>
	                            
	                        </tr>
	                    
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="requisito.estado.label" default="Estado" /></td>
	                            
	                            <td valign="top" class="value">${requisitoInstance?.estado?.name?.encodeAsHTML()}</td>
	                            
	                        </tr>
	                    
	                    
	                    </tbody>
	                </table>
                </div>
			   <div class="clear"></div>
			   <div class="span-10">
				   <fieldset>
				   		<legend>Sub Requisitos</legend>
						<g:hiddenField id="subRequisitosSerializedId" name="subRequisitosSerialized" value="${subRequisitosSerialized}"/>
	         				<div class="clear"></div>
	                         <div class="span-18">
	                         	<table id="subrequisitosId"></table>
	                         </div>
	                         <div id="pagerSubrequisitos">	</div>						   		
				   </fieldset>
			   </div>                
            </div>
            <div class="clear"></div>
            <div class="span-10">
                <g:form>
                    <g:hiddenField name="id" value="${requisitoInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
