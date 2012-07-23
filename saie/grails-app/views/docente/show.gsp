
<%@ page import="com.educacion.academico.Docente" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'docente.label', default: 'Docente')}" />
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
                <fieldset>
                      <legend>Datos Personales</legend>
                            <div class="span-4 spanlabel"><g:message code="docente.id.label" default="Id" /></div>
                            <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "id")}</div>
                            <div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="docente.tipoDocumento.label" default="Tipo Documento" /></div>
                            <div class="span-4 spanlabel">${docenteInstance?.tipoDocumento?.name?.encodeAsHTML()}</div>
                            <div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="docente.numeroDocumento.label" default="Numero Documento" /></div>
                            <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "numeroDocumento")}</div>
                            <div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="docente.apellido.label" default="Apellido" /></div>
                            <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "apellido")}</div>
                            <div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="docente.nombre.label" default="Nombre" /></div>
                            <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "nombre")}</div>
                            <div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="docente.fechaNacimiento.label" default="Fecha Nacimiento" /></div>
                            <div class="span-4 spanlabel"><g:formatDate date="${docenteInstance?.fechaNacimiento}" format="dd/MM/yyyy" /></div>
                            <div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="docente.sexo.label" default="Sexo" /></div>
                            <div class="span-4 spanlabel">${docenteInstance?.sexo?.name?.encodeAsHTML()}</div>
                            <div class="clear"></div>
                </fieldset>

                <fieldset>
                    <legend>Datos Nacimiento</legend>
                            <div class="span-4 spanlabel"><g:message code="docente.paisNacimiento.label" default="Pais Nacimiento" /></div>
                            <div class="span-4 spanlabel">${docenteInstance?.provinciaNacimiento?.pais?.nombre?.encodeAsHTML()}</div>
                            <div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="docente.provinciaNacimiento.label" default="Provincia Nacimiento" /></div>
                            <div class="span-4 spanlabel">${docenteInstance?.provinciaNacimiento?.nombre?.encodeAsHTML()}</div>
                            <div class="clear"></div>

                </fieldset>

                <fieldset>
                    <legend>Domicilio</legend>
                    <div class="span-4 spanlabel"><g:message code="docente.paisDomicilio.label" default="País Domicilio" /></div>
                    <div class="span-4 spanlabel">${docenteInstance?.localidadDomicilio?.provincia?.pais?.nombre?.encodeAsHTML()}</div>
                    <div class="clear"></div>

                    <div class="span-4 spanlabel"><g:message code="docente.provinciaDomicilio.label" default="Localidad Domicilio" /></div>
                    <div class="span-4 spanlabel">${docenteInstance?.localidadDomicilio?.provincia?.nombre?.encodeAsHTML()}</div>
                    <div class="clear"></div>

                    <div class="span-4 spanlabel"><g:message code="docente.localidadDomicilio.label" default="Localidad Domicilio" /></div>
                    <div class="span-4 spanlabel">${docenteInstance?.localidadDomicilio?.nombre?.encodeAsHTML()}</div>
                    <div class="clear"></div>

                    <div class="span-4 spanlabel"><g:message code="docente.codigoPostalDomicilio.label" default="Codigo Postal Domicilio" /></div>
                    <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "codigoPostalDomicilio")}</div>
                    <div class="clear"></div>

                    <div class="span-4 spanlabel"><g:message code="docente.barrioDomicilio.label" default="Barrio Domicilio" /></div>
                    <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "barrioDomicilio")}</div>
                    <div class="clear"></div>

                    <div class="span-4 spanlabel"><g:message code="docente.calleDomicilio.label" default="Calle Domicilio" /></div>
                    <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "calleDomicilio")}</div>
                    <div class="clear"></div>

                    <div class="span-4 spanlabel"><g:message code="docente.numeroDomicilio.label" default="Numero Domicilio" /></div>
                    <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "numeroDomicilio")}</div>
                    <div class="clear"></div>
                </fieldset>

                <fieldset>
                    <legend>Datos de Contacto</legend>

                            <div class="span-4 spanlabel"><g:message code="docente.email.label" default="Email" /></div>
                            <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "email")}</div>
							<div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="docente.telefonoCelular.label" default="Telefono Celular" /></div>
                            <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "telefonoCelular")}</div>
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="docente.telefonoMensaje.label" default="Telefono Mensaje" /></div>
                            <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "telefonoMensaje")}</div>
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="docente.telefonoParticular.label" default="Telefono Particular" /></div>
                            <div class="span-4 spanlabel">${fieldValue(bean: docenteInstance, field: "telefonoParticular")}</div>
							<div class="clear"></div>
                </fieldset>
                    
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${docenteInstance?.id}" />
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
