<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">

<%@ page import="grails.plugin.springsecurity.SpringSecurityUtils"
		 import= "com.medfire.enums.EstadoEvent"
%>



<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
		<META HTTP-EQUIV="Cache-Control" CONTENT ="no-cache"/> 
		
		<meta content='Complemento, Informatico, Administrativo, cima, online, web, sistema, complemento informatico administrativo, supra' name='Keywords'/>
		<meta content='Administración Online de Consultorios' name='Description'/>
		<meta content='I.N.A.P' name='Author'/>
		<meta content='http://www.inap.com.ar:8080/cima' name='Identifier' scheme='URI'/>
		<meta content='http://www.inap.com.ar:8080/cima' name='Publisher'/>
		<meta content='I.N.A.P' name='Creator'/>
		<meta content='Argentina' name='Coverage.jurisdiction'/>
		<meta content='Argentina, Latinoamerica, informatica,online' name='page-topic'/>
		<meta content='All' name='audience'/>
		<meta content='General' name='Rating'/>
		<meta content='Global' name='Distribution'/>
		<meta content='Document' name='ObjectType'/>
		<meta content='index follow' name='googlebot'/>
		<meta content='index,follow,all' name='robots'/>
		<meta content='7 Days' name='revisit-after'/>
		<meta content='7 days' name='revisit'/>		
		
		       
	    <link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'screen.css')}" type="text/css" media="screen, projection">
    	<link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'print.css')}" media="print">
    	<!--[if lt IE 8]><link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'ie.css')}" type="text/css" media="screen, projection"><![endif]-->


         <link rel="stylesheet" href="${resource(dir:'css',file:'jquery-ui-1.8.11.custom.css')}" />
        
        <link rel="shortcut icon" href="${resource(dir:'images',file:'icono.ico')}" type="image/x-icon" />
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery-1.5.1.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery-ui/js',file:'jquery-ui-1.8.11.custom.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery-ui',file:'jquery-ui-i18n.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'json2.js')}"></script>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'css',file:'custom.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jquery-ui/js/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jquery-ui/js/src/css',file:'jquery.searchFilter.css')}" />
        
        <script type="text/javascript" src="${resource(dir:'js/editor',file:'ckeditor.js')}"></script>

		
		
        <link rel="stylesheet" href="${resource(dir:'css/menu',file:'dropdown.css')}" type="text/css" media="screen, projection"/>        
        <link rel="stylesheet" href="${resource(dir:'css/menu',file:'default.advanced.css')}" type="text/css" media="screen, projection"/>
            
                
        <script type="text/javascript" src="${g.resource(dir:'js/jquery-ui/js/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jquery-ui/js',file:'jquery.jqGrid.min.js')}"></script>        
        <script type="text/javascript" src="${resource(dir:'js/jquery-ui/js',file:'jquery.timer.js')}"></script> 
		<script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.dropdown.js')}"></script>               
		<script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.contextmenu.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.cookie.js')}"></script>
		
        <script type="text/javascript">
			var urlpacientes = '<%out << g.createLink(controller:'event',action:'listatencionjson');%>'
			var urlsesion = '<%out << g.createLink(controller:"login",action:"auth")%>';
			var profesionalesId=0;
			var locconsultashistoria = '<%out << g.createLink(controller:"consulta",action:"listjson")%>';
			var locconsultahistoriashow = '<%out << g.createLink(controller:"historiaClinica",action:"minshow")%>';
			
			
			
			<%--
				if (SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN,ROLE_PROFESIONAL")){
					out << "turnosprof = true;";
					 
					out << "var locturnos='"+g.createLink(controller:"event",action:"atenciondeldia")+"';";
					out << "var locupdturnos ='"+g.createLink(controller:"event",action:"updateestado")+"';";
					out << "var locpacientes ='"+g.createLink(controller:"event",action:"editpaciente")+"';";
				}
			--%>
        </script>        
		<sec:ifAnyGranted roles="ROLE_PROFESIONAL">
			<script type="text/javascript" src="${g.resource(dir:'js/script',file:'scriptatencion.js')}"></script>
			
		</sec:ifAnyGranted>
		
        
        <script type="text/javascript" src="${resource(dir:'js',file:'main.js')}"></script> 
        
        <g:layoutHead />
        <g:javascript library="application" />
        <style type="text/css">
        	body{
       			font-size:65%;
       			}
        
        				.ui-autocomplete-loading { background: white url('<%out << g.resource(dir:'images',file:'load.gif')%>') right center no-repeat; }

							.ui-autocomplete {
									max-height: 100px;
									overflow-y: auto;
									/* prevent horizontal scrollbar */
									overflow-x: hidden;
									/* add padding to account for vertical scrollbar */
									padding-right: 20px;
								}
								/* IE 6 doesn't support max-height
								 * we use height instead, but this forces the menu to always be this tall
								 */
								* html .ui-autocomplete {
									height: 100px;
							}
        </style>

    </head>
    <body>

<div class="container">
	
    
			<div style="display:none;z-index:5000" id="MenuJqGrid">
		        <ul>
		            <li id="atendido"><g:colorsList event='COLOR_ATENDIDO'/>${EstadoEvent.EVENT_ATENDIDO.name}</li>
		            <li id="ausente"><g:colorsList event='COLOR_AUSENTE'/>${EstadoEvent.EVENT_AUSENTE.name}</li>
		            <li id="anulado"><g:colorsList event='COLOR_ANULADO'/>${EstadoEvent.EVENT_ANULADO.name}</li>
		            <li id="pendiente"><g:colorsList event='COLOR_PENDIENTE'/>${EstadoEvent.EVENT_PENDIENTE.name}</li>
		            <li id="datosdelpaciente"><span style="float:left" class="ui-icon ui-icon-person"></span>Datos del Paciente</li>
		
		        </ul>
		    </div> <!-- tag cierre del div MenuJqGrid -->
		    
			<div id="panelConsultasHistoriaId" style="display:none">
					
					<div  class="span-2 spanlabel">H.C.Nro.:</div>
					<div id="hcnConsultaHistoriaId" class="span-3 spanlabel">xxxxx</div>
					<div class="span-2 spanlabel">Apellido y Nombre:</div>
					<div id="apellidoNombreConsultaHistoriaId" class="span-3 spanlabel">xxxxxxxx</div>
					<div class="clear"></div>
				<table id="listConsultasHistoriaId"></table>
				<div id="pagerListCOnsultasHistoriaId"></div>				
			</div>
		    
		    
			<div  id="exploradorId" style="display:none">
						<button title='Cambiar Estado Turno' id="menuExploradorEstadoId">Estado</button>
						<button title='Alta de Consulta' id="menuExploradorNuevaConsultaId">Consulta</button>
						<button title='Historia Clinica' id="menuExploradorHistId">Hist.</button>
						<a href="#" title='Fecha de los turnos' id="menuExploradorHistFechaId"></a>
						<div id="menuExplorardorHistFechaDatePickerId"></div>
					<table id="listturnos"></table>
					<div id="pagerlistturnos">
					</div>
			</div>
			
	
			<div style="display:none" id="dialog-form" title="Información del turno">
				<form id="formturnosId">
					<table>
						<tr class="prop">
							<td>
								<label for='pacienteturno'>Paciente:</label>
							</td>
							<td>
								<input class="ui-widget ui-corner-all ui-widget-content" type="text" disabled name='pacienteturno' id='pacienteturnoId' />
								<input type="hidden" name="id" id="turnoId" />
								<input type="hidden" name="cmd" value="update" />
								<input type="hidden" name="version" id="versionId"/>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="fechaturno">Fecha y Hora Inicio del Turno:</label>
							</td>
							<td>
								<input class="ui-widget ui-corner-all ui-widget-content" type="text" disabled id="fechaturnoInicioId"/>
							</td>
						</tr>		
						<tr class="prop">
							<td valign="top" class="name">
								<label for="fechaturno">Fecha y Hora Fin del Turno:</label>
							</td>
							<td>
								<input class="ui-widget ui-corner-all ui-widget-content" type="text" disabled id="fechaturnoFinId"/>
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="fechaturno">Estado:</label>
							</td>
							<td>
								<g:select  id="estadoturnoId" class="ui-widget ui-corner-all ui-widget-content"  name="estado" from="${com.medfire.enums.EstadoEvent?.list().findAll{it!=com.medfire.enums.EstadoEvent.EVENT_ATENDIDO}}" 
			                           	optionValue="name" />
							</td>
						</tr>													
					</table>									
				</form>
			</div>



<div class="span-24 last append-bottom" >
			<div class="span-24">
				
					<sec:ifLoggedIn>
						<div class="span-9">
							<a href="${createLink(uri:'/')}">
								<img style="float:left" alt="" src="${resource(dir:"images", file:"cabecera2_0log.png")}"/>
							</a>	
						</div>
						<div class="span-5">
							<g:institucioninfo/>
						</div>
						<div class="span-2 prepend-6">	
							<g:institucionimg/>
						</div>
					</sec:ifLoggedIn>
					<sec:ifNotLoggedIn>
						<div class="span-5">
							<img  alt="" src="${resource(dir:"images", file:"cabecera2_0.png")}"/>
						</div>
					</sec:ifNotLoggedIn>
					
			</div>    

	<div class="span-12">
			<div class="span-5 prepend-15">
	            <sec:ifLoggedIn>
<%--					<div>--%>
<%--						Usuario: <%out << g.loggedInUserInfo(field:"userRealName")%>--%>
<%--					</div>--%>
				</sec:ifLoggedIn>
			</div>
	<div id="panelEsperaId" style="display:none">
		<a id="linkActivateEsperaId" href="#">Mostrar Turnos</a>
	</div>
			
           	<sec:ifLoggedIn>
           		<div style="background-color: #5C9CCC" class="span-14 prepend-10">
		            <ul class="dropdown dropdown-horizontal" >
						<li><a href="#" class="dir">Archivo</a>
							<ul>
								<sec:ifAnyGranted role="ROLE_ADMIN">
									<li><a href="${createLink(controller:'user')}">Usuarios</a></li>
									<li><a href="${createLink(controller:'role')}">Roles</a></li>
									<li><a href="${createLink(controller:'requestmap')}">Requestmap</a></li>
								</sec:ifAnyGranted>
								<li><a href="${createLink(controller:"auditoria",action:"consultaaudit")}">Auditoría</a></li>
								
							</ul>
						</li>
						<sec:ifAnyGranted role="ROLE_PROFESIONAL,ROLE_ADMIN">
							<li><a href="#" class="dir">Edición</a>
								<ul>
									<sec:ifAnyGranted role="ROLE_ADMIN,ROLE_PROFESIONAL">
										<li><a href="${response.encodeURL(createLink(controller:'antecedenteLabel',action:'redirect')+g.antecedenteLabel(field:'id',url:true))}">Etiquetas de Ficha Clínica</a></li>	
									</sec:ifAnyGranted>
									<sec:ifAnyGranted role="ROLE_ADMIN">
										<li><a href="${response.encodeURL(createLink(controller:'antecedenteLabel',action:'list')+g.antecedenteLabel(field:'id',url:true))}">Listar etiquetas de Ficha Clínica</a></li>
									</sec:ifAnyGranted>
									<li><a href="${createLink(controller:'institucion',action:'redirectaction')}">Membrete Institucional</a></li>
								</ul>							
							</li>
						</sec:ifAnyGranted>
						<li><a href="#" class="dir">Actualizaciones</a>
							<ul>
								<sec:ifAnyGranted role="ROLE_ADMIN,ROLE_USER">
									<li><a href="${createLink(controller:'obraSocial',action:'list')}">Obra Social</a></li>
									<li><a href="${createLink(controller:'event',action:'create')}">Turnos</a></li>
									<li><a href="${createLink(controller:'profesional',action:'list')}">Profesionales</a> </li>
<%--									<li><a href="${createLink(controller:'laboratorio',action:'list')}">Laboratorios</a> </li>--%>
									<li><a href="${createLink(controller:'especialidadMedica',action:'list')}">Especialidades</a> </li>			
								</sec:ifAnyGranted>

								<sec:ifAnyGranted role="ROLE_ADMIN">
									<li><a href="${createLink(controller:'institucion',action:'list')}">Institución</a></li>
								</sec:ifAnyGranted>

								<sec:ifAnyGranted role="ROLE_ADMIN,ROLE_USER,ROLE_PROFESIONAL">
									<li><a href="${createLink(controller:'paciente',action:'list')}">Pacientes</a></li>
									<li><a href="${createLink(controller:'vademecum',action:'list')}">Vademecum</a></li>
								</sec:ifAnyGranted>
								<sec:ifAnyGranted role="ROLE_ADMIN,ROLE_PROFESIONAL">
									<li><a href="${createLink(controller:'historiaClinica',action:'list')}">Historia Cínica</a> </li>
								</sec:ifAnyGranted>
							</ul>
						</li>
						<li><a href="#" class="dir">Informes</a>
							<ul>
								<sec:ifAnyGranted role="ROLE_ADMIN,ROLE_PROFESIONAL">
									<li><a href="${createLink(controller:"indicecorporal",action:"index")}">Indice de masa corporal</a> </li>
									<li><a href="${createLink(controller:"consulta",action:"consultaspropias")}">Visitas de mis Pacientes</a> </li>
								</sec:ifAnyGranted>
								<li><a href="${createLink(controller:"consulta",action:"pacientesatendidos")}">Pacientes Atendidos</a></li>
								<sec:ifAnyGranted role="ROLE_ADMIN,ROLE_USER,ROLE_PROFESIONAL">
									<li><a href="${createLink(controller:"consulta",action:"pacientesatendidosporos")}">Pacientes Atendidos por O.S</a></li>
									<li><a href="${createLink(controller:"consulta",action:"pacientesatendidosporprimeravez")}">Pacientes Atendidos por Primera Vez</a></li>
								</sec:ifAnyGranted>
								<sec:ifAnyGranted role="ROLE_ADMIN,ROLE_PROFESIONAL">
									<li><a href="${createLink(controller:"consulta",action:"pacientesatendidosporgrupodiag")}">Pacientes Atendidos por grupo diagnostico</a></li>																								
<!--							<li><a href="${createLink(controller:"consulta",action:"cantidadvisitasporpaciente")}">Cantidad de visitas de un paciente</a></li>								-->
								</sec:ifAnyGranted>
							</ul>
						</li>
						
						<li><a href="#" class="dir">Usuario <%out << g.loggedInUserInfo(field:"userRealName")%></a>
							<ul>
								<li><a href="${createLink(controller:"user",action:"changepassword")}">Cambiar Contraseña</a></li>
								<li><a href="${createLink(controller:'logout',action:'index')}">Cerrar Sesión</a></li>							
							</ul>
						</li>
						
						
						
					</ul>
				</div>	
			</sec:ifLoggedIn>
	</div><!-- div cierre del menu -->
	<sec:ifLoggedIn>
		<div class="span-7 prepend-3 last">
		</div>
	</sec:ifLoggedIn>
</div> <!-- cierre del div de la cabecera -->
		<div class="span-22 prepend-2 last">
	        	<g:layoutBody />
		</div>	
        <div style="height:80px;background:url(${resource(dir:"images",file:"footer.png")})" class="span-24 last prepend-top">
        	<p style="text-align:center;padding-left:10px;padding-top:50px;font-color:">
            &copy; Copyright 2011 &lt;INAP&gt; | Design by: &lt;INAP&gt;
            </p>
        </div><!-- end footer -->

		
		
</div><!-- div page -->

    			
    </body>
</html>