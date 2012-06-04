
<%@ page import="com.educacion.academico.InscripcionMatricula" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula')}" />
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
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMatricula.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: inscripcionMatriculaInstance, field: "id")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMatricula.alumno.label" default="Alumno" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="alumno" action="show" id="${inscripcionMatriculaInstance?.alumno?.id}">${inscripcionMatriculaInstance?.alumno?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMatricula.anioLectivo.label" default="Anio Lectivo" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="anioLectivo" action="show" id="${inscripcionMatriculaInstance?.anioLectivo?.id}">${inscripcionMatriculaInstance?.anioLectivo?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMatricula.carrera.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${inscripcionMatriculaInstance?.carrera?.id}">${inscripcionMatriculaInstance?.carrera?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMatricula.detalle.label" default="Detalle" /></div>
                            
                            <div class="span-4 spanlabel">
                                <ul>
                                <g:each in="${inscripcionMatriculaInstance.detalle}" var="d">
                                    <li><g:link controller="inscripcionDetalleRequisito" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMatricula.estado.label" default="Estado" /></div>
                            
                            <div class="span-4 spanlabel">${inscripcionMatriculaInstance?.estado?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMatricula.fechaAlta.label" default="Fecha Alta" /></div>
                            
                            <div class="span-4 spanlabel"><g:formatDate date="${inscripcionMatriculaInstance?.fechaAlta}" /></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMatricula.inscripcionesmaterias.label" default="Inscripcionesmaterias" /></div>
                            
                            <div class="span-4 spanlabel">
                                <ul>
                                <g:each in="${inscripcionMatriculaInstance.inscripcionesmaterias}" var="i">
                                    <li><g:link controller="inscripcionMateria" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
							<div class="clear"></div>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${inscripcionMatriculaInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
