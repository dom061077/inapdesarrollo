

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
		<script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>                
		<script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.cascade-select.js')}"></script>
        
 		
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
								<label for="alumno"><g:message code="preinscripcion.alumno.label" default="Alumno:" /></label>
							</div>
							<div class="span-7">
								<g:textField class="ui-widget ui-corner-all ui-widget-content largeinput" id="alumnoId" name="alumnoDesc"  value="${preinscripcionInstance?.alumno?.apellidoNombre}" /> 
 								<g:hiddenField id="alumnoIdId" name="alumno.id" value="${preinscripcionInstance?.alumno?.id}" />
							</div>
										
							<g:hasErrors bean="${preinscripcionInstance}" field="alumno">
								<g:renderErrors bean="${preinscripcionInstance}" as="list" field="alumno"/>
								</div>
						   </g:hasErrors>
						   <div class="span-3"><g:link controller="alumno" action="create">Es tu primera vez?</g:link> </div>
						   <div class="clear"></div>

							<div id="datosAlumnoId" class="hidden">
								<fieldset>
									<legend>Datos del Alumno</legend>
									<div id="datosId">
									</div>
								</fieldset>
								
							</div>				
											
																	
							<g:hasErrors bean="${preinscripcionInstance}" field="nivel">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="carrera"><g:message code="preinscripcion.carrera.label" default="Carrera:" /></label>
							</div>
							<div class="span-10">
								<g:select class="inputlarge" name="carrera" id="carreraId" from="${Carrera.listOrderByDenominacion()}" 
								optionKey="id" optionValue="denominacion" value="${preinscripcionInstance?.nivel?.carrera?.id}"></g:select>
							</div>
										
							<g:hasErrors bean="${preinscripcionInstance}" field="nivel">
								<g:renderErrors bean="${preinscripcionInstance}" as="list" field="nivel"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
						   
							<g:hasErrors bean="${preinscripcionInstance}" field="nivel">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="nivel"><g:message code="preinscripcion.nivel.label" default="Nivel:" /></label>
							</div>
							<div class="span-10">
								<g:select class="inputlarge" from="${niveles}" optionKey="id" optionValue="descripcion" 
								name="nivel.id" id="nivelId" value="${preinscripcionInstance?.nivel?.id}" ></g:select>
							</div>
										
							<g:hasErrors bean="${preinscripcionInstance}" field="nivel">
								<g:renderErrors bean="${preinscripcionInstance}" as="list" field="nivel"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
						   
                        
				</div>                        
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
        
        
        
        <script type="text/javascript">
        	function showdata(){
        		$( "#datosAlumnoId" ).show( 'blind', {}, 500,function(){
        			$.getJSON('<%out << createLink(controller:"alumno",action:"mindatajson")%>', {id:$('#alumnoIdId').val()}, function(response) {
            			var data = 'Apellido y Nombre: <strong>'+response.alumno.apellidoNombre+'</strong></p>'
            					+'<p>Tipo de Documento: <strong>'+response.alumno.tipoDocumento+'</strong></p>'
            					+'<p>Nro. de Documento: <strong>'+response.alumno.documento+'</strong></p>'
            					+'<p>Sexo:				 <strong>'+response.alumno.sexo+'</strong></p>'
            					+'<p>Fecha Nacimiento:	 <strong>'+response.alumno.fechaNacimiento+'</strong></p>';
            			$('#datosId').html(data);
        			});
            	});
            }

            function hidedata(){
            	$( "#datosAlumnoId" ).hide( 'blind', {}, 500 );
            }
			
        	$(document).ready(function(){
        		$('#carreraId').cascade({
                    source: '<%out << createLink(controller:'carrera',action:'cascadeniveles')%>',
                    cascaded: "nivelId"
                });

           		$('#alumnoId').lookupfield({source:'<%out<<createLink(controller:"alumno",action:"listsearchjson")%>',
    				 title:'Buscar Alumno' 
   				,colNames:['Id','D.N.I','Apellido y Nombre'] 
   				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
    				,{name:'numeroDocumento',index:'numeroDocumento',sorttype:'int', width:100,  sortable:true,search:true,searchoptions:{sopt:['eq']}}
    				,{name:'apellidoNombre',index:'apellidoNombre', width:100,  sortable:true,search:true}] 
    				,hiddenid:'alumnoIdId' 
    				,descid:'alumnoId' 
    				,hiddenfield:'id'
        			,onSelected: function(){
            				showdata();
            			} 
    				,onKeyup:function(){
        				if($.trim($('#alumnoId').val())==''){
            				hidedata();	
            			}	
        			}
    				,descfield:['apellidoNombre']}); 

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
                
					if($('#alumnoIdId').val()!=''){
						showdata();
					}	
        	});
		</script>
        
        
    </body>
</html>
