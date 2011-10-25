

<%@ page import="com.educacion.alumno.Alumno" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'alumno.label', default: 'Alumno')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
        $('#fechaNacimientoId' ).datepicker($.datepicker.regional[ 'es' ]); 
		$('#localidadDomicilioId').lookupfield({source:'colocar aqui la url',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Prop.Id','Prop 1','Prop 2'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} 
 				,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] 
 				,hiddenid:'aqui va el id DOM del elemento html que guarda el id de busqueda' 
 				,descid:'localidadDomicilioId' 
 				,hiddenfield:'aqui va el id a recuperar de la grilla (Prop.Id)' 
 				,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); 

		$('#localidadDomicilioId' ).autocomplete({source: 'colocar aqui la url',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#cie10Id').val(ui.item.id) 
					 } 
					}, 
 				 open: function() { 
 					$( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' ); 
 				 }, 
 				 close: function() {
 					 $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' ); 
 				 } 
  				}); 
//---------------------------------- 
		$('#localidadLaboralId').lookupfield({source:'colocar aqui la url',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Prop.Id','Prop 1','Prop 2'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} 
 				,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] 
 				,hiddenid:'aqui va el id DOM del elemento html que guarda el id de busqueda' 
 				,descid:'localidadLaboralId' 
 				,hiddenfield:'aqui va el id a recuperar de la grilla (Prop.Id)' 
 				,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); 

		$('#localidadLaboralId' ).autocomplete({source: 'colocar aqui la url',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#cie10Id').val(ui.item.id) 
					 } 
					}, 
 				 open: function() { 
 					$( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' ); 
 				 }, 
 				 close: function() {
 					 $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' ); 
 				 } 
  				}); 
//---------------------------------- 
		$('#localidadNacId').lookupfield({source:'colocar aqui la url',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Prop.Id','Prop 1','Prop 2'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} 
 				,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] 
 				,hiddenid:'aqui va el id DOM del elemento html que guarda el id de busqueda' 
 				,descid:'localidadNacId' 
 				,hiddenfield:'aqui va el id a recuperar de la grilla (Prop.Id)' 
 				,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); 

		$('#localidadNacId' ).autocomplete({source: 'colocar aqui la url',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#cie10Id').val(ui.item.id) 
					 } 
					}, 
 				 open: function() { 
 					$( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' ); 
 				 }, 
 				 close: function() {
 					 $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' ); 
 				 } 
  				}); 
//---------------------------------- 

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
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${alumnoInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${alumnoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${alumnoInstance?.id}" />
                <g:hiddenField name="version" value="${alumnoInstance?.version}" />
		                
						<g:hasErrors bean="alumnoInstance" field="anioEgreso">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="anioEgreso"><g:message code="alumno.anioEgreso.label" default="Anio Egreso" /></label>
						</div>
						<div class="span-5">
							<g:textField id="anioEgresoId" class="ui-widget ui-corner-all ui-widget-content" name="anioEgreso" value="${fieldValue(bean: alumnoInstance, field: 'anioEgreso')}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="anioEgreso">
							<g:renderErrors bean="alumnoInstance" as="list" field="anioEgreso"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="apellidoNombre">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="apellidoNombre"><g:message code="alumno.apellidoNombre.label" default="Apellido Nombre" /></label>
						</div>
						<div class="span-5">
							<g:textField name="apellidoNombreId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.apellidoNombre}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="apellidoNombre">
							<g:renderErrors bean="alumnoInstance" as="list" field="apellidoNombre"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="barrioDomicilio">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="barrioDomicilio"><g:message code="alumno.barrioDomicilio.label" default="Barrio Domicilio" /></label>
						</div>
						<div class="span-5">
							<g:textField name="barrioDomicilioId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.barrioDomicilio}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="barrioDomicilio">
							<g:renderErrors bean="alumnoInstance" as="list" field="barrioDomicilio"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="barrioLaboral">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="barrioLaboral"><g:message code="alumno.barrioLaboral.label" default="Barrio Laboral" /></label>
						</div>
						<div class="span-5">
							<g:textField name="barrioLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.barrioLaboral}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="barrioLaboral">
							<g:renderErrors bean="alumnoInstance" as="list" field="barrioLaboral"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="calleDomicilio">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="calleDomicilio"><g:message code="alumno.calleDomicilio.label" default="Calle Domicilio" /></label>
						</div>
						<div class="span-5">
							<g:textField name="calleDomicilioId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.calleDomicilio}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="calleDomicilio">
							<g:renderErrors bean="alumnoInstance" as="list" field="calleDomicilio"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="calleLaboral">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="calleLaboral"><g:message code="alumno.calleLaboral.label" default="Calle Laboral" /></label>
						</div>
						<div class="span-5">
							<g:textField name="calleLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.calleLaboral}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="calleLaboral">
							<g:renderErrors bean="alumnoInstance" as="list" field="calleLaboral"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="email">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="email"><g:message code="alumno.email.label" default="Email" /></label>
						</div>
						<div class="span-5">
							<g:textField name="emailId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.email}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="email">
							<g:renderErrors bean="alumnoInstance" as="list" field="email"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="establecimientoProcedencia">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="establecimientoProcedencia"><g:message code="alumno.establecimientoProcedencia.label" default="Establecimiento Procedencia" /></label>
						</div>
						<div class="span-5">
							<g:textField name="establecimientoProcedenciaId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.establecimientoProcedencia}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="establecimientoProcedencia">
							<g:renderErrors bean="alumnoInstance" as="list" field="establecimientoProcedencia"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="fechaNacimiento">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="fechaNacimiento"><g:message code="alumno.fechaNacimiento.label" default="Fecha Nacimiento" /></label>
						</div>
						<div class="span-5">
							<g:textField id="fechaNacimientoId" class="ui-widget ui-corner-all ui-widget-content" name="fechaNacimiento" value="${fieldValue(bean: alumnoInstance, field: 'fechaNacimiento')}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="fechaNacimiento">
							<g:renderErrors bean="alumnoInstance" as="list" field="fechaNacimiento"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="legajo">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="legajo"><g:message code="alumno.legajo.label" default="Legajo" /></label>
						</div>
						<div class="span-5">
							<g:textField name="legajoId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.legajo}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="legajo">
							<g:renderErrors bean="alumnoInstance" as="list" field="legajo"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="localidadDomicilio">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="localidadDomicilio"><g:message code="alumno.localidadDomicilio.label" default="Localidad Domicilio" /></label>
						</div>
						<div class="span-5">
							<g:textField class="ui-widget ui-corner-all ui-widget-content" id="localidadDomicilioId" name="localidadDomicilioDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="localidadDomicilioIdId" name="localidadDomicilio.id" value="$localidadDomicilio?.id" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="localidadDomicilio">
							<g:renderErrors bean="alumnoInstance" as="list" field="localidadDomicilio"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="localidadLaboral">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="localidadLaboral"><g:message code="alumno.localidadLaboral.label" default="Localidad Laboral" /></label>
						</div>
						<div class="span-5">
							<g:textField class="ui-widget ui-corner-all ui-widget-content" id="localidadLaboralId" name="localidadLaboralDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="localidadLaboralIdId" name="localidadLaboral.id" value="$localidadLaboral?.id" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="localidadLaboral">
							<g:renderErrors bean="alumnoInstance" as="list" field="localidadLaboral"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="localidadNac">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="localidadNac"><g:message code="alumno.localidadNac.label" default="Localidad Nac" /></label>
						</div>
						<div class="span-5">
							<g:textField class="ui-widget ui-corner-all ui-widget-content" id="localidadNacId" name="localidadNacDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="localidadNacIdId" name="localidadNac.id" value="$localidadNac?.id" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="localidadNac">
							<g:renderErrors bean="alumnoInstance" as="list" field="localidadNac"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="lugarLaboral">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="lugarLaboral"><g:message code="alumno.lugarLaboral.label" default="Lugar Laboral" /></label>
						</div>
						<div class="span-5">
							<g:textField name="lugarLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.lugarLaboral}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="lugarLaboral">
							<g:renderErrors bean="alumnoInstance" as="list" field="lugarLaboral"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="numeroDocumento">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="numeroDocumento"><g:message code="alumno.numeroDocumento.label" default="Numero Documento" /></label>
						</div>
						<div class="span-5">
							<g:textField id="numeroDocumentoId" class="ui-widget ui-corner-all ui-widget-content" name="numeroDocumento" value="${fieldValue(bean: alumnoInstance, field: 'numeroDocumento')}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="numeroDocumento">
							<g:renderErrors bean="alumnoInstance" as="list" field="numeroDocumento"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="numeroDomicilio">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="numeroDomicilio"><g:message code="alumno.numeroDomicilio.label" default="Numero Domicilio" /></label>
						</div>
						<div class="span-5">
							<g:textField name="numeroDomicilioId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.numeroDomicilio}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="numeroDomicilio">
							<g:renderErrors bean="alumnoInstance" as="list" field="numeroDomicilio"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="numeroLaboral">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="numeroLaboral"><g:message code="alumno.numeroLaboral.label" default="Numero Laboral" /></label>
						</div>
						<div class="span-5">
							<g:textField name="numeroLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.numeroLaboral}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="numeroLaboral">
							<g:renderErrors bean="alumnoInstance" as="list" field="numeroLaboral"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="sexo">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="sexo"><g:message code="alumno.sexo.label" default="Sexo" /></label>
						</div>
						<div class="span-5">
							<g:select id="sexoId" class="ui-widget ui-corner-all ui-widget-content" name="sexo" from="${com.educacion.enums.SexoEnum?.values()}" keys="${com.educacion.enums.SexoEnum?.values()*.name()}" value="${alumnoInstance?.sexo?.name()}"  optionValue="name"/>
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="sexo">
							<g:renderErrors bean="alumnoInstance" as="list" field="sexo"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="situacionAcademicas">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="situacionAcademicas"><g:message code="alumno.situacionAcademicas.label" default="Situacion Academicas" /></label>
						</div>
						<div class="span-5">
							<g:select id="situacionAcademicasId" class="ui-widget ui-corner-all ui-widget-content" name="situacionAcademicas" from="${com.educacion.enums.SituacionAcademicaEnum?.values()}" keys="${com.educacion.enums.SituacionAcademicaEnum?.values()*.name()}" value="${alumnoInstance?.situacionAcademicas?.name()}"  optionValue="name"/>
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="situacionAcademicas">
							<g:renderErrors bean="alumnoInstance" as="list" field="situacionAcademicas"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="telefonoAlternativo">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="telefonoAlternativo"><g:message code="alumno.telefonoAlternativo.label" default="telefono Alternativo" /></label>
						</div>
						<div class="span-5">
							<g:textField name="telefonoAlternativoId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoAlternativo}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="telefonoAlternativo">
							<g:renderErrors bean="alumnoInstance" as="list" field="telefonoAlternativo"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="telefonoCelular">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="telefonoCelular"><g:message code="alumno.telefonoCelular.label" default="Telefono Celular" /></label>
						</div>
						<div class="span-5">
							<g:textField name="telefonoCelularId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoCelular}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="telefonoCelular">
							<g:renderErrors bean="alumnoInstance" as="list" field="telefonoCelular"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="telefonoLaboral">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="telefonoLaboral"><g:message code="alumno.telefonoLaboral.label" default="Telefono Laboral" /></label>
						</div>
						<div class="span-5">
							<g:textField name="telefonoLaboralId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoLaboral}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="telefonoLaboral">
							<g:renderErrors bean="alumnoInstance" as="list" field="telefonoLaboral"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="telefonoParticular">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="telefonoParticular"><g:message code="alumno.telefonoParticular.label" default="Telefono Particular" /></label>
						</div>
						<div class="span-5">
							<g:textField name="telefonoParticularId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.telefonoParticular}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="telefonoParticular">
							<g:renderErrors bean="alumnoInstance" as="list" field="telefonoParticular"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="tipoDocumento">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="tipoDocumento"><g:message code="alumno.tipoDocumento.label" default="Tipo Documento" /></label>
						</div>
						<div class="span-5">
							<g:select id="tipoDocumentoId" class="ui-widget ui-corner-all ui-widget-content" name="tipoDocumento" from="${com.educacion.enums.TipoDocumentoEnum?.values()}" keys="${com.educacion.enums.TipoDocumentoEnum?.values()*.name()}" value="${alumnoInstance?.tipoDocumento?.name()}"  optionValue="name"/>
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="tipoDocumento">
							<g:renderErrors bean="alumnoInstance" as="list" field="tipoDocumento"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="alumnoInstance" field="titulo">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="titulo"><g:message code="alumno.titulo.label" default="Titulo" /></label>
						</div>
						<div class="span-5">
							<g:textField name="tituloId" class="ui-widget ui-corner-all ui-widget-content" value="${alumnoInstance?.titulo}" />
						</div>
									
						<g:hasErrors bean="alumnoInstance" field="titulo">
							<g:renderErrors bean="alumnoInstance" as="list" field="titulo"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
