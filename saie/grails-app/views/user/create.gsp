

<%@ page import="com.educacion.seguridad.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
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
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            		<div class="append-bottom">	
                        
							<g:hasErrors bean="${userInstance}" field="username">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="username"><g:message code="user.username.label" default="Username" /></label>
							</div>
							<div class="span-5">
								<g:textField id="usernameId" name="username" class="ui-widget ui-corner-all ui-widget-content" value="${userInstance?.username}" />
							</div>
										
							<g:hasErrors bean="${userInstance}" field="username">
								<g:renderErrors bean="${userInstance}" as="list" field="username"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${userInstance}" field="password">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="password"><g:message code="user.password.label" default="Password" /></label>
							</div>
							<div class="span-5">
								<g:textField id="passwordId" name="password" class="ui-widget ui-corner-all ui-widget-content" value="${userInstance?.password}" />
							</div>
										
							<g:hasErrors bean="${userInstance}" field="password">
								<g:renderErrors bean="${userInstance}" as="list" field="password"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${userInstance}" field="accountExpired">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="accountExpired"><g:message code="user.accountExpired.label" default="Account Expired" /></label>
							</div>
							<div class="span-5">
								<g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />
							</div>
										
							<g:hasErrors bean="${userInstance}" field="accountExpired">
								<g:renderErrors bean="${userInstance}" as="list" field="accountExpired"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${userInstance}" field="accountLocked">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="accountLocked"><g:message code="user.accountLocked.label" default="Account Locked" /></label>
							</div>
							<div class="span-5">
								<g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />
							</div>
										
							<g:hasErrors bean="${userInstance}" field="accountLocked">
								<g:renderErrors bean="${userInstance}" as="list" field="accountLocked"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${userInstance}" field="enabled">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="enabled"><g:message code="user.enabled.label" default="Enabled" /></label>
							</div>
							<div class="span-5">
								<g:checkBox name="enabled" value="${userInstance?.enabled}" />
							</div>
										
							<g:hasErrors bean="${userInstance}" field="enabled">
								<g:renderErrors bean="${userInstance}" as="list" field="enabled"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${userInstance}" field="passwordExpired">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="passwordExpired"><g:message code="user.passwordExpired.label" default="Password Expired" /></label>
							</div>
							<div class="span-5">
								<g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
							</div>
										
							<g:hasErrors bean="${userInstance}" field="passwordExpired">
								<g:renderErrors bean="${userInstance}" as="list" field="passwordExpired"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
				</div>                        
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
