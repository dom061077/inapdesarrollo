
<%@ page import="com.educacion.academico.Materia" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'materia.label', default: 'Materia')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
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
                <table>
                    <tbody>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.id.label" default="Id" /></div>
                            
                            <div class="span-4">${fieldValue(bean: materiaInstance, field: "id")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.codigo.label" default="Codigo" /></div>
                            
                            <div class="span-4">${fieldValue(bean: materiaInstance, field: "codigo")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.denominacion.label" default="Denominacion" /></div>
                            
                            <div class="span-4">${fieldValue(bean: materiaInstance, field: "denominacion")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.descripcion.label" default="Descripcion" /></div>
                            
                            <div class="span-4">${fieldValue(bean: materiaInstance, field: "descripcion")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.duracion.label" default="Duracion" /></div>
                            
                            <div class="span-4"><g:link controller="duracionMateria" action="show" id="${materiaInstance?.duracion?.id}">${materiaInstance?.duracion?.descripcion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.estado.label" default="Estado" /></div>
                            
                            <div class="span-4">${materiaInstance?.estado?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
							
                            <div class="span-4 spanlabel"><g:message code="materia.nivel.carrera.label" default="Carrera" /></div>
                            
                            <div class="span-4"><g:link controller="carrera" action="show" id="${materiaInstance?.nivel?.carrera?.id}">${materiaInstance?.nivel?.carrera?.denominacion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
							
                    
                            <div class="span-4 spanlabel"><g:message code="materia.nivel.label" default="Nivel" /></div>
                            
                            <div class="span-4"><g:link controller="nivel" action="show" id="${materiaInstance?.nivel?.id}">${materiaInstance?.nivel?.descripcion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.pca.label" default="Pca" /></div>
                            
                            <div class="span-4"><g:link controller="materia" action="show" id="${materiaInstance?.pca?.id}">${materiaInstance?.pca?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.pcr.label" default="Pcr" /></div>
                            
                            <div class="span-4"><g:link controller="materia" action="show" id="${materiaInstance?.pcr?.id}">${materiaInstance?.pcr?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.pra.label" default="Pra" /></div>
                            
                            <div class="span-4"><g:link controller="materia" action="show" id="${materiaInstance?.pra?.id}">${materiaInstance?.pra?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.promocional.label" default="Promocional" /></div>
                            
                            <div class="span-4"><g:formatBoolean boolean="${materiaInstance?.promocional}" /></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.prr.label" default="Prr" /></div>
                            
                            <div class="span-4"><g:link controller="materia" action="show" id="${materiaInstance?.prr?.id}">${materiaInstance?.prr?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.tipo.label" default="Tipo" /></div>
                            
                            <div class="span-4">${materiaInstance?.tipo?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${materiaInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
