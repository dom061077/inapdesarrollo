

<%@ page import="com.educacion.academico.Carrera" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'carrera.label', default: 'Carrera')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/script/academico',file:'createcarrera.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	var locrequisito = '<%out << createLink(controller:"requisito",action:"listjson")%>';
        	$(document).ready(function(){
        
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
            <div class="ui-state-highlight ui-corner-all">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${carreraInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${carreraInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form onSubmit="initsubmit();return true;" action="save" >
            		<div class="span-18 append-bottom">	
							<g:hasErrors bean="${carreraInstance}" field="campoOcupacional">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="campoOcupacional"><g:message code="carrera.campoOcupacional.label" default="Campo Ocupacional" /></label>
							</div>
							<div class="span-5">
								<g:textField id="campoOcupacionalId" name="campoOcupacional" class="ui-widget ui-corner-all ui-widget-content" value="${carreraInstance?.campoOcupacional}" />
							</div>
										
							<g:hasErrors bean="${carreraInstance}" field="campoOcupacional">
								<g:renderErrors bean="${carreraInstance}" as="list" field="campoOcupacional"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${carreraInstance}" field="denominacion">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="denominacion"><g:message code="carrera.denominacion.label" default="Denominacion" /></label>
							</div>
							<div class="span-5">
								<g:textField id="denominacionId" name="denominacion" class="ui-widget ui-corner-all ui-widget-content" value="${carreraInstance?.denominacion}" />
							</div>
										
							<g:hasErrors bean="${carreraInstance}" field="denominacion">
								<g:renderErrors bean="${carreraInstance}" as="list" field="denominacion"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${carreraInstance}" field="duracion">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="duracion"><g:message code="carrera.duracion.label" default="Duracion" /></label>
							</div>
							<div class="span-5">
								<g:textField id="duracionId" class="ui-widget ui-corner-all ui-widget-content" name="duracion" value="${fieldValue(bean: carreraInstance, field: 'duracion')}" />
							</div>
										
							<g:hasErrors bean="${carreraInstance}" field="duracion">
								<g:renderErrors bean="${carreraInstance}" as="list" field="duracion"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${carreraInstance}" field="modalidadFormacion">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="modalidadFormacion"><g:message code="carrera.modalidadFormacion.label" default="Modalidad Formacion" /></label>
							</div>
							<div class="span-5">
								<g:select id="modalidadFormacionId" class="ui-widget ui-corner-all ui-widget-content" name="modalidadFormacion" from="${com.educacion.enums.ModalidadFormacionEnum?.values()}" keys="${com.educacion.enums.ModalidadFormacionEnum?.values()*.name()}" value="${carreraInstance?.modalidadFormacion?.name()}"  optionValue="name"/>
							</div>
										
							<g:hasErrors bean="${carreraInstance}" field="modalidadFormacion">
								<g:renderErrors bean="${carreraInstance}" as="list" field="modalidadFormacion"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${carreraInstance}" field="perfilEgresado">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="perfilEgresado"><g:message code="carrera.perfilEgresado.label" default="Perfil Egresado" /></label>
							</div>
							<div class="span-5">
								<g:textField id="perfilEgresadoId" name="perfilEgresado" class="ui-widget ui-corner-all ui-widget-content" value="${carreraInstance?.perfilEgresado}" />
							</div>
										
							<g:hasErrors bean="${carreraInstance}" field="perfilEgresado">
								<g:renderErrors bean="${carreraInstance}" as="list" field="perfilEgresado"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${carreraInstance}" field="titulo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="titulo"><g:message code="carrera.titulo.label" default="Titulo" /></label>
							</div>
							<div class="span-5">
								<g:textField id="tituloId" name="titulo" class="ui-widget ui-corner-all ui-widget-content" value="${carreraInstance?.titulo}" />
							</div>
										
							<g:hasErrors bean="${carreraInstance}" field="titulo">
								<g:renderErrors bean="${carreraInstance}" as="list" field="titulo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${carreraInstance}" field="validezTitulo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="validezTitulo"><g:message code="carrera.validezTitulo.label" default="Validez Titulo" /></label>
							</div>
							<div class="span-5">
								<g:textField id="validezTituloId" name="validezTitulo" class="ui-widget ui-corner-all ui-widget-content" value="${carreraInstance?.validezTitulo}" />
							</div>
										
							<g:hasErrors bean="${carreraInstance}" field="validezTitulo">
								<g:renderErrors bean="${carreraInstance}" as="list" field="validezTitulo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
							   <fieldset>
							   		<legend>Requisitos</legend>
							   		<g:hiddenField id="requisitosSerializedId" name="requisitosSerialized" value="${requisitosSerialized}"/>
							   		<table id="listRequisitosId"></table>
							   		<div id="pagerListRequisitosId"></div>	
							   </fieldset>	
							<div class="clear"></div>										
						   
                        
				</div>
				                        
                <div class="span-18">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
            
            <div style="display:none" id="busquedaRequisitoDialogId">
	            <table id="tablaBusquedaRequisitoId"></table>
	            <div id="pagerBusquedaRequisitoId"></div>
            </div>
        </div>
    </body>
</html>
