

<%@ page import="com.educacion.academico.AsignaturaDocente" %>
<%@ page import="com.educacion.academico.Carrera" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.extend.ui.js')}"></script>
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
                /*
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
  				});  */

//---------------------------------- 
                $('#fechaAltaId' ).datepicker({changeYear:true});
                $('#carreraId').combobox({
                    onSelect: function(event,ui){
                        //$('#anioLectivoId').reloadcmb(params){
                    }
                });
                $('#anioLectivoId').combobox({
                    reload:{
                        url:'<%out << createLink(controller:"carrera",action:"anioslectivos")%>'
                        ,params:{
                            carreraId:'<%out << asignaturaDocenteInstance?.carrera?.id%>'
                        }
                    }
                });

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
            <g:hasErrors bean="${asignaturaDocenteInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${asignaturaDocenteInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            		<div class="append-bottom">	
                        
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="carrera">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="carrera"><g:message code="asignaturaDocente.carrera.label" default="Carrera" /></label>
							</div>
							<div class="span-5">
								<!--g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="colocar el valor del field descripcion" /-->
                                <!--g:hiddenField id="carreraIdId" name="carrera.id" value="${carrera?.id}" /-->
                                <g:select id="carreraId" name="carrera.id"
                                        from="${Carrera.list()}" optionKey="id" optionValue="denominacion"
                                />
							</div>
										
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="carrera">
								<g:renderErrors bean="${asignaturaDocenteInstance}" as="list" field="carrera"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="anioLectivo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="anioLectivo"><g:message code="asignaturaDocente.anioLectivo.label" default="Anio Lectivo" /></label>
							</div>
							<div class="span-5">
								<!-- g:textField class="ui-widget ui-corner-all ui-widget-content" id="anioLectivoId" name="anioLectivoDesc"  value="colocar el valor del field descripcion" / -->
                                <!-- g:hiddenField id="anioLectivoIdId" name="anioLectivo.id" value="${anioLectivo?.id}" / -->
                                <g:select id="anioLectivoId" name="anioLectivo.id"></g:select>
							</div>
										
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="anioLectivo">
								<g:renderErrors bean="${asignaturaDocenteInstance}" as="list" field="anioLectivo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="docente">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="docente"><g:message code="asignaturaDocente.docente.label" default="Docente" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="docenteId" name="docenteDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="docenteIdId" name="docente.id" value="${docente?.id}" />
							</div>
										
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="docente">
								<g:renderErrors bean="${asignaturaDocenteInstance}" as="list" field="docente"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="fechaAlta">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="fechaAlta"><g:message code="asignaturaDocente.fechaAlta.label" default="Fecha Alta" /></label>
							</div>
							<div class="span-5">
								<g:textField id="fechaAltaId" class="ui-widget ui-corner-all ui-widget-content" name="fechaAlta" value="${fieldValue(bean: asignaturaDocenteInstance, field: 'fechaAlta')}" />
							</div>
										
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="fechaAlta">
								<g:renderErrors bean="${asignaturaDocenteInstance}" as="list" field="fechaAlta"/>
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
