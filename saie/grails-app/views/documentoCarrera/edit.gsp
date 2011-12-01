

<%@ page import="com.educacion.academico.DocumentoCarrera" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentoCarrera.label', default: 'DocumentoCarrera')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'thickbox.js')}"></script>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'css',file:'thickbox.css')}" />
                 
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        
        	$(document).ready(function(){
        /*		$('#carreraId').lookupfield({source:'colocar aqui la url',
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
  				}); */
//---------------------------------- 
    	$('.cambiarlink').live('click',function(){
	    	if($(this).attr('inputactivo')=='false'){
		    	$(this).attr('inputactivo','true');
		    	var link = $(this);
		    	$('#image').fadeOut(function(){
		    		$('#inputimage').fadeIn('slow',function(){
		    			link.html('Cancelar');
			    	});
		    				
			    });
		    }else{
		    	$(this).attr('inputactivo','false');
		    	var link = $(this);
		    	$('#inputimage').fadeOut(function(){
			    	$('#image').fadeIn('slow',function(){
			    		link.html('Cambiar Imagen');
				    });
			    	
			    });
			}
    	});

		$('#inputimage').hide();
		//---------------------------------- 
    	$('.cambiarlinkdocumento').live('click',function(){
	    	if($(this).attr('inputactivo')=='false'){
		    	$(this).attr('inputactivo','true');
		    	var link = $(this);
		    	$('#documento').fadeOut(function(){
		    		$('#inputdocumento').fadeIn('slow',function(){
		    			link.html('Cancelar');
			    	});
		    				
			    });
		    }else{
		    	$(this).attr('inputactivo','false');
		    	var link = $(this);
		    	$('#inputdocumento').fadeOut(function(){
			    	$('#documento').fadeIn('slow',function(){
			    		link.html('Cambiar Documento');
				    });
			    	
			    });
			}
    	});

		$('#inputdocumento').hide();
		

        	});
		</script>
        
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all append-bottom"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${documentoCarreraInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${documentoCarreraInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
            	<div class="append-bottom">
                <g:hiddenField name="id" value="${documentoCarreraInstance?.id}" />
                <g:hiddenField name="version" value="${documentoCarreraInstance?.version}" />
		                
						<g:hasErrors bean="${documentoCarreraInstance}" field="documento">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						<div class="span-3 spanlabel">
							<label for="archivodocumento"><g:message code="documentoCarrera.documento.label" default="Documento" /></label>
						</div>
            			<div id="documento" class="span-5 spanlabel">
            					<a href="${g.resource(dir:grailsApplication.config.documentocarrerafolder,file:documentoCarreraInstance?.id?.toString()+'.pdf')}">${documentoCarreraInstance?.nombreOriginalDocumento}</a>
            			</div>
						<div id="inputdocumento" class="span-5">                    
                                    <input class="ui-widget ui-corner-all ui-widget-content" type="file" name="archivodocumento" />
            			</div>
            			<div  class="span-4 spanlabel">
            					<span>
            						<a  class="cambiarlinkdocumento" inputactivo="false" href="" onclick="return false;">Cambiar Documento</a>
            					</span>
            			</div>
						<g:hasErrors bean="${documentoCarreraInstance}" field="documento">
							<g:renderErrors bean="${documentoCarreraInstance}" as="list" field="documento"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
                   		<div class="span-3 spanlabel">            	
                                    <label for="imagen"><g:message code="documentoCarrera.imagen.label" default="Imagen" /></label>
						</div>
            			<div id="image" class="span-5 spanlabel">
            					<a class="thickbox" href="${g.resourceimgext(size:'large', bean:documentoCarreraInstance)}"><img src="${g.resourceimgext(size:'small', bean:documentoCarreraInstance)}"  alt=""> </img></a>
            			</div>
						<div id="inputimage" class="span-5">                    
                                    <input class="ui-widget ui-corner-all ui-widget-content" type="file" name="imagen" />
            			</div>
            			<div  class="span-4 spanlabel">
            					<span>
            						<a  class="cambiarlink" inputactivo="false" href="" onclick="return false;">Cambiar Imagen</a>
            					</span>
            			</div>
					   <div class="clear"></div>						   
		
																
		            
						<g:hasErrors bean="${documentoCarreraInstance}" field="carrera">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="carrera"><g:message code="documentoCarrera.carrera.label" default="Carrera" /></label>
						</div>
						<div class="span-7 spanlabel">
<!--							<g:textField class="ui-widget ui-corner-all ui-widget-content largeinput" id="carreraId" name="carreraDesc"  value="${documentoCarreraInstance?.carrera?.denominacion}" /> -->
<!-- 							<g:hiddenField id="carreraIdId" name="carrera.id" value="${documentoCarreraInstance?.carrera?.id}" />-->
								${documentoCarreraInstance?.carrera?.denominacion}
						</div>
						<g:hasErrors bean="${documentoCarreraInstance}" field="carrera">
							<g:renderErrors bean="${documentoCarreraInstance}" as="list" field="carrera"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
