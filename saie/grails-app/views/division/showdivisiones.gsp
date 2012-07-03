
<%@ page import="com.educacion.academico.Division" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'division.label', default: 'Division')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
		<script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>        
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
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
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <div class="dialog">
                    
                            <div class="span-4 spanlabel"><g:message code="nivel.carrera.id.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: divisionInstance.nivel.carrera, field: "denominacion")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="nivel.label" default="Nivel" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: divisionInstance.nivel, field: "descripcion")}</div>
                            
							<div class="clear"></div>
							
                            <div class="span-4 spanlabel"><g:message code="nivel.label" default="Letra" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: divisionInstance, field: "letra")}</div>
                            
							<div class="clear"></div>
							
                            <div class="span-4 spanlabel"><g:message code="nivel.label" default="Turno" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: divisionInstance, field: "turno")}</div>
                            
							<div class="clear"></div>
							
                            <div class="span-4 spanlabel"><g:message code="nivel.label" default="Descripcion" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: divisionInstance, field: "descripcionTurno")}</div>
                            
							<div class="clear"></div>
							
                            <div class="span-4 spanlabel"><g:message code="nivel.label" default="Cupo" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: divisionInstance, field: "cupoComision")}</div>
                            
							<div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="nivel.label" default="Carrera" /></div>

                            <div class="span-4 spanlabel">${fieldValue(bean: divisionInstance.aula, field: "nombre")}</div>

                            <div class="clear"></div>

            </div>
        </div>
    </body>
</html>
