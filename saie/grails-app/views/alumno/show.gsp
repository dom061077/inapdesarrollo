
<%@ page import="com.educacion.alumno.Alumno" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'alumno.label', default: 'Alumno')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
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
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
            	<div id="tabs" class="append-bottom">
                	<ul>
						<li><a href="#tabs-datosdelalumno">Datos del Alumno</a></li>
						<li><a href="#tabs-datostutorgarante">Datos del Tutor y Garante</a></li>
						<li><a href="#tabs-otrosdatos">Otros Datos</a></li>
                	</ul>
            	
					<div id="tabs-datosdelalumno">
                     <fieldset>
                     	<legend>Datos Personales</legend>
                      
							
							<div class="span-3 spanlabel">
								<label for="tipoDocumento"><g:message code="alumno.tipoDocumento.label" default="Tipo Documento" /></label>
							</div>
							<div class="span-5">
								${alumnoInstance?.tipoDocumento?.name}
							</div>
						   <div class="clear"></div>

							
							<div class="span-3 spanlabel">
								<label for="numeroDocumento"><g:message code="alumno.numeroDocumento.label" default="Numero Documento" /></label>
							</div>
							<div class="span-5">
								${fieldValue(bean: alumnoInstance, field: 'numeroDocumento')}"
							</div>
						   <div class="clear"></div>
						   
							<div class="span-3 spanlabel">
								<label for="apellidoNombre"><g:message code="alumno.apellidoNombre.label" default="Apellido Nombre" /></label>
							</div>
							<div class="span-5">
								${alumnoInstance?.apellidoNombre}"
							</div>
						   <div class="clear"></div>
						   
							<div class="span-3 spanlabel">
								<label for="sexo"><g:message code="alumno.sexo.label" default="Sexo" /></label>
							</div>
							<div class="span-5">
								${alumnoInstance?.sexo?.name()}
							</div>
						   <div class="clear"></div>
						   
							<g:hasErrors bean="${alumnoInstance}" field="fechaNacimiento">
								<div class="ui-state-error ui-corner-all">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="fechaNacimiento"><g:message code="alumno.fechaNacimiento.label" default="Fecha Nacimiento" /></label>
							</div>
							<div class="span-5">
								<g:textField id="fechaNacimientoId" class="ui-widget ui-corner-all ui-widget-content" name="fechaNacimiento" value="${g.formatDate(format:'dd/MM/yyyy',date:alumnoInstance?.fechaNacimiento)}" />
							</div>
										
							<g:hasErrors bean="${alumnoInstance}" field="fechaNacimiento">
								<g:renderErrors bean="${alumnoInstance}" as="list" field="fechaNacimiento"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
					   </fieldset>
		
						<fieldset>
							<legend>Datos de Nacimiento</legend>
							
							<div class="span-3 spanlabel">
								<label for="paisNac"><g:message code="alumno.paisNac.label" default="Pais de Nacimiento" /></label>
							</div>
							<div class="span-9">
								<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="paisNacId" name="paisNacDesc"  value="${alumnoInstance?.localidadNac?.provincia?.pais?.nombre}" /> 
								<g:hiddenField id="paisNacIdId" name="localidadNac.provincia?.pais?.id" value="${alumnoInstance?.localidadNac?.provincia?.pais?.id}" />
							</div>
							<div class="clear"></div>	

							<div class="span-3 spanlabel">
								<label for="provinciaNac"><g:message code="alumno.provinciaNac.label" default="Provincia de Nacimiento" /></label>
							</div>
							<div class="span-9">
								<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="provinciaNacId" name="provinciaNacDesc"  value="${alumnoInstance?.localidadNac?.provincia?.nombre}" /> 
								<g:hiddenField id="provinciaNacIdId" name="localidadNac.provincia?.id" value="${alumnoInstance?.localidadNac?.provincia?.id}" />
							</div>
							<div class="clear"></div>	

							<g:hasErrors bean="${alumnoInstance}" field="localidadNac">
								<div class="ui-state-error ui-corner-all">
							</g:hasErrors>
							<div class="span-3 spanlabel">
								<label for="localidadNac"><g:message code="alumno.localidadNac.label" default="Localidad Nac" /></label>
							</div>
							<div class="span-9">
								<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="localidadNacId" name="localidadNacDesc"  value="${alumnoInstance?.localidadNac?.nombre}" /> 
								<g:hiddenField id="localidadNacIdId" name="localidadNac.id" value="${alumnoInstance?.localidadNac?.id}" />
							</div>
							
							<g:hasErrors bean="${alumnoInstance}" field="localidadNac">
								<div class="ui-state-error ui-corner-all">
							</g:hasErrors>
							<div class="clear"></div>
					
						
						</fieldset>						   

						<fieldset>
							<legend>Domicilio</legend>
											<g:hasErrors bean="${alumnoInstance}" field="calleDomicilio">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											
											<div class="span-3 spanlabel">
												<label for="calleDomicilio"><g:message code="alumno.calleDomicilio.label" default="Calle Domicilio" /></label>
											</div>
											<div class="span-5">
												<g:textField name="calleDomicilioId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.calleDomicilio}" />
											</div>
														
											<g:hasErrors bean="${alumnoInstance}" field="calleDomicilio">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="calleDomicilio"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
				
				
											<g:hasErrors bean="${alumnoInstance}" field="numeroDomicilio">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											
											<div class="span-3 spanlabel">
												<label for="numeroDomicilio"><g:message code="alumno.numeroDomicilio.label" default="Numero Domicilio" /></label>
											</div>
											<div class="span-5">
												<g:textField name="numeroDomicilioId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.numeroDomicilio}" />
											</div>
														
											<g:hasErrors bean="${alumnoInstance}" field="numeroDomicilio">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="numeroDomicilio"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
				
											<g:hasErrors bean="${alumnoInstance}" field="barrioDomicilio">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											
											<div class="span-3 spanlabel">
												<label for="barrioDomicilio"><g:message code="alumno.barrioDomicilio.label" default="Barrio Domicilio" /></label>
											</div>
											<div class="span-5">
												<g:textField name="barrioDomicilioId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.barrioDomicilio}" />
											</div>
														
											<g:hasErrors bean="${alumnoInstance}" field="barrioDomicilio">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="barrioDomicilio"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
										   
										   <div class="span-3 spanlabel">
										   		<label for="paisDomicilio"><g:message code="alumno.paisDomicilio.label" default="Pais" /></label>
										   </div>
										   <div class="span-9">
												<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="paisDomicilioId" name="paisDomicilioDesc"  value="${alumnoInstance.localidadDomicilio?.provincia?.pais?.nombre}" /> 
				 								<g:hiddenField id="paisDomicilioIdId" name="paisDomicilio" value="${alumnoInstance.localidadDomicilio?.provincia?.pais?.id}" />
										   </div>
											<div class="clear"></div>
											
										   <div class="span-3 spanlabel">
										   		<label for="provinciaDomicilio"><g:message code="alumno.provinciaDomicilio.label" default="Provincia" /></label>
										   </div>
										   <div class="span-9">
												<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="provinciaDomicilioId" name="provinciaDomicilioDesc"  value="${alumnoInstance.localidadDomicilio?.provincia?.nombre}" /> 
				 								<g:hiddenField id="provinciaDomicilioIdId" name="provinciaDomicilio" value="${alumnoInstance.localidadDomicilio?.provincia?.pais?.id}" />
										   </div>
											<div class="clear"></div>
											
											
											<g:hasErrors bean="${alumnoInstance}" field="localidadDomicilio">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											
											<div class="span-3 spanlabel">
												<label for="localidadDomicilio"><g:message code="alumno.localidadDomicilio.label" default="Localidad Domicilio" /></label>
											</div>
											<div class="span-9">
												<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="localidadDomicilioId" name="localidadDomicilioDesc"  value="${alumnoInstance.localidadDomicilio?.nombre}" /> 
				 								<g:hiddenField id="localidadDomicilioIdId" name="localidadDomicilio.id" value="${alumnoInstance.localidadDomicilio?.id}" />
											</div>
														
											<g:hasErrors bean="${alumnoInstance}" field="localidadDomicilio">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="localidadDomicilio"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
							</fieldset>
							
							<fieldset>
								<legend>Datos de Contacto</legend>
								
											<g:hasErrors bean="${alumnoInstance}" field="telefonoParticular">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											<div class="span-3 spanlabel">
												<label for="telefonoParticular"><g:message code="alumno.telefonoParticular.label" default="Telefono Particular" /></label>
											</div>
											<div class="span-5">
												<g:textField name="telefonoParticularId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoParticular}" />
											</div>
											<g:hasErrors bean="${alumnoInstance}" field="telefonoParticular">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="telefonoParticular"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
					
										   
											<g:hasErrors bean="${alumnoInstance}" field="telefonoCelular">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											<div class="span-3 spanlabel">
												<label for="telefonoCelular"><g:message code="alumno.telefonoCelular.label" default="Telefono Celular" /></label>
											</div>
											<div class="span-5">
												<g:textField name="telefonoCelularId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoCelular}" />
											</div>
											<g:hasErrors bean="${alumnoInstance}" field="telefonoCelular">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="telefonoCelular"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
										   
					
											<g:hasErrors bean="${alumnoInstance}" field="email">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											<div class="span-3 spanlabel">
												<label for="email"><g:message code="alumno.email.label" default="Email" /></label>
											</div>
											<div class="span-5">
												<g:textField name="emailId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.email}" />
											</div>
											<g:hasErrors bean="${alumnoInstance}" field="email">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="email"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
					
										   
											<g:hasErrors bean="${alumnoInstance}" field="telefonoAlternativo">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											
											<div class="span-3 spanlabel">
												<label for="telefonoAlternativo"><g:message code="alumno.telefonoAlternativo.label" default="telefono Alternativo" /></label>
											</div>
											<div class="span-5">
												<g:textField name="telefonoAlternativoId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoAlternativo}" />
											</div>
											<g:hasErrors bean="${alumnoInstance}" field="telefonoAlternativo">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="telefonoAlternativo"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
							
							
							</fieldset>
							
							<fieldset>
								<legend>Datos Académicos</legend>
											<g:hasErrors bean="${alumnoInstance}" field="establecimientoProcedencia">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											
											<div class="span-3 spanlabel">
												<label for="establecimientoProcedencia"><g:message code="alumno.establecimientoProcedencia.label" default="Establecimiento Procedencia" /></label>
											</div>
											<div class="span-5">
												<g:textField name="establecimientoProcedenciaId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.establecimientoProcedencia}" />
											</div>
														
											<g:hasErrors bean="${alumnoInstance}" field="establecimientoProcedencia">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="establecimientoProcedencia"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
				
				
											<g:hasErrors bean="${alumnoInstance}" field="titulo">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											
											<div class="span-3 spanlabel">
												<label for="titulo"><g:message code="alumno.titulo.label" default="Titulo" /></label>
											</div>
											<div class="span-5">
												<g:textField name="tituloId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.titulo}" />
											</div>
														
											<g:hasErrors bean="${alumnoInstance}" field="titulo">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="titulo"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
				
				
											<g:hasErrors bean="${alumnoInstance}" field="anioEgreso">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											
											<div class="span-3 spanlabel">
												<label for="anioEgreso"><g:message code="alumno.anioEgreso.label" default="Anio Egreso" /></label>
											</div>
											<div class="span-5">
												<g:textField id="anioEgresoId" class="ui-widget ui-corner-all ui-widget-content" name="anioEgreso" value="${fieldValue(bean: alumnoInstance, field: 'anioEgreso')}" />
											</div>
														
											<g:hasErrors bean="${alumnoInstance}" field="anioEgreso">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="anioEgreso"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
				
				
											<g:hasErrors bean="${alumnoInstance}" field="situacionAcademicas">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											
											<div class="span-3 spanlabel">
												<label for="situacionAcademicas"><g:message code="alumno.situacionAcademicas.label" default="Situacion Academicas" /></label>
											</div>
											<div class="span-5">
												<g:select id="situacionAcademicasId" class="ui-widget ui-corner-all ui-widget-content" name="situacionAcademicas" from="${com.educacion.enums.SituacionAcademicaEnum?.values()}" keys="${com.educacion.enums.SituacionAcademicaEnum?.values()*.name()}" value="${alumnoInstance?.situacionAcademicas?.name()}"  optionValue="name"/>
											</div>
														
											<g:hasErrors bean="${alumnoInstance}" field="situacionAcademicas">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="situacionAcademicas"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
				
				
				
											<g:hasErrors bean="${alumnoInstance}" field="legajo">
												<div class="ui-state-error ui-corner-all">
											</g:hasErrors>
											
											<div class="span-3 spanlabel">
												<label for="legajo"><g:message code="alumno.legajo.label" default="Legajo" /></label>
											</div>
											<div class="span-5">
												<g:textField name="legajoId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.legajo}" />
											</div>
														
											<g:hasErrors bean="${alumnoInstance}" field="legajo">
												<g:renderErrors bean="${alumnoInstance}" as="list" field="legajo"/>
												</div>
										   </g:hasErrors>
										   <div class="clear"></div>
							</fieldset>
							
							<fieldset>
									<legend>Datos Laborales</legend>
									<g:hasErrors bean="${alumnoInstance}" field="lugarLaboral">
										<div class="ui-state-error ui-corner-all">
									</g:hasErrors>
									<div class="span-3 spanlabel">
										<label for="lugarLaboral"><g:message code="alumno.lugarLaboral.label" default="Lugar Laboral" /></label>
									</div>
									<div class="span-5">
										<g:textField name="lugarLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.lugarLaboral}" />
									</div>
									<g:hasErrors bean="${alumnoInstance}" field="lugarLaboral">
										<g:renderErrors bean="${alumnoInstance}" as="list" field="lugarLaboral"/>
										</div>
								   </g:hasErrors>
								   <div class="clear"></div>
		
		
		
									<g:hasErrors bean="${alumnoInstance}" field="telefonoLaboral">
										<div class="ui-state-error ui-corner-all">
									</g:hasErrors>
									
									<div class="span-3 spanlabel">
										<label for="telefonoLaboral"><g:message code="alumno.telefonoLaboral.label" default="Telefono Laboral" /></label>
									</div>
									<div class="span-5">
										<g:textField name="telefonoLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoLaboral}" />
									</div>
												
									<g:hasErrors bean="${alumnoInstance}" field="telefonoLaboral">
										<g:renderErrors bean="${alumnoInstance}" as="list" field="telefonoLaboral"/>
										</div>
								   </g:hasErrors>
								   <div class="clear"></div>
		
		
									<g:hasErrors bean="${alumnoInstance}" field="calleLaboral">
										<div class="ui-state-error ui-corner-all">
									</g:hasErrors>
									
									<div class="span-3 spanlabel">
										<label for="calleLaboral"><g:message code="alumno.calleLaboral.label" default="Calle Laboral" /></label>
									</div>
									<div class="span-5">
										<g:textField name="calleLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.calleLaboral}" />
									</div>
												
									<g:hasErrors bean="${alumnoInstance}" field="calleLaboral">
										<g:renderErrors bean="${alumnoInstance}" as="list" field="calleLaboral"/>
										</div>
								   </g:hasErrors>
								   <div class="clear"></div>
		
		
									<g:hasErrors bean="${alumnoInstance}" field="numeroLaboral">
										<div class="ui-state-error ui-corner-all">
									</g:hasErrors>
									
									<div class="span-3 spanlabel">
										<label for="numeroLaboral"><g:message code="alumno.numeroLaboral.label" default="Numero Laboral" /></label>
									</div>
									<div class="span-5">
										<g:textField name="numeroLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.numeroLaboral}" />
									</div>
												
									<g:hasErrors bean="${alumnoInstance}" field="numeroLaboral">
										<g:renderErrors bean="${alumnoInstance}" as="list" field="numeroLaboral"/>
										</div>
								   </g:hasErrors>
								   <div class="clear"></div>
		
		
		
									<g:hasErrors bean="${alumnoInstance}" field="barrioLaboral">
										<div class="ui-state-error ui-corner-all">
									</g:hasErrors>
									
									<div class="span-3 spanlabel">
										<label for="barrioLaboral"><g:message code="alumno.barrioLaboral.label" default="Barrio Laboral" /></label>
									</div>
									<div class="span-5">
										<g:textField name="barrioLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.barrioLaboral}" />
									</div>
												
									<g:hasErrors bean="${alumnoInstance}" field="barrioLaboral">
										<g:renderErrors bean="${alumnoInstance}" as="list" field="barrioLaboral"/>
										</div>
								   </g:hasErrors>
								   <div class="clear"></div>
		

									
									<div class="span-3 spanlabel">
										<label for="paisLaboral"><g:message code="alumno.paisLaboral.label" default="Pais Laboral" /></label>
									</div>
									<div class="span-9">
										<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="paisLaboralId" name="paisLaboralDesc"  value="${alumnoInstance?.localidadLaboral?.provincia?.pais?.nombre}" /> 
										<g:hiddenField id="paisLaboralIdId" name="paisLaboral.id" value="${alumnoInstance?.localidadLaboral?.provincia?.pais?.id}" />
									</div>
								   <div class="clear"></div>
		
									<div class="span-3 spanlabel">
										<label for="provinciaLaboral"><g:message code="alumno.paisLaboral.label" default="Provincia Laboral" /></label>
									</div>
									<div class="span-9">
										<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="provinciaLaboralId" name="provinciaLaboralDesc"  value="${alumnoInstance?.localidadLaboral?.provincia?.nombre}" /> 
										<g:hiddenField id="provinciaLaboralIdId" name="provinciaLaboral.id" value="${alumnoInstance?.localidadLaboral?.provincia?.id}" />
									</div>
								   <div class="clear"></div>
		
		
		
									<g:hasErrors bean="${alumnoInstance}" field="localidadLaboral">
										<div class="ui-state-error ui-corner-all">
									</g:hasErrors>
									
									<div class="span-3 spanlabel">
										<label for="localidadLaboral"><g:message code="alumno.localidadLaboral.label" default="Localidad Laboral" /></label>
									</div>
									<div class="span-9">
										<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="localidadLaboralId" name="localidadLaboralDesc"  value="${alumnoInstance?.localidadLaboral?.nombre}" /> 
		 										<g:hiddenField id="localidadLaboralIdId" name="localidadLaboral.id" value="${alumnoInstance?.localidadLaboral?.id}" />
									</div>
												
									<g:hasErrors bean="${alumnoInstance}" field="localidadLaboral">
										<g:renderErrors bean="${alumnoInstance}" as="list" field="localidadLaboral"/>
										</div>
								   </g:hasErrors>
								   <div class="clear"></div>
							
							</fieldset>
							


					</div>                        

					
                        
                    <div id="tabs-datostutorgarante">
                    		<fieldset>
                    			<legend>Datos del Tutor</legend>
                    		

								<g:hasErrors bean="${alumnoInstance}" field="apellidoNombreTutor">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="apellidoNombreTutor"><g:message code="alumno.apellidoNombreTutor.label" default="Apellido y Nombre Tutor" /></label>
								</div>
								<div class="span-5">
									<g:textField name="apellidoNombreTutorId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.apellidoNombreTutor}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="apellidoNombreTutor">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="apellidoNombreTutor"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	                                        
	                    
	                    
								<g:hasErrors bean="${alumnoInstance}" field="profesionTutor">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="profesionTutor"><g:message code="alumno.profesionTutor.label" default="Profesión Tutor" /></label>
								</div>
								<div class="span-5">
									<g:textField name="profesionTutorId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.profesionTutor}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="profesionTutor">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="profesionTutor"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	                    
	                    
	                    
								<g:hasErrors bean="${alumnoInstance}" field="parentescoTutor">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="parentescoTutor"><g:message code="alumno.parentescoTutor.label" default="Teléfono Tutor" /></label>
								</div>
								<div class="span-5">
									<g:textField name="parentescoTutorId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.parentescoTutor}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="parentescoTutor">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="parentescoTutor"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	                    
	
								<g:hasErrors bean="${alumnoInstance}" field="telefonoTutor">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="telefonoTutor"><g:message code="alumno.telefonoTutor.label" default="Teléfono Tutor" /></label>
								</div>
								<div class="span-5">
									<g:textField name="telefonoTutorId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoTutor}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="telefonoTutor">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="telefonoTutor"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	
	
								<g:hasErrors bean="${alumnoInstance}" field="calleTutor">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="calleTutor"><g:message code="alumno.calleTutor.label" default="Calle Tutor" /></label>
								</div>
								<div class="span-5">
									<g:textField name="calleTutorId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.calleTutor}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="calleTutor">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="calleTutor"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	
	                    
	                    
								<g:hasErrors bean="${alumnoInstance}" field="numeroTutor">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="numeroTutor"><g:message code="alumno.barrioTutor.label" default="Número Tutor" /></label>
								</div>
								<div class="span-9">
									<g:textField name="numeroTutorId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.numeroTutor}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="numeroTutor">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="numeroTutor"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	                    
	                    
								<g:hasErrors bean="${alumnoInstance}" field="barrioTutor">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="barrioTutor"><g:message code="alumno.barrioTutor.label" default="Barrio Tutor" /></label>
								</div>
								<div class="span-9">
									<g:textField name="barrioTutorId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.barrioTutor}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="barrioTutor">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="barrioTutor"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>


								<div class="span-3 spanlabel">
									<label for="paisTutorDesc"><g:message code="alumno.paisTutor.label" default="Pais Tutor" /></label>
								</div>
								<div class="span-9">
									<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="paisTutorId" name="paisTutorDesc"  value="${alumnoInstance?.localidadTutor?.provincia?.pais?.nombre}" /> 
	 										<g:hiddenField id="paisTutorIdId" name="paisTutorId" value="${alumnoInstance?.localidadTutor?.provincia?.pais?.id}" />
								</div>
							   <div class="clear"></div>


								<div class="span-3 spanlabel">
									<label for="provinciaTutorDesc"><g:message code="alumno.provinciaTutor.label" default="Provincia Tutor" /></label>
								</div>
								<div class="span-9">
									<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="provinciaTutorId" name="provinciaTutorDesc"  value="${alumnoInstance?.localidadTutor?.provincia?.nombre}" /> 
	 										<g:hiddenField id="provinciaTutorIdId" name="provinciaTutorId" value="${alumnoInstance?.localidadTutor?.provincia?.id}" />
								</div>
							   <div class="clear"></div>	                    
	                    
								<g:hasErrors bean="${alumnoInstance}" field="localidadTutor">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
	                    
								<div class="span-3 spanlabel">
									<label for="localidadTutorDesc"><g:message code="alumno.localidadTutor.label" default="Localidad Tutor" /></label>
								</div>
								<div class="span-9">
									<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="localidadTutorId" name="localidadTutorDesc"  value="${localidadTutor?.nombre}" /> 
	 										<g:hiddenField id="localidadTutorIdId" name="localidadTutor.id" value="${localidadTutor?.id}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="localidadTutor">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="localidadTutor"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
                    		</fieldset>
                    		
                    		<fieldset>
                    			<legend>Datos del Garante</legend>
								<g:hasErrors bean="${alumnoInstance}" field="apellidoNombreGarante">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="apellidoNombreGarante"><g:message code="alumno.apellidoNombreGarante.label" default="Apellido y Nombre del Garante" /></label>
								</div>
								<div class="span-5">
									<g:textField name="apellidoNombreGaranteId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.apellidoNombreGarante}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="apellidoNombreGaranteGarante">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="apellidoNombreGarante"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	                                        
	                    
	                    
								<g:hasErrors bean="${alumnoInstance}" field="profesionGarante">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="profesionGarante"><g:message code="alumno.profesionGarante.label" default="Profesión Garante" /></label>
								</div>
								<div class="span-5">
									<g:textField name="profesionGaranteId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.profesionGarante}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="profesionGarante">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="profesionGarante"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	                    
	                    
	                    
								<g:hasErrors bean="${alumnoInstance}" field="parentescoGarante">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="parentescoGarante"><g:message code="alumno.parentescoGarante.label" default="Teléfono Garante" /></label>
								</div>
								<div class="span-5">
									<g:textField name="parentescoGaranteId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.parentescoGarante}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="parentescoGarante">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="parentescoGarante"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	                    
	
								<g:hasErrors bean="${alumnoInstance}" field="telefonoGarante">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="telefonoGarante"><g:message code="alumno.telefonoGarante.label" default="Teléfono Garante" /></label>
								</div>
								<div class="span-5">
									<g:textField name="telefonoGaranteId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoGarante}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="telefonoGarante">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="telefonoGarante"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	
	
								<g:hasErrors bean="${alumnoInstance}" field="calleGarante">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="calleTutor"><g:message code="alumno.calleTutor.label" default="Calle Garante" /></label>
								</div>
								<div class="span-5">
									<g:textField name="calleGaranteId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.calleGarante}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="calleGarante">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="calleGarante"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	
	                    
	                    
								<g:hasErrors bean="${alumnoInstance}" field="numeroGarante">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="numeroGarante"><g:message code="alumno.barrioGarante.label" default="Número Garante" /></label>
								</div>
								<div class="span-9">
									<g:textField name="numeroGaranteId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.numeroGarante}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="numeroGarante">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="numeroGarante"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	                    
	                    
								<g:hasErrors bean="${alumnoInstance}" field="barrioGarante">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="barrioTutor"><g:message code="alumno.barrioGarante.label" default="Barrio Garante" /></label>
								</div>
								<div class="span-9">
									<g:textField name="barrioGaranteId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.barrioGarante}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="barrioGarante">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="barrioGarante"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
	                    
	                    
								<div class="span-3 spanlabel">
									<label for="paisGarante"><g:message code="alumno.paisGarante.label" default="Pais Garante" /></label>
								</div>
								<div class="span-9">
									<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="paisGaranteId" name="paisGaranteDesc"  value="${alumnoInstance?.localidadGarante?.provincia?.pais?.nombre}" /> 
	 										<g:hiddenField id="paisGaranteIdId" name="paisGaranteId" value="${alumnosInstance?.localidadGarante?.provincia?.pais?.id}" />
								</div>
							   <div class="clear"></div>								
	                    
								<div class="span-3 spanlabel">
									<label for="provinciaGarante"><g:message code="alumno.provinciaGarante.label" default="Provincia Garante" /></label>
								</div>
								<div class="span-9">
									<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="provinciaGaranteId" name="provinciaGaranteDesc"  value="${alumnoInstance?.localidadGarante?.provincia?.nombre}" /> 
	 										<g:hiddenField id="provinciaGaranteIdId" name="provinciaGaranteId" value="${alumnoInstance?.localidadGarante?.provincia?.id}" />
								</div>
							   <div class="clear"></div>								


	                    
								<g:hasErrors bean="${alumnoInstance}" field="localidadGarante">
									<div class="ui-state-error ui-corner-all">
								</g:hasErrors>
								<div class="span-3 spanlabel">
									<label for="localidadGarante"><g:message code="alumno.localidadGarante.label" default="Localidad Garante" /></label>
								</div>
								<div class="span-9">
									<g:textField class="ui-widget ui-corner-all ui-widget-content geoinput" id="localidadGaranteId" name="localidadGaranteDesc"  value="${alumnoInstance.localidadGarante?.nombre}" /> 
	 										<g:hiddenField id="localidadGaranteIdId" name="localidadGarante.id" value="${localidadGarante?.id}" />
								</div>
											
								<g:hasErrors bean="${alumnoInstance}" field="localidadGarante">
									<g:renderErrors bean="${alumnoInstance}" as="list" field="localidadGarante"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
                    		
                    		</fieldset>
                    </div> <%--end tab-datos tutorgarante --%>   

																	
                        

                    <div id="tabs-otrosdatos">
							<g:hasErrors bean="${alumnoInstance}" field="estadoAcademico">
								<div class="ui-state-error ui-corner-all">
							</g:hasErrors>
							<div class="span-3 spanlabel">
								<label for="estadoAcademico"><g:message code="alumno.estadoAcademico.label" default="Situacion Academicas" /></label>
							</div>
							<div class="span-5">
								<g:select id="estadoAcademicoId" class="ui-widget ui-corner-all ui-widget-content" name="estadoAcademico" from="${com.educacion.enums.SituacionAcademicaEnum?.values()}" keys="${com.educacion.enums.SituacionAcademicaEnum?.values()*.name()}" value="${alumnoInstance?.situacionAcademicas?.name()}"  optionValue="name"/>
							</div>
							<g:hasErrors bean="${alumnoInstance}" field="estadoAcademico">
								<g:renderErrors bean="${alumnoInstance}" as="list" field="estadoAcademico"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
						   
							<g:hasErrors bean="${alumnoInstance}" field="situacionAdministrativa">
								<div class="ui-state-error ui-corner-all">
							</g:hasErrors>
							<div class="span-3 spanlabel">
								<label for="situacionAdministrativa"><g:message code="alumno.situacionAdministrativa.label" default="Situacion Administrativa" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="situacionAdministrativaId" name="situacionAdministrativaDesc"  value="${alumnoInstance?.situacionAdministrativa?.descripcion}" /> 
 										<g:hiddenField id="situacionAdministrativaIdId" name="situacionAdministrativa.id" value="${situacionAdministrativa?.id}" />
							</div>
										
							<g:hasErrors bean="${alumnoInstance}" field="situacionAdministrativa">
								<g:renderErrors bean="${alumnoInstance}" as="list" field="situacionAdministrativa"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
						   
                    
                    </div> <%--end tab-datos otros --%>   
																	
                </div>
                <div class="clear"></div>		
            
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${alumnoInstance?.id}" />
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
