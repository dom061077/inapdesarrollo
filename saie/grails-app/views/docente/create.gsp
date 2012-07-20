

<%@ page import="com.educacion.academico.Docente" %>
<%@ page import="com.educacion.geografico.Pais"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'docente.label', default: 'Docente')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: "js/jquery",file: "jquery.extend.ui.js")}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
                $('#tipoDocumentoId').combobox();
                $('#sexoId').combobox();

                $('#fechaNacimientoId' ).datepicker({changeYear:true});
        		$('#localidadDomicilioId').lookupfield({source:'<%out << createLink(controller:"localidad",action:"listsearchjson")%>',
 				 title:'Localidades'
				,colNames:['Id','Nombre']
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true} ]
 				,hiddenid:'localidadDomicilioIdId'
 				,descid:'localidadDomicilioId' 
 				,hiddenfield:'id' 
 				,descfield:['nombre']});

//----------------------------------
                $('#provinciaNacimientoId').lookupfield({source:'<%out << createLink(controller: "provincia",action:"listsearchjson")%>',
                         title:'Provincias'
                        ,colNames:['Id','Nombre']
                        ,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false}
                        ,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}]
                        ,hiddenid:'provinciaNacimientoIdId'
                        ,descid:'provinciaNacimientoId'
                        ,hiddenfield:'id'
                        ,descfield:['nombre']});

        //----------------------------------

        	});
		</script>


    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${docenteInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${docenteInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            		<div class="append-bottom">
                            <fieldset>
                                <legend>Datos Personales</legend>
                                <g:hasErrors bean="${docenteInstance}" field="tipoDocumento">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3">
                                    <label for="tipoDocumento"><g:message code="docente.tipoDocumento.label" default="Tipo Documento" /></label>
                                </div>
                                <div class="span-5">
                                    <g:select id="tipoDocumentoId" class="ui-widget ui-corner-all ui-widget-content" name="tipoDocumento" from="${com.educacion.enums.TipoDocumentoEnum?.values()}" keys="${com.educacion.enums.TipoDocumentoEnum?.values()*.name()}" value="${docenteInstance?.tipoDocumento?.name()}"  optionValue="name"/>
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="tipoDocumento">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="tipoDocumento"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>


                                <g:hasErrors bean="${docenteInstance}" field="numeroDocumento">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3 spanlabel">
                                    <label for="numeroDocumento"><g:message code="docente.numeroDocumento.label" default="Numero Documento" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="numeroDocumentoId" class="ui-widget ui-corner-all ui-widget-content" name="numeroDocumento" value="${fieldValue(bean: docenteInstance, field: 'numeroDocumento')}" />
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="numeroDocumento">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="numeroDocumento"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>


                                <g:hasErrors bean="${docenteInstance}" field="apellido">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3 spanlabel">
                                    <label for="apellido"><g:message code="docente.apellido.label" default="Apellido" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="apellidoId" name="apellido" class="ui-widget ui-corner-all ui-widget-content" value="${docenteInstance?.apellido}" />
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="apellido">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="apellido"/>
                                    </div>
                               </g:hasErrors>
                               <div class="clear"></div>

                                <g:hasErrors bean="${docenteInstance}" field="nombre">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3 spanlabel">
                                    <label for="nombre"><g:message code="docente.nombre.label" default="Nombre" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="nombreId" name="nombre" class="ui-widget ui-corner-all ui-widget-content" value="${docenteInstance?.nombre}" />
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="nombre">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="nombre"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>



                                <g:hasErrors bean="${docenteInstance}" field="fechaNacimiento">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3 spanlabel">
                                    <label for="fechaNacimiento"><g:message code="docente.fechaNacimiento.label" default="Fecha Nacimiento" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="fechaNacimientoId" class="ui-widget ui-corner-all ui-widget-content" name="fechaNacimiento" value="${fieldValue(bean: docenteInstance, field: 'fechaNacimiento')}" />
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="fechaNacimiento">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="fechaNacimiento"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>


                                <g:hasErrors bean="${docenteInstance}" field="sexo">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3">
                                    <label for="sexo"><g:message code="docente.sexo.label" default="Sexo" /></label>
                                </div>
                                <div class="span-5">
                                    <g:select id="sexoId" class="ui-widget ui-corner-all ui-widget-content" name="sexo" from="${com.educacion.enums.SexoEnum?.values()}" keys="${com.educacion.enums.SexoEnum?.values()*.name()}" value="${docenteInstance?.sexo?.name()}"  optionValue="name"/>
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="sexo">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="sexo"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>


                            </fieldset>

                            <fieldset>
                                <legend>Datos Nacimiento</legend>


                                <div class="append-bottom">
                                    <g:hasErrors bean="${docenteInstance} field="provinciaNacimiento">
                                        <div class="ui-state-error ui-corner-all append-bottom">
                                    </g:hasErrors>
                                    <g:hasErrors bean="${docenteInstance}" field="provinciaNacimiento">
                                        <div class="ui-state-error ui-corner-all append-bottom">
                                    </g:hasErrors>
                                    <div class="span-3">
                                        <label for="paisNacimiento"><g:message code="docente.paisNacimiento.label" default="País Nacimiento" /></label>
                                    </div>
                                    <div class="span-5">
                                        <g:textField class="ui-widget ui-corner-all ui-widget-content"
                                                  id="paisNacimientoId" name="paisNacimiento"  value="${docenteInstance?.provinciaNacimiento?.pais?.id}" />
                                        <g:hiddenField id="provinciaNacimientoIdId" name="provinciaNacimiento.id" value="${provinciaNacimiento?.id}" />
                                    </div>
                                    <g:hasErrors bean="${docenteInstance}" field="provinciaNacimiento">
                                        <g:renderErrors bean="${docenteInstance}" as="list" field="provinciaNacimiento"/>
                                        </div>
                                    </g:hasErrors>
                                    <div class="clear"></div>
                                </div>


                                <g:hasErrors bean="${docenteInstance}" field="provinciaNacimiento">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>
                                <div class="span-3">
                                    <label for="provinciaNacimiento.id"><g:message code="docente.provinciaNacimiento.label" default="Provincia Nacimiento" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField class="ui-widget ui-corner-all ui-widget-content" id="provinciaNacimientoId" name="provinciaNacimiento.id"
                                                    value="${docenteInstance?.provinciaNacimiento?.id}" />
                                    <g:hiddenField id="provinciaNacimientoIdId" name="provinciaNacimiento.id" value="${provinciaNacimiento?.id}" />
                                </div>
                                <g:hasErrors bean="${docenteInstance}" field="provinciaNacimiento">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="provinciaNacimiento"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>

                            </fieldset>

                            <fieldset>
                                <legend>Domicilio</legend>
                                <g:hasErrors bean="${docenteInstance}" field="calleDomicilio">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3 spanlabel">
                                    <label for="calleDomicilio"><g:message code="docente.calleDomicilio.label" default="Calle Domicilio" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="calleDomicilioId" name="calleDomicilio" class="ui-widget ui-corner-all ui-widget-content" value="${docenteInstance?.calleDomicilio}" />
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="calleDomicilio">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="calleDomicilio"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>


                                <g:hasErrors bean="${docenteInstance}" field="numeroDomicilio">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3 spanlabel">
                                    <label for="numeroDomicilio"><g:message code="docente.numeroDomicilio.label" default="Numero Domicilio" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="numeroDomicilioId" name="numeroDomicilio" class="ui-widget ui-corner-all ui-widget-content" value="${docenteInstance?.numeroDomicilio}" />
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="numeroDomicilio">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="numeroDomicilio"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>


                                <g:hasErrors bean="${docenteInstance}" field="barrioDomicilio">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3 spanlabel">
                                    <label for="barrioDomicilio"><g:message code="docente.barrioDomicilio.label" default="Barrio Domicilio" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="barrioDomicilioId" name="barrioDomicilio" class="ui-widget ui-corner-all ui-widget-content" value="${docenteInstance?.barrioDomicilio}" />
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="barrioDomicilio">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="barrioDomicilio"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>

                                <div class="append-bottom">
                                    <g:hasErrors bean="${docenteInstance}" field="localidadDomicilio">
                                        <div class="ui-state-error ui-corner-all append-bottom">
                                    </g:hasErrors>
                                    <div class="span-3">
                                        <label for="paisDomicilio"><g:message code="docente.paisDomicilio.label" default="Provincia Domicilio" /></label>
                                    </div>
                                    <div class="span-5">
                                        <g:textField class="ui-widget ui-corner-all ui-widget-content" id="paisDomicilioId"
                                                  name="paisDomicilio"  value="${docenteInstance?.localidadDomicilio?.provincia?.pais?.id}" />
                                        <g:hiddenField id="localidadDomicilioIdId" name="localidadDomicilio.id" value="${localidadDomicilio?.id}" />
                                    </div>
                                    <g:hasErrors bean="${docenteInstance}" field="localidadDomicilio">
                                        <g:renderErrors bean="${docenteInstance}" as="list" field="localidadDomicilio"/>
                                        </div>
                                    </g:hasErrors>
                                    <div class="clear"></div>

                                </div>


                                <div class="append-bottom">
                                    <g:hasErrors bean="${docenteInstance}" field="localidadDomicilio">
                                        <div class="ui-state-error ui-corner-all append-bottom">
                                    </g:hasErrors>
                                    <div class="span-3">
                                        <label for="provinciaDomicilio"><g:message code="docente.provinciaDomicilio.label" default="Provincia Domicilio" /></label>
                                    </div>
                                    <div class="span-5">
                                        <g:textField class="ui-widget ui-corner-all ui-widget-content" id="provinciaDomicilioId"
                                                  name="provinciaDomicilio"  value="${docenteInstance?.localidadDomicilio?.provincia?.id}" />
                                        <g:hiddenField id="localidadDomicilioIdId" name="localidadDomicilio.id" value="${localidadDomicilio?.id}" />
                                    </div>
                                    <g:hasErrors bean="${docenteInstance}" field="localidadDomicilio">
                                        <g:renderErrors bean="${docenteInstance}" as="list" field="localidadDomicilio"/>
                                        </div>
                                    </g:hasErrors>
                                    <div class="clear"></div>

                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="localidadDomicilio">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>
                                <div class="span-3">
                                    <label for="localidad.id"><g:message code="docente.localidadDomicilio.label" default="Localidad Domicilio" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField class="ui-widget ui-corner-all ui-widget-content" id="localidadDomicilioId" name="localidad.id"  value="${docenteInstance?.localidadDomicilio?.id}" />
                                    <g:hiddenField id="localidadDomicilioIdId" name="localidadDomicilio.id" value="${localidadDomicilio?.id}" />
                                </div>
                                <g:hasErrors bean="${docenteInstance}" field="localidadDomicilio">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="localidadDomicilio"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>


                                <g:hasErrors bean="${docenteInstance}" field="codigoPostalDomicilio">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3 spanlabel">
                                    <label for="codigoPostalDomicilio"><g:message code="docente.codigoPostalDomicilio.label" default="Codigo Postal Domicilio" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="codigoPostalDomicilioId" name="codigoPostalDomicilio" class="ui-widget ui-corner-all ui-widget-content" value="${docenteInstance?.codigoPostalDomicilio}" />
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="codigoPostalDomicilio">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="codigoPostalDomicilio"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>
                            </fieldset>

                            <fieldset>
                                <legend>Datos de Contacto</legend>
                                <g:hasErrors bean="${docenteInstance}" field="telefonoParticular">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>
                                <div class="span-3 spanlabel">
                                    <label for="telefonoParticular"><g:message code="docente.telefonoParticular.label" default="Telefono Particular" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="telefonoParticularId" name="telefonoParticular" class="ui-widget ui-corner-all ui-widget-content" value="${docenteInstance?.telefonoParticular}" />
                                </div>
                                <g:hasErrors bean="${docenteInstance}" field="telefonoParticular">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="telefonoParticular"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>

                                <g:hasErrors bean="${docenteInstance}" field="telefonoCelular">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>
                                <div class="span-3 spanlabel">
                                    <label for="telefonoCelular"><g:message code="docente.telefonoCelular.label" default="Telefono Celular" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="telefonoCelularId" name="telefonoCelular" class="ui-widget ui-corner-all ui-widget-content" value="${docenteInstance?.telefonoCelular}" />
                                </div>
                                <g:hasErrors bean="${docenteInstance}" field="telefonoCelular">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="telefonoCelular"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>

                                <g:hasErrors bean="${docenteInstance}" field="email">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3 spanlabel">
                                    <label for="email"><g:message code="docente.email.label" default="Email" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="emailId" name="email" class="ui-widget ui-corner-all ui-widget-content" value="${docenteInstance?.email}" />
                                </div>

                                <g:hasErrors bean="${docenteInstance}" field="email">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="email"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>


                                <g:hasErrors bean="${docenteInstance}" field="telefonoMensaje">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3 spanlabel">
                                    <label for="telefonoMensaje"><g:message code="docente.telefonoMensaje.label" default="Telefono Mensaje" /></label>
                                </div>
                                <div class="span-5">
                                    <g:textField id="telefonoMensajeId" name="telefonoMensaje" class="ui-widget ui-corner-all ui-widget-content" value="${docenteInstance?.telefonoMensaje}" />
                                </div>
                                <g:hasErrors bean="${docenteInstance}" field="telefonoMensaje">
                                    <g:renderErrors bean="${docenteInstance}" as="list" field="telefonoMensaje"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>

                            </fieldset>

				</div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
