

<%@ page import="com.educacion.academico.Examen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'examen.label', default: 'Examen')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
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
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${examenInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${examenInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            	<div class="append-bottom">
                    <div class="span-4">
                        <label for="carreraDesc"><g:message code="examen.carrera.label"/></label>
                    </div>
                    <div class="span-4">
                        <g:textField name="carreraDesc" id="carreraId" value="${carreraDesc}" />
                        <g:hiddenField name="carreraId" id="carreraIdId"  value="${carreId}"/>
                    </div>
                    <div class="clear"></div>

                    <div class="span-4">
                        <label for="carreraDesc"><g:message code="examen.nivel.label"/></label>
                    </div>
                    <div class="span-4">
                        <g:textField name="nivelDesc" id="nivelId" value="${nivelDesc}" />
                        <g:hiddenField name="carreraId" id="nivelIdId"  value="${nivelId}"/>
                    </div>
                    <div class="clear"></div>


                    <div class="span-4">
                        <label for="materiaDesc"><g:message code="examen.materia.label"/></label>
                    </div>
                    <div class="span-4">
                        <g:textField name="materiaDesc" id="materiaIdId" value="${materiaDesc}" />
                        <g:hiddenField id="materiaIdId" name="materiaId" value="${materiaId}"/>
                    </div>
                    <div class="clear"></div>

                    <div class="span-4">
                        <label for="titulo"><g:message code="examen.titulo.label"/></label>
                    </div>
                    <div class="span-4">
                        <g:textField name="titulo" id="tituloId" value="${materiaDesc}" />
                        <g:hiddenField id="materiaIdId" name="materiaId" value="${materiaId}"/>
                    </div>
                    <div class="clear"></div>


				</div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
