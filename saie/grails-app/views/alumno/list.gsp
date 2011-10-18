
<%@ page import="com.educacion.alumno.Alumno" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'alumno.label', default: 'Alumno')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'alumno.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="anioEgreso" title="${message(code: 'alumno.anioEgreso.label', default: 'Anio Egreso')}" />
                        
                            <g:sortableColumn property="apellidoNombre" title="${message(code: 'alumno.apellidoNombre.label', default: 'Apellido Nombre')}" />
                        
                            <g:sortableColumn property="barrioDomicilio" title="${message(code: 'alumno.barrioDomicilio.label', default: 'Barrio Domicilio')}" />
                        
                            <g:sortableColumn property="barrioLaboral" title="${message(code: 'alumno.barrioLaboral.label', default: 'Barrio Laboral')}" />
                        
                            <g:sortableColumn property="calleDomicilio" title="${message(code: 'alumno.calleDomicilio.label', default: 'Calle Domicilio')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${alumnoInstanceList}" status="i" var="alumnoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${alumnoInstance.id}">${fieldValue(bean: alumnoInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: alumnoInstance, field: "anioEgreso")}</td>
                        
                            <td>${fieldValue(bean: alumnoInstance, field: "apellidoNombre")}</td>
                        
                            <td>${fieldValue(bean: alumnoInstance, field: "barrioDomicilio")}</td>
                        
                            <td>${fieldValue(bean: alumnoInstance, field: "barrioLaboral")}</td>
                        
                            <td>${fieldValue(bean: alumnoInstance, field: "calleDomicilio")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${alumnoInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
