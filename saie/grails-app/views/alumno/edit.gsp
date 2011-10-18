

<%@ page import="com.educacion.alumno.Alumno" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'alumno.label', default: 'Alumno')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${alumnoInstance}">
            <div class="errors">
                <g:renderErrors bean="${alumnoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${alumnoInstance?.id}" />
                <g:hiddenField name="version" value="${alumnoInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="anioEgreso"><g:message code="alumno.anioEgreso.label" default="Anio Egreso" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'anioEgreso', 'errors')}">
                                    <g:textField id="anioEgresoId" class="ui-widget ui-corner-all ui-widget-content" name="anioEgreso" value="${fieldValue(bean: alumnoInstance, field: 'anioEgreso')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="apellidoNombre"><g:message code="alumno.apellidoNombre.label" default="Apellido Nombre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'apellidoNombre', 'errors')}">
                                    <g:textField name="apellidoNombreId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.apellidoNombre}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="barrioDomicilio"><g:message code="alumno.barrioDomicilio.label" default="Barrio Domicilio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'barrioDomicilio', 'errors')}">
                                    <g:textField name="barrioDomicilioId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.barrioDomicilio}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="barrioLaboral"><g:message code="alumno.barrioLaboral.label" default="Barrio Laboral" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'barrioLaboral', 'errors')}">
                                    <g:textField name="barrioLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.barrioLaboral}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="calleDomicilio"><g:message code="alumno.calleDomicilio.label" default="Calle Domicilio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'calleDomicilio', 'errors')}">
                                    <g:textField name="calleDomicilioId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.calleDomicilio}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="calleLaboral"><g:message code="alumno.calleLaboral.label" default="Calle Laboral" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'calleLaboral', 'errors')}">
                                    <g:textField name="calleLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.calleLaboral}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="email"><g:message code="alumno.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'email', 'errors')}">
                                    <g:textField name="emailId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="establecimientoProcedencia"><g:message code="alumno.establecimientoProcedencia.label" default="Establecimiento Procedencia" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'establecimientoProcedencia', 'errors')}">
                                    <g:textField name="establecimientoProcedenciaId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.establecimientoProcedencia}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fechaNacimiento"><g:message code="alumno.fechaNacimiento.label" default="Fecha Nacimiento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'fechaNacimiento', 'errors')}">
                                    <g:textField id="fechaNacimientoId" class="ui-widget ui-corner-all ui-widget-content" name="fechaNacimiento" value="${fieldValue(bean: alumnoInstance, field: 'fechaNacimiento')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="legajo"><g:message code="alumno.legajo.label" default="Legajo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'legajo', 'errors')}">
                                    <g:textField name="legajoId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.legajo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="localidadDomicilio"><g:message code="alumno.localidadDomicilio.label" default="Localidad Domicilio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'localidadDomicilio', 'errors')}">
                                    <g:textField class="ui-widget ui-corner-all ui-widget-content" id="localidadDomicilioId" name="localidadDomicilioDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="localidadDomicilioIdId" name="localidadDomicilio.id" value="$localidadDomicilio?.id" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="localidadLaboral"><g:message code="alumno.localidadLaboral.label" default="Localidad Laboral" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'localidadLaboral', 'errors')}">
                                    <g:textField class="ui-widget ui-corner-all ui-widget-content" id="localidadLaboralId" name="localidadLaboralDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="localidadLaboralIdId" name="localidadLaboral.id" value="$localidadLaboral?.id" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="localidadNac"><g:message code="alumno.localidadNac.label" default="Localidad Nac" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'localidadNac', 'errors')}">
                                    <g:textField class="ui-widget ui-corner-all ui-widget-content" id="localidadNacId" name="localidadNacDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="localidadNacIdId" name="localidadNac.id" value="$localidadNac?.id" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lugarLaboral"><g:message code="alumno.lugarLaboral.label" default="Lugar Laboral" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'lugarLaboral', 'errors')}">
                                    <g:textField name="lugarLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.lugarLaboral}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="numeroDocumento"><g:message code="alumno.numeroDocumento.label" default="Numero Documento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'numeroDocumento', 'errors')}">
                                    <g:textField id="numeroDocumentoId" class="ui-widget ui-corner-all ui-widget-content" name="numeroDocumento" value="${fieldValue(bean: alumnoInstance, field: 'numeroDocumento')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="numeroDomicilio"><g:message code="alumno.numeroDomicilio.label" default="Numero Domicilio" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'numeroDomicilio', 'errors')}">
                                    <g:textField name="numeroDomicilioId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.numeroDomicilio}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="numeroLaboral"><g:message code="alumno.numeroLaboral.label" default="Numero Laboral" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'numeroLaboral', 'errors')}">
                                    <g:textField name="numeroLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.numeroLaboral}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="sexo"><g:message code="alumno.sexo.label" default="Sexo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'sexo', 'errors')}">
                                    <g:select name="sexo" from="${com.educacion.enums.SexoEnum?.values()}" keys="${com.educacion.enums.SexoEnum?.values()*.name()}" value="${alumnoInstance?.org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1ea7d34[name=sexo,type=class com.educacion.enums.SexoEnum,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>]}"  optionValue="sexo" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="situacionAcademicas"><g:message code="alumno.situacionAcademicas.label" default="Situacion Academicas" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'situacionAcademicas', 'errors')}">
                                    <g:select name="situacionAcademicas" from="${com.educacion.enums.SituacionAcademicaEnum?.values()}" keys="${com.educacion.enums.SituacionAcademicaEnum?.values()*.name()}" value="${alumnoInstance?.org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@1c1e1e7[name=situacionAcademicas,type=class com.educacion.enums.SituacionAcademicaEnum,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>]}"  optionValue="situacionAcademicas" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="telefenoAlternativo"><g:message code="alumno.telefenoAlternativo.label" default="Telefeno Alternativo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'telefenoAlternativo', 'errors')}">
                                    <g:textField name="telefenoAlternativoId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefenoAlternativo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="telefonoCelular"><g:message code="alumno.telefonoCelular.label" default="Telefono Celular" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'telefonoCelular', 'errors')}">
                                    <g:textField name="telefonoCelularId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoCelular}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="telefonoLaboral"><g:message code="alumno.telefonoLaboral.label" default="Telefono Laboral" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'telefonoLaboral', 'errors')}">
                                    <g:textField name="telefonoLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoLaboral}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="telefonoParticular"><g:message code="alumno.telefonoParticular.label" default="Telefono Particular" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'telefonoParticular', 'errors')}">
                                    <g:textField name="telefonoParticularId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoParticular}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tipoDocumento"><g:message code="alumno.tipoDocumento.label" default="Tipo Documento" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'tipoDocumento', 'errors')}">
                                    <g:select name="tipoDocumento" from="${com.educacion.enums.TipoDocumentoEnum?.values()}" keys="${com.educacion.enums.TipoDocumentoEnum?.values()*.name()}" value="${alumnoInstance?.org.codehaus.groovy.grails.commons.DefaultGrailsDomainClassProperty@6286e3[name=tipoDocumento,type=class com.educacion.enums.TipoDocumentoEnum,persistent=true,optional=false,association=false,bidirectional=false,association-type=<null>]}"  optionValue="tipoDocumento" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="titulo"><g:message code="alumno.titulo.label" default="Titulo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: alumnoInstance, field: 'titulo', 'errors')}">
                                    <g:textField name="tituloId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.titulo}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
