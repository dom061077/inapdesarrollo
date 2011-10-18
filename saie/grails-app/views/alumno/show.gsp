
<%@ page import="com.educacion.alumno.Alumno" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'alumno.label', default: 'Alumno')}" />
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
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.anioEgreso.label" default="Anio Egreso" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "anioEgreso")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.apellidoNombre.label" default="Apellido Nombre" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "apellidoNombre")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.barrioDomicilio.label" default="Barrio Domicilio" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "barrioDomicilio")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.barrioLaboral.label" default="Barrio Laboral" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "barrioLaboral")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.calleDomicilio.label" default="Calle Domicilio" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "calleDomicilio")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.calleLaboral.label" default="Calle Laboral" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "calleLaboral")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "email")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.establecimientoProcedencia.label" default="Establecimiento Procedencia" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "establecimientoProcedencia")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.fechaNacimiento.label" default="Fecha Nacimiento" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${alumnoInstance?.fechaNacimiento}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.legajo.label" default="Legajo" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "legajo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.localidadDomicilio.label" default="Localidad Domicilio" /></td>
                            
                            <td valign="top" class="value"><g:link controller="localidad" action="show" id="${alumnoInstance?.localidadDomicilio?.id}">${alumnoInstance?.localidadDomicilio?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.localidadLaboral.label" default="Localidad Laboral" /></td>
                            
                            <td valign="top" class="value"><g:link controller="localidad" action="show" id="${alumnoInstance?.localidadLaboral?.id}">${alumnoInstance?.localidadLaboral?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.localidadNac.label" default="Localidad Nac" /></td>
                            
                            <td valign="top" class="value"><g:link controller="localidad" action="show" id="${alumnoInstance?.localidadNac?.id}">${alumnoInstance?.localidadNac?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.lugarLaboral.label" default="Lugar Laboral" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "lugarLaboral")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.numeroDocumento.label" default="Numero Documento" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "numeroDocumento")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.numeroDomicilio.label" default="Numero Domicilio" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "numeroDomicilio")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.numeroLaboral.label" default="Numero Laboral" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "numeroLaboral")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.sexo.label" default="Sexo" /></td>
                            
                            <td valign="top" class="value">${alumnoInstance?.sexo?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.situacionAcademicas.label" default="Situacion Academicas" /></td>
                            
                            <td valign="top" class="value">${alumnoInstance?.situacionAcademicas?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.telefenoAlternativo.label" default="Telefeno Alternativo" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "telefenoAlternativo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.telefonoCelular.label" default="Telefono Celular" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "telefonoCelular")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.telefonoLaboral.label" default="Telefono Laboral" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "telefonoLaboral")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.telefonoParticular.label" default="Telefono Particular" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "telefonoParticular")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.tipoDocumento.label" default="Tipo Documento" /></td>
                            
                            <td valign="top" class="value">${alumnoInstance?.tipoDocumento?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="alumno.titulo.label" default="Titulo" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: alumnoInstance, field: "titulo")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${alumnoInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
