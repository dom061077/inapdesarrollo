

<%@ page import="com.educacion.academico.InscripcionMatricula" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula')}" />
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
            <g:hasErrors bean="${inscripcionMatriculaInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${inscripcionMatriculaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            		<div class="append-bottom">	
                        
							<g:hasErrors bean="${inscripcionMatriculaInstance}" field="alumno">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="alumno"><g:message code="inscripcionMatricula.alumno.label" default="Alumno" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="alumnoId" name="alumnoDesc"  value="colocar el valor del field descripcion" /> 
 								<g:hiddenField id="alumnoIdId" name="alumno.id" value="${alumno?.id}" />
							</div>
										
							<g:hasErrors bean="${inscripcionMatriculaInstance}" field="alumno">
								<g:renderErrors bean="${inscripcionMatriculaInstance}" as="list" field="alumno"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${inscripcionMatriculaInstance}" field="anioLectivo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="anioLectivo"><g:message code="inscripcionMatricula.anioLectivo.label" default="Anio Lectivo" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="anioLectivoId" name="anioLectivoDesc"  value="colocar el valor del field descripcion" /> 
 								<g:hiddenField id="anioLectivoIdId" name="anioLectivo.id" value="${anioLectivo?.id}" />
							</div>
										
							<g:hasErrors bean="${inscripcionMatriculaInstance}" field="anioLectivo">
								<g:renderErrors bean="${inscripcionMatriculaInstance}" as="list" field="anioLectivo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${inscripcionMatriculaInstance}" field="carrera">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="carrera"><g:message code="inscripcionMatricula.carrera.label" default="Carrera" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="colocar el valor del field descripcion" /> 
 								<g:hiddenField id="carreraIdId" name="carrera.id" value="${carrera?.id}" />
							</div>
										
							<g:hasErrors bean="${inscripcionMatriculaInstance}" field="carrera">
								<g:renderErrors bean="${inscripcionMatriculaInstance}" as="list" field="carrera"/>
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
