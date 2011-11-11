
<%@ page import="com.educacion.academico.Carrera" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'carrera.label', default: 'Carrera')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
				//----requisitos---
				jQuery("#requisitosId").jqGrid({ 
					url:'<%out << createLink(controller:'carrera',action:'listrequisitos',params:[id:carreraInstance.id])%>'
					,editurl:'editrequisitos'
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
					, pager: '#pagerRequisitos'
					, sortname: 'id'
					, viewrecords: true, sortorder: "desc"
					, caption:"Requisitos",  height:210
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
            	<div class="span-16">
		                <table>
		                    <tbody>
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="carrera.id.label" default="Id" /></td>
		                            
		                            <td valign="top" class="value">${fieldValue(bean: carreraInstance, field: "id")}</td>
		                            
		                        </tr>
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="carrera.campoOcupacional.label" default="Campo Ocupacional" /></td>
		                            
		                            <td valign="top" class="value">${fieldValue(bean: carreraInstance, field: "campoOcupacional")}</td>
		                            
		                        </tr>
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="carrera.denominacion.label" default="Denominacion" /></td>
		                            
		                            <td valign="top" class="value">${fieldValue(bean: carreraInstance, field: "denominacion")}</td>
		                            
		                        </tr>
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="carrera.duracion.label" default="Duracion" /></td>
		                            
		                            <td valign="top" class="value">${fieldValue(bean: carreraInstance, field: "duracion")}</td>
		                            
		                        </tr>
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="carrera.modalidadFormacion.label" default="Modalidad Formacion" /></td>
		                            
		                            <td valign="top" class="value">${carreraInstance?.modalidadFormacion?.name?.encodeAsHTML()}</td>
		                            
		                        </tr>
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="carrera.niveles.label" default="Niveles" /></td>
		                            
		                            <td valign="top" style="text-align: left;" class="value">
		                                <ul>
		                                <g:each in="${carreraInstance.niveles}" var="n">
		                                    <li><g:link controller="nivel" action="show" id="${n.id}">${n?.encodeAsHTML()}</g:link></li>
		                                </g:each>
		                                </ul>
		                            </td>
		                            
		                        </tr>
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="carrera.perfilEgresado.label" default="Perfil Egresado" /></td>
		                            
		                            <td valign="top" class="value">${fieldValue(bean: carreraInstance, field: "perfilEgresado")}</td>
		                            
		                        </tr>
		                    
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="carrera.titulo.label" default="Titulo" /></td>
		                            
		                            <td valign="top" class="value">${fieldValue(bean: carreraInstance, field: "titulo")}</td>
		                            
		                        </tr>
		                    
		                        <tr class="prop">
		                            <td valign="top" class="name"><g:message code="carrera.validezTitulo.label" default="Validez Titulo" /></td>
		                            
		                            <td valign="top" class="value">${fieldValue(bean: carreraInstance, field: "validezTitulo")}</td>
		                            
		                        </tr>
		                    
		                    </tbody>
		                </table>
				</div>	
			   <div class="clear"></div>
			   <div class="span-10">
				   <fieldset>
				   		<legend>Requisitos</legend>
         				<div class="clear"></div>
                         <div class="span-18">
                         	<table id="requisitosId"></table>
                         </div>
                         <div id="pagerRequisitos">	</div>						   		
				   </fieldset>
			   </div>                
            </div>
            <div class="clear"></div>
            <div class="span-16">
                <g:form>
                    <g:hiddenField name="id" value="${carreraInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
