<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">


<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
	    <link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'screen.css')}" type="text/css" media="screen, projection">
    	<link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'print.css')}" media="print">
    	<!--[if lt IE 10]><link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'ie.css')}" type="text/css" media="screen, projection"><![endif]-->
        
         <link rel="stylesheet" href="${resource(dir:'css/blitzer',file:'jquery-ui-1.8.16.custom.css')}" />
         <link rel="stylesheet" href="${resource(dir:'css',file:'custom.css')}" />
         <link rel="stylesheet" href="${resource(dir:'css/menu/flickr',file:'helper.css')}" />
         <link rel="stylesheet" href="${resource(dir:'css/menu',file:'dropdown.css')}" />    
         <link rel="stylesheet" href="${resource(dir:'css/menu/flickr',file:'default.ultimate.css')}" />         
         
        
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery-1.6.2.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'json2.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery-ui',file:'jquery-ui-1.8.16.custom.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery-ui',file:'jquery-ui-i18n.js')}"></script>
        
		<script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.dropdown.js')}"></script>
		<script type="text/javascript">
			var urlsesion = '<%out << createLink(controller:'login',action:'auth');%>';
			/*$(function(){
				$( "input:submit" ).button();
			});*/
            $(document).ready(function(){
                $.datepicker.setDefaults($.datepicker.regional[ 'es' ]);
            });
		
		</script>
        <style type="text/css">
            .ui-autocomplete {
                max-height: 100px;
                overflow-y: auto;
                /* prevent horizontal scrollbar */
                overflow-x: hidden;
                /* add padding to account for vertical scrollbar */
                padding-right: 20px;
            }
        </style>

       <g:javascript library="application" />
        
         
        <g:layoutHead />
         <style type="text/css">
        	body{
        		font-size:65%
        	}
        </style>
    </head>
    <body>
    	<div class="container">
    	
    		<div  class="span-24">
			        <div class="span-24 prepend-top append-bottom">
			            <img src="${resource(dir:'images',file:'cabecera1.png')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
			        </div>
			       
					<div class="clear"></div>
					<ul id="nav" class="dropdown dropdown-horizontal">


                        <li><span class="dir">Actualización</span>
							<ul>
								<li><span class="dir">Académica</span>
									<ul>
										<li><span class="dir">Clase Requisitos</span>
											<ul>
												<li><a href="${createLink(controller:'claseRequisito',action:'create')}">Actualización</a></li>
												<li><a href="${createLink(controller:'claseRequisito',action:'list')}">Listado</a></li>
											</ul>
										</li>
										<li><span class="dir">Requisitos</span>
											<ul>
												<li><a href="${createLink(controller:'requisito',action:'create')}">Actualización</a></li>
												<li><a href="${createLink(controller:'requisito',action:'list')}">Listado</a></li>
											</ul>
										</li>
										
										<li><span class="dir">Carreras</span>
											<ul>
												<li><a href="${createLink(controller:'carrera',action:'create')}">Actualización</a></li>
												<li><a href="${createLink(controller:'carrera',action:'list')}">Listado</a></li>
												<li><a href="${createLink(controller:'documentoCarrera',action:'create')}">Documentos adjuntos</a></li>
											</ul>
										</li>
										
										<li><span class="dir">Alumnos</span>
											<ul>
												<li><a href="${createLink(controller:'alumno',action:'create')}">Actualización</a></li>
												<li><a href="${createLink(controller:'alumno')}">Listado</a></li>
												<li><a href="${createLink(controller:'alumno',action:'register')}">Registro Online de Alumno</a></li>
                                                <li><a href="${createLink(controller:'division',action:'asignaula')}">Asignar Divisiones</a></li>
											</ul>
										</li>

                                        <li><span class="dir">Asistencia</span>
                                            <ul>
                                                <li><a href="${createLink(controller:'asistencia',action:'create')}">Actualizar</a></li>
                                            </ul>
                                        </li>

										<li><span class="dir">Materias</span>
											<ul>
												<li><a href="${createLink(controller:'materia',action:'create')}">Actualización</a></li>
												<li><a href="${createLink(controller:'materia',action:'list')}">Listado</a></li>
                                                <li><a href="${createLink(controller:'materia',action:'createcalificacion')}">Actualización de Calificaciones</a></li>
											</ul>
										</li>

										<li><span class="dir">Aulas</span>
											<ul>
												<li><a href="${createLink(controller:'aula',action:'create')}">Actualización</a></li>
												<li><a href="${createLink(controller:'aula',action:'list')}">Listado</a></li>
											</ul>
										</li>
										<li><span class="dir">Divisiones</span>
											<ul>
												<li><a href="${createLink(controller:'division',action:'create')}">Actualización</a></li>
												<li><a href="${createLink(controller:'division',action:'list')}">Listado</a></li>
											</ul>
										</li>
                                        <li><span class="dir">Exámenes</span>
                                            <ul>
                                                <li><a href="${createLink(controller:"cargaExamen",action:"create")}">Actualización</a></li>
                                                <li><a href="${createLink(controller: "cargaExamen", action:"list")}">Listado</a></li>
                                            </ul>
                                            
                                        </li>
                                        <li><span class="dir">Docentes</span>
                                            <ul>
                                                <li><a href="${createLink(controller:"docente",action:"create")}">Actualización</a></li>
                                                <li><a href="${createLink(controller: "docente", action:"list")}">Listado</a></li>
                                            </ul>
                                        </li>
                                        <li><span class="dir">Asignatura de Docentes</span>
                                            <ul>
                                                <li><a href="${createLink(controller:"asignaturaDocente",action:"create")}">Generar Asignatura</a></li>
                                                <li><a href="${createLink(controller:"asignaturaDocente",action:"list")}">Actualización de Asignaturas</a></li>
                                            </ul>
                                        </li>

									</ul>
								</li>
								
								<li><span class="dir">Administrativa</span>
								</li>
							
								
							</ul>	
						</li>
						
						<li><span class="dir">Gestión</span>
								<ul>
									<li><span class="dir">Académica</span>
										<ul>
											<li><span class="dir">Ingresos</span>
												<ul>
													<li><a href="${createLink(controller:'preinscripcion',action:'carrerasdisponibles')}">Generar Ingreso</a></li>
													<li><a href="${createLink(controller:'preinscripcion',action:'list')}">Actualización de Ingresos</a></li>
												</ul>
											</li>
											<li><span class="dir">Inscripciones</span>
												<ul>
													<li><a href="${createLink(controller:'inscripcionMateria',action:'alumnosinscripcion')}">Generar Inscripción</a></li>
													<li><a href="${createLink(controller:'inscripcionMateria',action:'list')}">Actualización de Inscripciones</a></li>
												</ul>
											</li>
											
											<li><span class="dir">Matrículas</span>
												<ul>
													<!--li><a href="${createLink(controller:'inscripcionMatricula',action:'seleccionalumno')}">Matriculación de alumnos existentes</a></li -->
													<li><a href="${createLink(controller:'inscripcionMatricula',action:'list')}">Listado de Matriculaciones</a></li>								
												</ul>
											</li>
											
											
										</ul>
									</li>																		
									<li><span class="dir">Administrativa</span>
										<ul>
											<li><a href="${createLink(controller:'materia',action:'listasistencia')}">Asistencia</a></li>
										</ul>
									</li>																		
									<li><span class="dir">Informes</span>
										<ul>
											<li><a href="${createLink(controller:'materia',action:'listasistencia')}">Planilla de Asistencia</a></li>
										</ul>
									</li>
								</ul>
						</li>
						
						<li><span class="dir">Contactenos</span>
							<ul>
								<li><a href="./">Incidencias</a></li>
								<li class="divider last"><a href="./">Mas...</a></li>
							</ul>
						</li>
					
						<li><span class="dir">Usuario</span>
							<ul>
								<li><span class="dir">Roles</span>
									<ul>
										<li><a href="${createLink(controller:'role',action:'create')}">Actualización de Rol</a></li>
										<li><a href="${createLink(controller:'role',action:'list')}">Listado de Rol</a></li>
									</ul>
								</li>

								<li><span class="dir">Grupo de Permisos</span>
									<ul>
										<li><a href="${createLink(controller:'requestmapGroup',action:'create')}">Actualización Grupo de Permisos</a></li>								
										<li><a href="${createLink(controller:'requestmapGroup',action:'list')}">Listado de Grupo de Permisos</a></li>										
									</ul>
								</li>

								<li><span class="dir">Usuarios</span>
									<ul>
										<li><a href="${createLink(controller:'user',action:'create')}">Actualización de Usuarios</a></li>								
										<li><a href="${createLink(controller:'user',action:'search')}">Listado de Usuarios</a></li>										
									</ul>
								</li>

								
								<li><a href="${createLink(controller:'logout',action:'index')}">Cerrar Sesión</a></li>
							</ul>
						</li>
					</ul>

    
			        <div class="clear append-bottom"></div>
			        <div class="span-20 prepend-2 last">
			        	<g:layoutBody />
			        </div>
			        <div class="clear"></div>
		
					<div style="padding-top:5px;height:25px;background:url(${resource(dir:"images",file:"footer1.png")}) no-repeat"  class="span-24 last prepend-top">
		        		<p style="text-align:center">
		           		 &copy; Copyright 2011 &lt;INAP&gt; | Design by: Marca Registrada
		            	</p>
		        	</div><!-- end footer -->
			</div>		        		        	
	    </div>    
    </body>
</html>