
<%@ page import="com.educacion.academico.DocumentoCarrera" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentoCarrera.label', default: 'DocumentoCarrera')}" />
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
                    
                            <div class="span-4 spanlabel"><g:message code="documentoCarrera.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: documentoCarreraInstance, field: "id")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="documentoCarrera.nombreOriginalDocumento.label" default="Documento" /></div>
                            
                            <div class="span-4 spanlabel"><a href="${g.resource(dir:grailsApplication.config.documentocarrerafolder,file:documentoCarreraInstance.documento)}">${fieldValue(bean: documentoCarreraInstance, field: "nombreOriginalDocumento")}</a></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="documentoCarrera.imageExtension.label" default="Image Extension" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: documentoCarreraInstance, field: "imageExtension")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="documentoCarrera.carrera.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${documentoCarreraInstance?.carrera?.id}">${documentoCarreraInstance?.carrera?.denominacion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${documentoCarreraInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
