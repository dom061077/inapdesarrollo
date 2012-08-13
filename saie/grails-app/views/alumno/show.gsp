
<%@ page import="com.educacion.alumno.Alumno" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'alumno.label', default: 'Alumno')}" />
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'thickbox.js')}"></script>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'css',file:'thickbox.css')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <script type="text/javascript">
        	$(document).ready(function(){
            	$('#tabs').tabs();
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
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
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
							<div class="span-5 spanlabel">
								${alumnoInstance?.tipoDocumento?.name}
							</div>
						   <div class="clear"></div>

							
							<div class="span-3 spanlabel">
								<label for="numeroDocumento"><g:message code="alumno.numeroDocumento.label" default="Numero Documento" /></label>
							</div>
							<div class="span-5 spanlabel">
								${fieldValue(bean: alumnoInstance, field: 'numeroDocumento')}
							</div>
						   <div class="clear"></div>
						   
							<div class="span-3 spanlabel">
								<label for="apellido"><g:message code="alumno.apellido.label" default="Apellido" /></label>
							</div>
							<div class="span-5 spanlabel">
								${alumnoInstance?.apellido}
							</div>
						   <div class="clear"></div>
						   
							<div class="span-3 spanlabel">
								<label for="Nombre"><g:message code="alumno.Nombre.label" default="Nombre" /></label>
							</div>
							<div class="span-5 spanlabel">
								${alumnoInstance?.nombre}
							</div>
						   <div class="clear"></div>

							<div class="span-3 spanlabel">
								<label for="sexo"><g:message code="alumno.sexo.label" default="Sexo" /></label>
							</div>
							<div class="span-5 spanlabel">
								${alumnoInstance?.sexo?.name}
							</div>
						   <div class="clear"></div>
						   
							<g:hasErrors bean="${alumnoInstance}" field="fechaNacimiento">
								<div class="ui-state-error ui-corner-all">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="fechaNacimiento"><g:message code="alumno.fechaNacimiento.label" default="Fecha Nacimiento" /></label>
							</div>
							<div class="span-5 spanlabel">
								${g.formatDate(format:'dd/MM/yyyy',date:alumnoInstance?.fechaNacimiento)}
							</div>
						   <div class="clear"></div>
					   </fieldset>
		
						<fieldset>
							<legend>Datos de Nacimiento</legend>
							
							<div class="span-3 spanlabel">
								<label for="paisNac"><g:message code="alumno.paisNac.label" default="Pais de Nacimiento" /></label>
							</div>
							<div class="span-9 spanlabel">
								${alumnoInstance?.localidadNac?.provincia?.pais?.nombre} 
							</div>
							<div class="clear"></div>	

							<div class="span-3 spanlabel">
								<label for="provinciaNac"><g:message code="alumno.provinciaNac.label" default="Provincia de Nacimiento" /></label>
							</div>
							<div class="span-9 spanlabel">
								${alumnoInstance?.localidadNac?.provincia?.nombre} 
							</div>
							<div class="clear"></div>	

							<div class="span-3 spanlabel">
								<label for="localidadNac"><g:message code="alumno.localidadNac.label" default="Localidad Nac" /></label>
							</div>
							<div class="span-9 spanlabel">
								${alumnoInstance?.localidadNac?.nombre} 
							</div>
							<div class="clear"></div>
					
						
						</fieldset>						   

						<fieldset>
							<legend>Domicilio</legend>
											<div class="span-3 spanlabel">
												<label for="calleDomicilio"><g:message code="alumno.calleDomicilio.label" default="Calle Domicilio" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.calleDomicilio}
											</div>
										   <div class="clear"></div>
				
				
											<div class="span-3 spanlabel">
												<label for="numeroDomicilio"><g:message code="alumno.numeroDomicilio.label" default="Numero Domicilio" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.numeroDomicilio}
											</div>
										   <div class="clear"></div>
				

											<div class="span-3 spanlabel">
												<label for="barrioDomicilio"><g:message code="alumno.barrioDomicilio.label" default="Barrio Domicilio" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.barrioDomicilio}
											</div>
										   <div class="clear"></div>
										   
										   <div class="span-3 spanlabel">
										   		<label for="paisDomicilio"><g:message code="alumno.paisDomicilio.label" default="Pais" /></label>
										   </div>
										   <div class="span-9 spanlabel">
												${alumnoInstance.localidadDomicilio?.provincia?.pais?.nombre} 
										   </div>
											<div class="clear"></div>
											
										   <div class="span-3 spanlabel">
										   		<label for="provinciaDomicilio"><g:message code="alumno.provinciaDomicilio.label" default="Provincia" /></label>
										   </div>
										   <div class="span-9 spanlabel">
												${alumnoInstance.localidadDomicilio?.provincia?.nombre} 
										   </div>
											<div class="clear"></div>
											
											
											<div class="span-3 spanlabel">
												<label for="localidadDomicilio"><g:message code="alumno.localidadDomicilio.label" default="Localidad Domicilio" /></label>
											</div>
											<div class="span-9 spanlabel">
												${alumnoInstance.localidadDomicilio?.nombre} 
											</div>
										   <div class="clear"></div>
							</fieldset>
							
							<fieldset>
								<legend>Datos de Contacto</legend>
								
											<div class="span-3 spanlabel">
												<label for="telefonoParticular"><g:message code="alumno.telefonoParticular.label" default="Telefono Particular" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.telefonoParticular}
											</div>
										   <div class="clear"></div>
					
										   
											<div class="span-3 spanlabel">
												<label for="telefonoCelular"><g:message code="alumno.telefonoCelular.label" default="Telefono Celular" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.telefonoCelular}
											</div>
										   <div class="clear"></div>
										   
					
											<div class="span-3 spanlabel">
												<label for="email"><g:message code="alumno.email.label" default="Email" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.email}
											</div>
										   <div class="clear"></div>
					
										   
											
											<div class="span-3 spanlabel">
												<label for="telefonoAlternativo"><g:message code="alumno.telefonoAlternativo.label" default="telefono Alternativo" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.telefonoAlternativo}
											</div>
										   <div class="clear"></div>
							
							
							</fieldset>
							
							<fieldset>
								<legend>Datos Académicos</legend>
											<div class="span-3 spanlabel">
												<label for="establecimientoProcedencia"><g:message code="alumno.establecimientoProcedencia.label" default="Establecimiento Procedencia" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.establecimientoProcedencia}
											</div>
										   <div class="clear"></div>
				
											<div class="span-3 spanlabel">
												<label for="titulo"><g:message code="alumno.titulo.label" default="Titulo" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.titulo}
											</div>
										   <div class="clear"></div>
				
				
											<div class="span-3 spanlabel">
												<label for="anioEgreso"><g:message code="alumno.anioEgreso.label" default="Anio Egreso" /></label>
											</div>
											<div class="span-5 spanlabel">
												${fieldValue(bean: alumnoInstance, field: 'anioEgreso')}
											</div>
										   <div class="clear"></div>
				
				
											<div class="span-3 spanlabel">
												<label><g:message code="alumno.situacionAcademicas.label" default="Estado Académico" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.estadoAcademico?.name}
											</div>
										   <div class="clear"></div>
				
				
											<div class="span-3 spanlabel">
												<label for="legajo"><g:message code="alumno.legajo.label" default="Legajo" /></label>
											</div>
											<div class="span-5 spanlabel">
												${alumnoInstance?.legajo}
											</div>
										   <div class="clear"></div>
							</fieldset>
							
							<fieldset>
									<legend>Datos Laborales</legend>
									<div class="span-3 spanlabel">
										<label for="lugarLaboral"><g:message code="alumno.lugarLaboral.label" default="Lugar Laboral" /></label>
									</div>
									<div class="span-5 spanlabel">
										${alumnoInstance?.lugarLaboral}
									</div>
								   <div class="clear"></div>
		
		
									<div class="span-3 spanlabel">
										<label for="telefonoLaboral"><g:message code="alumno.telefonoLaboral.label" default="Telefono Laboral" /></label>
									</div>
									<div class="span-5 spanlabel">
										${alumnoInstance?.telefonoLaboral}
									</div>
								   <div class="clear"></div>
		
		
									<div class="span-3 spanlabel">
										<label for="calleLaboral"><g:message code="alumno.calleLaboral.label" default="Calle Laboral" /></label>
									</div>
									<div class="span-5 spanlabel">
										${alumnoInstance?.calleLaboral}
									</div>
								   <div class="clear"></div>
		
		
									<div class="span-3 spanlabel">
										<label for="numeroLaboral"><g:message code="alumno.numeroLaboral.label" default="Numero Laboral" /></label>
									</div>
									<div class="span-5 spanlabel">
										${alumnoInstance?.numeroLaboral}
									</div>
								   <div class="clear"></div>
		
		
		
									<div class="span-3 spanlabel">
										<label for="barrioLaboral"><g:message code="alumno.barrioLaboral.label" default="Barrio Laboral" /></label>
									</div>
									<div class="span-5 spanlabel">
										${alumnoInstance?.barrioLaboral}
									</div>
								   <div class="clear"></div>
		

									
									<div class="span-3 spanlabel">
										<label for="paisLaboral"><g:message code="alumno.paisLaboral.label" default="Pais Laboral" /></label>
									</div>
									<div class="span-9 spanlabel">
										${alumnoInstance?.localidadLaboral?.provincia?.pais?.nombre} 
									</div>
								   <div class="clear"></div>
		
									<div class="span-3 spanlabel">
										<label for="provinciaLaboral"><g:message code="alumno.paisLaboral.label" default="Provincia Laboral" /></label>
									</div>
									<div class="span-9 spanlabel">
										${alumnoInstance?.localidadLaboral?.provincia?.nombre} 
									</div>
								   <div class="clear"></div>
		
		
									<div class="span-3 spanlabel">
										<label for="localidadLaboral"><g:message code="alumno.localidadLaboral.label" default="Localidad Laboral" /></label>
									</div>
									<div class="span-9 spanlabel">
										${alumnoInstance?.localidadLaboral?.nombre} 
									</div>
												
								   <div class="clear"></div>
							
							</fieldset>
							


					</div>                        

					
                        
                    <div id="tabs-datostutorgarante">
                    		<fieldset>
                    			<legend>Datos del Tutor</legend>
								<div class="span-3 spanlabel">
									<label for="apellidoNombreTutor"><g:message code="alumno.apellidoNombreTutor.label" default="Apellido y Nombre Tutor" /></label>
								</div>
								<div class="span-5 spanlabel">
									${alumnoInstance?.apellidoNombreTutor}
								</div>
							   <div class="clear"></div>
	                    
								<div class="span-3 spanlabel">
									<label for="profesionTutor"><g:message code="alumno.profesionTutor.label" default="Profesión Tutor" /></label>
								</div>
								<div class="span-5 spanlabel">
									${alumnoInstance?.profesionTutor}
								</div>
							   <div class="clear"></div>
	                    
								<div class="span-3 spanlabel">
									<label for="parentescoTutor"><g:message code="alumno.parentescoTutor.label" default="Parentesco Tutor" /></label>
								</div>
								<div class="span-5 spanlabel">
									${alumnoInstance?.parentescoTutor}
								</div>
							   <div class="clear"></div>
	                    
	
								<div class="span-3 spanlabel">
									<label for="telefonoTutor"><g:message code="alumno.telefonoTutor.label" default="Teléfono Tutor" /></label>
								</div>
								<div class="span-5 spanlabel">
									${alumnoInstance?.telefonoTutor}
								</div>
							   <div class="clear"></div>
	
	
								<div class="span-3 spanlabel">
									<label for="calleTutor"><g:message code="alumno.calleTutor.label" default="Calle Tutor" /></label>
								</div>
								<div class="span-5 spanlabel">
									${alumnoInstance?.calleTutor}
								</div>
							   <div class="clear"></div>
	
	                    
	                    
								<div class="span-3 spanlabel">
									<label for="numeroTutor"><g:message code="alumno.barrioTutor.label" default="Número Tutor" /></label>
								</div>
								<div class="span-9 spanlabel">
									${alumnoInstance?.numeroTutor}
								</div>
							   <div class="clear"></div>
	                    
	                    
								<div class="span-3 spanlabel">
									<label for="barrioTutor"><g:message code="alumno.barrioTutor.label" default="Barrio Tutor" /></label>
								</div>
								<div class="span-9 spanlabel">
									${alumnoInstance?.barrioTutor}
								</div>
							   <div class="clear"></div>


								<div class="span-3 spanlabel">
									<label for="paisTutorDesc"><g:message code="alumno.paisTutor.label" default="Pais Tutor" /></label>
								</div>
								<div class="span-9 spanlabel">
									${alumnoInstance?.localidadTutor?.provincia?.pais?.nombre} 
								</div>
							   <div class="clear"></div>


								<div class="span-3 spanlabel">
									<label for="provinciaTutorDesc"><g:message code="alumno.provinciaTutor.label" default="Provincia Tutor" /></label>
								</div>
								<div class="span-9 spanlabel">
									${alumnoInstance?.localidadTutor?.provincia?.nombre} 
								</div>
							   <div class="clear"></div>	                    
	                    
								<div class="span-3 spanlabel">
									<label for="localidadTutorDesc"><g:message code="alumno.localidadTutor.label" default="Localidad Tutor" /></label>
								</div>
								<div class="span-9 spanlabel">
									${alumnoInstance?.localidadTutor?.nombre}
								</div>
							   <div class="clear"></div>
                    		</fieldset>
                    		
                    		<fieldset>
                    			<legend>Datos del Garante</legend>
								<div class="span-3 spanlabel">
									<label for="apellidoNombreGarante"><g:message code="alumno.apellidoNombreGarante.label" default="Apellido y Nombre del Garante" /></label>
								</div>
								<div class="span-5 spanlabel">
									${alumnoInstance?.apellidoNombreGarante}
								</div>
							   <div class="clear"></div>
	                                        
								
								<div class="span-3 spanlabel">
									<label for="profesionGarante"><g:message code="alumno.profesionGarante.label" default="Profesión Garante" /></label>
								</div>
								<div class="span-5 spanlabel">
									${alumnoInstance?.profesionGarante}
								</div>
							   <div class="clear"></div>
	                    
	                    
								<div class="span-3 spanlabel">
									<label for="parentescoGarante"><g:message code="alumno.parentescoGarante.label" default="Parentesco Garante" /></label>
								</div>
								<div class="span-5 spanlabel">
									${alumnoInstance?.parentescoGarante}
								</div>
							   <div class="clear"></div>
	                    
	
								
								<div class="span-3 spanlabel">
									<label for="telefonoGarante"><g:message code="alumno.telefonoGarante.label" default="Teléfono Garante" /></label>
								</div>
								<div class="span-5 spanlabel">
									${alumnoInstance?.telefonoGarante}
								</div>
							   <div class="clear"></div>
	
	
								
								<div class="span-3 spanlabel">
									<label for="calleTutor"><g:message code="alumno.calleTutor.label" default="Calle Garante" /></label>
								</div>
								<div class="span-5 spanlabel">
									${alumnoInstance?.calleGarante}
								</div>
							   <div class="clear"></div>
	
	                    
								<div class="span-3 spanlabel">
									<label for="numeroGarante"><g:message code="alumno.barrioGarante.label" default="Número Garante" /></label>
								</div>
								<div class="span-9 spanlabel">
									${alumnoInstance?.numeroGarante}
								</div>
							   <div class="clear"></div>
	                    
	                    
								
								<div class="span-3 spanlabel">
									<label for="barrioTutor"><g:message code="alumno.barrioGarante.label" default="Barrio Garante" /></label>
								</div>
								<div class="span-9 spanlabel">
									${alumnoInstance?.barrioGarante}
								</div>
							   <div class="clear"></div>
	                    
	                    
								<div class="span-3 spanlabel">
									<label for="paisGarante"><g:message code="alumno.paisGarante.label" default="Pais Garante" /></label>
								</div>
								<div class="span-9 spanlabel">
									${alumnoInstance?.localidadGarante?.provincia?.pais?.nombre} 
								</div>
							   <div class="clear"></div>								
	                    
								<div class="span-3 spanlabel">
									<label for="provinciaGarante"><g:message code="alumno.provinciaGarante.label" default="Provincia Garante" /></label>
								</div>
								<div class="span-9">
									${alumnoInstance?.localidadGarante?.provincia?.nombre} 
								</div>
							   <div class="clear"></div>								


	                    
								<div class="span-3 spanlabel">
									<label for="localidadGarante"><g:message code="alumno.localidadGarante.label" default="Localidad Garante" /></label>
								</div>
								<div class="span-9 spanlabel">
									${alumnoInstance.localidadGarante?.nombre} 
								</div>
							   <div class="clear"></div>
                    		
                    		</fieldset>
                    </div> <%--end tab-datos tutorgarante --%>   

																	
                        

                    <div id="tabs-otrosdatos">
							<div class="span-3 spanlabel">
								<label for="estadoAcademico"><g:message code="alumno.estadoAcademico.label" default="Situacion Academicas" /></label>
							</div>
							<div class="span-5 spanlabel">
								${alumnoInstance?.situacionAcademicas?.name}
							</div>
						   <div class="clear"></div>
						   
							<g:hasErrors bean="${alumnoInstance}" field="situacionAdministrativa">
								<div class="ui-state-error ui-corner-all">
							</g:hasErrors>
							<div class="span-3 spanlabel">
								<label for="situacionAdministrativa"><g:message code="alumno.situacionAdministrativa.label" default="Situacion Administrativa" /></label>
							</div>
							<div class="span-5 spanlabel">
								${alumnoInstance?.situacionAdministrativa?.descripcion} 
							</div>
						   <div class="clear"></div>
						   
						   
						   <div class="span-3 spanlabel">
						   		<label for="photo"> <g:message code="alumno.photo.label" default="Foto"/></label>
						   </div>
						   <div class="span-5 spanlabel">
								<bi:hasImage bean="${alumnoInstance}">
									<a class="thickbox" href="${g.resourceimgext(size:'large', bean:alumnoInstance)}"><img src="${g.resourceimgext(size:'small', bean:alumnoInstance)}"  alt=""> </img></a>
								</bi:hasImage>						   
						   </div>
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

                    <span class="menuButton"><g:link class="create" controller="alumno" action="reportealumno" params="${[id:alumnoInstance.id]}"><g:message code="Imprmir Ficha" args="[entityName]" /></g:link></span>

                </g:form>
            </div>
        </div>
    </body>
</html>
