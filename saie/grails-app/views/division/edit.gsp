

<%@ page import="com.educacion.academico.Division" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'division.label', default: 'Division')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">

        </script>
        
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
            <div class="ui-state-highlight ui-corner-all append-bottom"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${divisionInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${divisionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
            	<div class="append-bottom">
                <g:hiddenField name="id" value="${divisionInstance?.id}" />
                <g:hiddenField name="version" value="${divisionInstance?.version}" />
		                
						<g:hasErrors bean="${divisionInstance}" field="descripcion">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="descripcion"><g:message code="division.descripcion.label" default="Descripcion" /></label>
						</div>
						<div class="span-5">
							<g:textField id="descripcionId" name="descripcion" class="ui-widget ui-corner-all ui-widget-content" maxlength="36" value="${divisionInstance?.descripcion}" />
						</div>
									
						<g:hasErrors bean="${divisionInstance}" field="descripcion">
							<g:renderErrors bean="${divisionInstance}" as="list" field="descripcion"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${divisionInstance}" field="letra">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="letra"><g:message code="division.letra.label" default="Letra" /></label>
						</div>
						<div class="span-5">
							<g:textField id="letraId" name="letra" class="ui-widget ui-corner-all ui-widget-content" maxlength="1" value="${divisionInstance?.letra}" />
						</div>
									
						<g:hasErrors bean="${divisionInstance}" field="letra">
							<g:renderErrors bean="${divisionInstance}" as="list" field="letra"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${divisionInstance}" field="cupoComision">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="cupoComision"><g:message code="division.cupoComision.label" default="Cupo Comision" /></label>
						</div>
						<div class="span-5">
							<g:textField id="cupoComisionId" class="ui-widget ui-corner-all ui-widget-content" name="cupoComision" value="${fieldValue(bean: divisionInstance, field: 'cupoComision')}" />
						</div>
									
						<g:hasErrors bean="${divisionInstance}" field="cupoComision">
							<g:renderErrors bean="${divisionInstance}" as="list" field="cupoComision"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${divisionInstance}" field="descripcionTurno">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="descripcionTurno"><g:message code="division.descripcionTurno.label" default="Descripcion Turno" /></label>
						</div>
						<div class="span-5">
							<g:textField id="descripcionTurnoId" name="descripcionTurno" class="ui-widget ui-corner-all ui-widget-content" value="${divisionInstance?.descripcionTurno}" />
						</div>
									
						<g:hasErrors bean="${divisionInstance}" field="descripcionTurno">
							<g:renderErrors bean="${divisionInstance}" as="list" field="descripcionTurno"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		            
						<g:hasErrors bean="${divisionInstance}" field="turno">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="turno"><g:message code="division.turno.label" default="Turno" /></label>
						</div>
						<div class="span-5">
							<g:textField id="turnoId" name="turno" class="ui-widget ui-corner-all ui-widget-content" value="${divisionInstance?.turno}" />
						</div>
									
						<g:hasErrors bean="${divisionInstance}" field="turno">
							<g:renderErrors bean="${divisionInstance}" as="list" field="turno"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
