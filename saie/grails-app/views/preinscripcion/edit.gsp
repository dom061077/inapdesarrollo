

<%@ page import="com.educacion.academico.Preinscripcion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'preinscripcion.label', default: 'Preinscripcion')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
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
$('#fechaAltaId' ).datepicker($.datepicker.regional[ 'es' ]); 

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
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all append-bottom"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${preinscripcionInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${preinscripcionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
            	<div class="append-bottom">
                <g:hiddenField name="id" value="${preinscripcionInstance?.id}" />
                <g:hiddenField name="version" value="${preinscripcionInstance?.version}" />
		                
						<g:hasErrors bean="${preinscripcionInstance}" field="alumno">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="alumno"><g:message code="preinscripcion.alumno.label" default="Alumno" /></label>
						</div>
						<div class="span-6 spanlabel">
								${preinscripcionInstance.alumno.apellido + ', ' + preinscripcionInstance.alumno.nombre}
<!--							<g:textField class="ui-widget ui-corner-all ui-widget-content" id="alumnoId" name="alumnoDesc"  value="colocar el valor del field descripcion" /> -->
<!-- 							<g:hiddenField id="alumnoIdId" name="alumno.id" value="${alumno?.id}" />-->
						</div>

						<g:hasErrors bean="${preinscripcionInstance}" field="alumno">
							<g:renderErrors bean="${preinscripcionInstance}" as="list" field="alumno"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>


						<div class="span-3 spanlabel">
							<label for="alumno"><g:message code="alumno.numeroDocumento.label" default="Alumno" /></label>
						</div>
						<div class="span-5 spanlabel">
								${preinscripcionInstance.alumno.numeroDocumento}
						</div>
					   <div class="clear"></div>
																
		            
						<g:hasErrors bean="${preinscripcionInstance}" field="anioLectivo">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="anioLectivo"><g:message code="preinscripcion.anioLectivo.label" default="Anio Lectivo" /></label>
						</div>
						<div class="span-5 spanlabel">
							${preinscripcionInstance.anioLectivo.anioLectivo}
						</div>
									
						<g:hasErrors bean="${preinscripcionInstance}" field="anioLectivo">
							<g:renderErrors bean="${preinscripcionInstance}" as="list" field="anioLectivo"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${preinscripcionInstance}" field="estado">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="estado"><g:message code="preinscripcion.estado.label" default="Estado" /></label>
						</div>
						<div class="span-5">
                            <%-- com.medfire.enums.EstadoEvent?.list().findAll{it!=com.medfire.enums.EstadoEvent.EVENT_ATENDIDO} --%>
							<g:select id="estadoId" class="ui-widget ui-corner-all ui-widget-content" name="estado" 
                                      from="${com.educacion.enums.inscripcion.EstadoPreinscripcion?.list().findAll{(it==com.educacion.enums.inscripcion.EstadoPreinscripcion.ESTADO_PREINSCIRPTOANULADO || it==preinscripcionInstance?.estado)}}"
                                      value="${preinscripcionInstance?.estado?.name()}"  optionValue="name"/>
						</div>
									
						<g:hasErrors bean="${preinscripcionInstance}" field="estado">
							<g:renderErrors bean="${preinscripcionInstance}" as="list" field="estado"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${preinscripcionInstance}" field="fechaAlta">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="fechaAlta"><g:message code="preinscripcion.fechaAlta.label" default="Fecha Alta" /></label>
						</div>
						<div class="span-5 spanlabel">
							<g:formatDate format="dd/MM/yyyy" date="${preinscripcionInstance?.fechaAlta}"/>
						</div>
									
						<g:hasErrors bean="${preinscripcionInstance}" field="fechaAlta">
							<g:renderErrors bean="${preinscripcionInstance}" as="list" field="fechaAlta"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
