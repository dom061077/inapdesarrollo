

<%@ page import="com.educacion.academico.Preinscripcion"
  @ page import="com.educacion.academico.Carrera"	
 %>
<html>
    <head>
<!--        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />-->
        <!-- meta name="layout" content="main" /-->
        <g:set var="entityName" value="${message(code: 'preinscripcion.label', default: 'Preinscripcion')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery-1.6.2.min.js')}"></script>        
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.cascade.js')}"></script>        
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.cascade.ext.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.templating.js')}"></script>        
        
 		
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
            <g:hasErrors bean="${preinscripcionInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${preinscripcionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            		<div class="append-bottom">	
                        
							<g:hasErrors bean="${preinscripcionInstance}" field="alumno">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="alumno"><g:message code="preinscripcion.alumno.label" default="Alumno" /></label>
							</div>
							<div class="span-7">
								<g:textField class="ui-widget ui-corner-all ui-widget-content largeinput" id="alumnoId" name="alumnoDesc"  value="${preinscripcionInstance?.alumno?.apellidoNombre}" /> 
 								<g:hiddenField id="alumnoIdId" name="alumno.id" value="${alumno?.id}" />
							</div>
										
							<g:hasErrors bean="${preinscripcionInstance}" field="alumno">
								<g:renderErrors bean="${preinscripcionInstance}" as="list" field="alumno"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
							<g:hasErrors bean="${preinscripcionInstance}" field="anioLectivo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="carrera"><g:message code="preinscripcion.carrera.label" default="Carrera" /></label>
							</div>
							<div class="span-5">
								<g:select name="carrera" id="carreraId" from="${Carrera.list()}" optionKey="id" optionValue="denominacion" ></g:select>
							</div>
										
  						    <div class="clear"></div>

							
							<div class="span-3 spanlabel">
								<label for="anioLectivo"><g:message code="preinscripcion.anioLectivo.label" default="Anio Lectivo" /></label>
							</div>
							<div class="span-5">
								<select name="anioLectivo" id = "anioLectivoId"></select>
							</div>
										
							<g:hasErrors bean="${preinscripcionInstance}" field="anioLectivo">
								<g:renderErrors bean="${preinscripcionInstance}" as="list" field="anioLectivo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
							
<div>
		<label>Pais
			<select id="pais">
				<option value="AR">Argentina</option>
				<option value="ES">España</option>
				<option value="MX">Mexico</option>

			</select>
		</label>
		<label>Provincia
			<select id="provincia"></select>
		</label>
		<label>Ciudad
			<select id="ciudad"></select>
		</label>		
	</div>
																	
                        
				</div>                        
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
        
        
        
        <script type="text/javascript">
	        function commonTemplate(item) {
				return "<option value='" + item.Value + "'>" + item.Text + "</option>"; 
			};

			function commonMatch(selectedValue) {
				return this.When == selectedValue; 
			};			
			
        	$(document).ready(function(){
						//$('#fechaAltaId' ).datepicker($.datepicker.regional[ 'es' ]);
						$('#anioLectivoId').cascade('#carreraId',{						
							ajax: { 
								url: '<%out << createLink(controller:"carrera",action:"autocomplete")%>', 
															
						    },				
						    template: function(item) { 
							    return "<option value='" + item.value + "'>" + item.text + "</option>"; 
							    },
						    match: function(selectedValue) { 
							    return this.when == selectedValue; 
							    } 			
							    
						}); 

						$("#provincia").cascade("#pais",{
							ajax: {url: '<%out << g.resource(dir:"js/jquery",file:"datos-provincias.js")%>'
								},
							template: commonTemplate,
							match: commonMatch
						});
						
						$("#ciudad").cascade("#provincia",{
							ajax: {url: '<%out << g.resource(dir:"js/jquery",file:"datos-ciudades.js")%>'},
							template: commonTemplate,
							match: commonMatch
						});			
						
						//forzamos un evento de cambio para que se carge por primera vez
						$("#pais").change();						
	
        	});
		</script>
        
        
    </body>
</html>
