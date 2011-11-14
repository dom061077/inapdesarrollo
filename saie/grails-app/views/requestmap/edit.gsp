

<%@ page import="com.educacion.seguridad.Requestmap" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'requestmap.label', default: 'Requestmap')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
        
        	});
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
            <div class="ui-state-highlight ui-corner-all append-bottom">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${requestmapInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${requestmapInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
            	<div class="append-bottom">
                <g:hiddenField name="id" value="${requestmapInstance?.id}" />
                <g:hiddenField name="version" value="${requestmapInstance?.version}" />
		                
						<g:hasErrors bean="${requestmapInstance}" field="url">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="url"><g:message code="requestmap.url.label" default="Url" /></label>
						</div>
						<div class="span-5">
							<g:textField id="urlId" name="url" class="ui-widget ui-corner-all ui-widget-content" value="${requestmapInstance?.url}" />
						</div>
									
						<g:hasErrors bean="${requestmapInstance}" field="url">
							<g:renderErrors bean="${requestmapInstance}" as="list" field="url"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${requestmapInstance}" field="configAttribute">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="configAttribute"><g:message code="requestmap.configAttribute.label" default="Config Attribute" /></label>
						</div>
						<div class="span-5">
							<g:textField id="configAttributeId" name="configAttribute" class="ui-widget ui-corner-all ui-widget-content" value="${requestmapInstance?.configAttribute}" />
						</div>
									
						<g:hasErrors bean="${requestmapInstance}" field="configAttribute">
							<g:renderErrors bean="${requestmapInstance}" as="list" field="configAttribute"/>
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
