

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
							<div class="span-10">
								<g:select class="inputlarge" name="carrera" id="carreraId" from="${Carrera.list()}" optionKey="id" optionValue="denominacion" ></g:select>
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
        
        
        
        <script type="text/javascript">
			function cargaranios(carreraid){
				$.getJSON("<% out << g.createLink(controller:'carrera',action:'cascade')%>"
						,{carreraid:carreraid,ajax:'true'}
						,function(j){
								var options = '';
								for (var i=0;i<j.length;i++){
									options += '<option value="' + j[i].id + '">' + j[i].label + '</option>';
								}
								$("#anioLectivoId").html(options);
							}
						);
			}
			
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
        	
						//forzamos un evento de cambio para que se carge por primera vez
						$.widget( "ui.combobox", {
							_create: function() {
								var self = this,
									select = this.element.hide(),
									selected = select.children( ":selected" ),
									value = selected.val() ? selected.text() : "";
								var minlength=0;
								if (select[0].name=="localidad.id"){
									minlength=2;
								}		
								var input = this.input = $( "<input class='inputlarge'>" )
									.insertAfter( select )
									.val( value )
									.autocomplete({
										delay: 0,
										minLength: minlength,
										source:function( request, response ) {
											var provinciaid=$('#provinciaId').val();
											/*$.getJSON("<% out << g.createLink(controller:'localidad',action:'listjsonautocomplete')%>"
													,{provinciaid:provinciaid,term:request.term,ajax:'true'}
													,function(j){
															var options = '';
															for (var i=0;i<j.length;i++){
																options += '<option value="' + j[i].id + '">' + j[i].label + '</option>';
															}
															$("#localidadId").html(options);
														}
													);
												*/
											var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
											response( select.children( "option" ).map(function() {
												var text = $( this ).text();
												if ( this.value && ( !request.term || matcher.test(text) ) )
													return {
														label: text.replace(
															new RegExp(
																"(?![^&;]+;)(?!<[^<>]*)(" +
																$.ui.autocomplete.escapeRegex(request.term) +
																")(?![^<>]*>)(?![^&;]+;)", "gi"
															), "<strong>$1</strong>" ),
														value: text,
														option: this
													};
											}) );
										},
										select: function( event, ui ) {
											if (select[0].id=='carreraId'){
												cargaranios(ui.item.option.value);
											}
											
											ui.item.option.selected = true;
											self._trigger( "selected", event, {
												item: ui.item.option
											});
									         //$('#localidadId option[value='+ui.item.option.value+']').attr('selected', 'selected'); 
											
										},
										change: function( event, ui ) {
											if ( !ui.item ) {
												var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
													valid = false;
												select.children( "option" ).each(function() {
													if ( $( this ).text().match( matcher ) ) {
														this.selected = valid = true;
														return false;
													}
												});
												if ( !valid ) {
													// remove invalid value, as it didn't match anything
													$( this ).val( "" );
													select.val( "" );
													input.data( "autocomplete" ).term = "";
													return false;
												}
											}
										}
									})
								.addClass( "ui-widget ui-widget-content ui-corner-left" );

								input.data( "autocomplete" )._renderItem = function( ul, item ) {
									return $( "<li></li>" )
										.data( "item.autocomplete", item )
										.append( "<a>" + item.label + "</a>" )
										.appendTo( ul );
								};

								this.button = $( "<button type='button'>&nbsp;</button>" )
									.attr( "tabIndex", -1 )
									.attr( "title", "Show All Items" )
									.insertAfter( input )
									.button({
										icons: {
											primary: "ui-icon-triangle-1-s"
										},
										text: false
										
									})
									.removeClass( "ui-corner-all" )
									.addClass( "ui-corner-right ui-button-icon-only" )
									.click(function() {
										// close if already visible
										if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
											input.autocomplete( "close" );
											return;
										}

										// pass empty string as value to search for, displaying all results
										input.autocomplete( "search", "" );
										input.focus();
									});
							},

							destroy: function() {
								this.input.remove();
								this.button.remove();
								this.element.show();
								$.Widget.prototype.destroy.call( this );
							}
						});
						$('#carreraId').combobox();
						$('#nivelId').combobox();
	
        	});
		</script>
        
        
    </body>
</html>
