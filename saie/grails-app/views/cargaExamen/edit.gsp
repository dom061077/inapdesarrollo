

<%@ page import="com.educacion.academico.CargaExamen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cargaExamen.label', default: 'CargaExamen')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
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
		$('#docenteId').lookupfield({source:'colocar aqui la url',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Prop.Id','Prop 1','Prop 2'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} 
 				,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] 
 				,hiddenid:'docenteIdId' 
 				,descid:'docenteId' 
 				,hiddenfield:'id' 
 				,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); 

		$('#docenteId' ).autocomplete({source: 'colocar aqui la url',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#docenteIdId').val(ui.item.id) 
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
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all append-bottom"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${cargaExamenInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${cargaExamenInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
            	<div class="append-bottom">
                <g:hiddenField name="id" value="${cargaExamenInstance?.id}" />
                <g:hiddenField name="version" value="${cargaExamenInstance?.version}" />
		                
						<g:hasErrors bean="${cargaExamenInstance}" field="carrera">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="carrera"><g:message code="cargaExamen.carrera.label" default="Carrera" /></label>
						</div>
						<div class="span-5">
							<g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="carreraIdId" name="carrera.id" value="${carrera?.id}" />
						</div>
									
						<g:hasErrors bean="${cargaExamenInstance}" field="carrera">
							<g:renderErrors bean="${cargaExamenInstance}" as="list" field="carrera"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${cargaExamenInstance}" field="anioLectivo">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="anioLectivo"><g:message code="cargaExamen.anioLectivo.label" default="Anio Lectivo" /></label>
						</div>
						<div class="span-5">
							<g:textField class="ui-widget ui-corner-all ui-widget-content" id="anioLectivoId" name="anioLectivoDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="anioLectivoIdId" name="anioLectivo.id" value="${anioLectivo?.id}" />
						</div>
									
						<g:hasErrors bean="${cargaExamenInstance}" field="anioLectivo">
							<g:renderErrors bean="${cargaExamenInstance}" as="list" field="anioLectivo"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${cargaExamenInstance}" field="materia">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="materia"><g:message code="cargaExamen.materia.label" default="Materia" /></label>
						</div>
						<div class="span-5">
							<g:textField class="ui-widget ui-corner-all ui-widget-content" id="materiaId" name="materiaDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="materiaIdId" name="materia.id" value="${materia?.id}" />
						</div>
									
						<g:hasErrors bean="${cargaExamenInstance}" field="materia">
							<g:renderErrors bean="${cargaExamenInstance}" as="list" field="materia"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${cargaExamenInstance}" field="docente">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="docente"><g:message code="cargaExamen.docente.label" default="Docente" /></label>
						</div>
						<div class="span-5">
							<g:textField class="ui-widget ui-corner-all ui-widget-content" id="docenteId" name="docenteDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="docenteIdId" name="docente.id" value="${docente?.id}" />
						</div>
									
						<g:hasErrors bean="${cargaExamenInstance}" field="docente">
							<g:renderErrors bean="${cargaExamenInstance}" as="list" field="docente"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${cargaExamenInstance}" field="titulo">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="titulo"><g:message code="cargaExamen.titulo.label" default="Titulo" /></label>
						</div>
						<div class="span-5">
							<g:textField id="tituloId" name="titulo" class="ui-widget ui-corner-all ui-widget-content" value="${cargaExamenInstance?.titulo}" />
						</div>
									
						<g:hasErrors bean="${cargaExamenInstance}" field="titulo">
							<g:renderErrors bean="${cargaExamenInstance}" as="list" field="titulo"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${cargaExamenInstance}" field="modalidad">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="modalidad"><g:message code="cargaExamen.modalidad.label" default="Modalidad" /></label>
						</div>
						<div class="span-5">
							<g:select id="modalidadId" class="ui-widget ui-corner-all ui-widget-content" name="modalidad" from="${com.educacion.enums.examen.ModalidadExamenEnum?.values()}" keys="${com.educacion.enums.examen.ModalidadExamenEnum?.values()*.name()}" value="${cargaExamenInstance?.modalidad?.name()}"  optionValue="name"/>
						</div>
									
						<g:hasErrors bean="${cargaExamenInstance}" field="modalidad">
							<g:renderErrors bean="${cargaExamenInstance}" as="list" field="modalidad"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${cargaExamenInstance}" field="tipo">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="tipo"><g:message code="cargaExamen.tipo.label" default="Tipo" /></label>
						</div>
						<div class="span-5">
							<g:select id="tipoId" class="ui-widget ui-corner-all ui-widget-content" name="tipo" from="${com.educacion.enums.examen.TipoExamenEnum?.values()}" keys="${com.educacion.enums.examen.TipoExamenEnum?.values()*.name()}" value="${cargaExamenInstance?.tipo?.name()}"  optionValue="name"/>
						</div>
									
						<g:hasErrors bean="${cargaExamenInstance}" field="tipo">
							<g:renderErrors bean="${cargaExamenInstance}" as="list" field="tipo"/>
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
