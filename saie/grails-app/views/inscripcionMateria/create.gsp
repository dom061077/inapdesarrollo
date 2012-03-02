

<%@ page import="com.educacion.academico.InscripcionMateria" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'inscripcionMateria.label', default: 'InscripcionMateria')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
        		$('#alumnoId').lookupfield({source:'colocar aqui la url',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Prop.Id','Prop 1','Prop 2'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} 
 				,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] 
 				,hiddenid:'alumnoIdId' 
 				,descid:'alumnoId' 
 				,hiddenfield:'id' 
 				,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); 

		$('#alumnoId' ).autocomplete({source: 'colocar aqui la url',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#alumnoIdId').val(ui.item.id) 
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
		$('#anioLectivoId').lookupfield({source:'colocar aqui la url',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Prop.Id','Prop 1','Prop 2'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} 
 				,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] 
 				,hiddenid:'anioLectivoIdId' 
 				,descid:'anioLectivoId' 
 				,hiddenfield:'id' 
 				,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); 

		$('#anioLectivoId' ).autocomplete({source: 'colocar aqui la url',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#anioLectivoIdId').val(ui.item.id) 
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
		$('#carreraId').lookupfield({source:'colocar aqui la url',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Prop.Id','Prop 1','Prop 2'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} 
 				,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] 
 				,hiddenid:'carreraIdId' 
 				,descid:'carreraId' 
 				,hiddenfield:'id' 
 				,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); 

		$('#carreraId' ).autocomplete({source: 'colocar aqui la url',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#carreraIdId').val(ui.item.id) 
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
$('#fechaAltaId' ).datepicker($.datepicker.regional[ 'es' ]); 
		$('#materiaId').lookupfield({source:'colocar aqui la url',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Prop.Id','Prop 1','Prop 2'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} 
 				,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] 
 				,hiddenid:'materiaIdId' 
 				,descid:'materiaId' 
 				,hiddenfield:'id' 
 				,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); 

		$('#materiaId' ).autocomplete({source: 'colocar aqui la url',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#materiaIdId').val(ui.item.id) 
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
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${inscripcionMateriaInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${inscripcionMateriaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            		<div class="append-bottom">	
                        
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="alumno">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="alumno"><g:message code="inscripcionMateria.alumno.label" default="Alumno" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="alumnoId" name="alumnoDesc"  value="colocar el valor del field descripcion" /> 
 								<g:hiddenField id="alumnoIdId" name="alumno.id" value="${alumno?.id}" />
							</div>
										
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="alumno">
								<g:renderErrors bean="${inscripcionMateriaInstance}" as="list" field="alumno"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="anioLectivo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="anioLectivo"><g:message code="inscripcionMateria.anioLectivo.label" default="Anio Lectivo" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="anioLectivoId" name="anioLectivoDesc"  value="colocar el valor del field descripcion" /> 
 								<g:hiddenField id="anioLectivoIdId" name="anioLectivo.id" value="${anioLectivo?.id}" />
							</div>
										
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="anioLectivo">
								<g:renderErrors bean="${inscripcionMateriaInstance}" as="list" field="anioLectivo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="carrera">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="carrera"><g:message code="inscripcionMateria.carrera.label" default="Carrera" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="colocar el valor del field descripcion" /> 
 								<g:hiddenField id="carreraIdId" name="carrera.id" value="${carrera?.id}" />
							</div>
										
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="carrera">
								<g:renderErrors bean="${inscripcionMateriaInstance}" as="list" field="carrera"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="estado">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="estado"><g:message code="inscripcionMateria.estado.label" default="Estado" /></label>
							</div>
							<div class="span-5">
								<g:select id="estadoId" class="ui-widget ui-corner-all ui-widget-content" name="estado" from="${com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum?.values()}" keys="${com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum?.values()*.name()}" value="${inscripcionMateriaInstance?.estado?.name()}"  optionValue="name"/>
							</div>
										
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="estado">
								<g:renderErrors bean="${inscripcionMateriaInstance}" as="list" field="estado"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="fechaAlta">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="fechaAlta"><g:message code="inscripcionMateria.fechaAlta.label" default="Fecha Alta" /></label>
							</div>
							<div class="span-5">
								<g:textField id="fechaAltaId" class="ui-widget ui-corner-all ui-widget-content" name="fechaAlta" value="${fieldValue(bean: inscripcionMateriaInstance, field: 'fechaAlta')}" />
							</div>
										
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="fechaAlta">
								<g:renderErrors bean="${inscripcionMateriaInstance}" as="list" field="fechaAlta"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="materia">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="materia"><g:message code="inscripcionMateria.materia.label" default="Materia" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="materiaId" name="materiaDesc"  value="colocar el valor del field descripcion" /> 
 								<g:hiddenField id="materiaIdId" name="materia.id" value="${materia?.id}" />
							</div>
										
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="materia">
								<g:renderErrors bean="${inscripcionMateriaInstance}" as="list" field="materia"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="nota">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="nota"><g:message code="inscripcionMateria.nota.label" default="Nota" /></label>
							</div>
							<div class="span-5">
								<g:textField id="notaId" class="ui-widget ui-corner-all ui-widget-content" name="nota" value="${fieldValue(bean: inscripcionMateriaInstance, field: 'nota')}" />
							</div>
										
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="nota">
								<g:renderErrors bean="${inscripcionMateriaInstance}" as="list" field="nota"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="tipo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="tipo"><g:message code="inscripcionMateria.tipo.label" default="Tipo" /></label>
							</div>
							<div class="span-5">
								<g:select id="tipoId" class="ui-widget ui-corner-all ui-widget-content" name="tipo" from="${com.educacion.enums.inscripcion.TipoInscripcionMateria?.values()}" keys="${com.educacion.enums.inscripcion.TipoInscripcionMateria?.values()*.name()}" value="${inscripcionMateriaInstance?.tipo?.name()}"  optionValue="name"/>
							</div>
										
							<g:hasErrors bean="${inscripcionMateriaInstance}" field="tipo">
								<g:renderErrors bean="${inscripcionMateriaInstance}" as="list" field="tipo"/>
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
