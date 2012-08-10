
<%@ page import="com.educacion.academico.CargaExamen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cargaExamen.label', default: 'CargaExamen')}" />
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
                    
                            <div class="span-4 spanlabel"><g:message code="cargaExamen.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: cargaExamenInstance, field: "id")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="cargaExamen.carrera.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${cargaExamenInstance?.carrera?.id}">${cargaExamenInstance?.carrera?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="cargaExamen.anioLectivo.label" default="Anio Lectivo" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="anioLectivo" action="show" id="${cargaExamenInstance?.anioLectivo?.id}">${cargaExamenInstance?.anioLectivo?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="cargaExamen.materia.label" default="Materia" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="materia" action="show" id="${cargaExamenInstance?.materia?.id}">${cargaExamenInstance?.materia?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="cargaExamen.docente.label" default="Docente" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="docente" action="show" id="${cargaExamenInstance?.docente?.id}">${cargaExamenInstance?.docente?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="cargaExamen.titulo.label" default="Titulo" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: cargaExamenInstance, field: "titulo")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="cargaExamen.modalidad.label" default="Modalidad" /></div>
                            
                            <div class="span-4 spanlabel">${cargaExamenInstance?.modalidad?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="cargaExamen.tipo.label" default="Tipo" /></div>
                            
                            <div class="span-4 spanlabel">${cargaExamenInstance?.tipo?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
                    
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${cargaExamenInstance?.id}" />
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
