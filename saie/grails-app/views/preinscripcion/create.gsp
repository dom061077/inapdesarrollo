

<%@ page import="com.educacion.academico.Preinscripcion"
  @ page import="com.educacion.academico.Carrera"	
 %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'preinscripcion.label', default: 'Preinscripcion')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
                
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.cascade.js')}"></script>        
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.cascade.ext.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.templating.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
        		$('#alumnoId').lookupfield({source:'<%out<<createLink(controller:"alumno",action:"listsearchjson")%>',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Id','D.N.I','Apellido y Nombre'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'numeroDocumento',index:'numeroDocumento',sorttype:'int', width:100,  sortable:true,search:true,searchoptions:{sopt:['eq']}}
 				,{name:'apellidoNombre',index:'apellidoNombre', width:100,  sortable:true,search:true}] 
 				,hiddenid:'alumnoIdId' 
 				,descid:'alumnoId' 
 				,hiddenfield:'id' 
 				,descfield:['numeroDocumento','apellidoNombre']}); 

		$('#alumnoId' ).autocomplete({source: '<%out<<createLink(controller:"alumno",action:"listjsonautocomplete")%>',
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
										
							<g:hasErrors bean="${preinscripcionInstance}" field="anioLectivo">
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>


                        
							<g:hasErrors bean="${preinscripcionInstance}" field="anioLectivo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="anioLectivo"><g:message code="preinscripcion.anioLectivo.label" default="Anio Lectivo" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="anioLectivoId" name="anioLectivoDesc"  value="colocar el valor del field descripcion" /> 
 								<g:hiddenField id="anioLectivoIdId" name="anioLectivo.id" value="${anioLectivo?.id}" />
							</div>
										
							<g:hasErrors bean="${preinscripcionInstance}" field="anioLectivo">
								<g:renderErrors bean="${preinscripcionInstance}" as="list" field="anioLectivo"/>
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
