
<%@ page import="com.educacion.academico.AsignaturaDocente" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente')}" />
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
                    
                            <div class="span-4 spanlabel"><g:message code="asignaturaDocente.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: asignaturaDocenteInstance, field: "id")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="asignaturaDocente.carrera.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${asignaturaDocenteInstance?.carrera?.id}">${asignaturaDocenteInstance?.carrera?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="asignaturaDocente.anioLectivo.label" default="Anio Lectivo" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="anioLectivo" action="show" id="${asignaturaDocenteInstance?.anioLectivo?.id}">${asignaturaDocenteInstance?.anioLectivo?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="asignaturaDocente.docente.label" default="Docente" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="docente" action="show" id="${asignaturaDocenteInstance?.docente?.id}">${asignaturaDocenteInstance?.docente?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="asignaturaDocente.fechaAlta.label" default="Fecha Alta" /></div>
                            
                            <div class="span-4 spanlabel"><g:formatDate date="${asignaturaDocenteInstance?.fechaAlta}" /></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="asignaturaDocente.materias.label" default="Materias" /></div>
                            
                            <div class="span-4 spanlabel">
                                <ul>
                                <g:each in="${asignaturaDocenteInstance.materias}" var="m">
                                    <li><g:link controller="materia" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
							<div class="clear"></div>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${asignaturaDocenteInstance?.id}" />
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
