

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
							<label for="documento"><g:message code="documentoCarrera.documento.label" default="Documento" /></label>
						</div>
						<div class="span-5">
							
						</div>
									
						<g:hasErrors bean="${documentoCarreraInstance}" field="documento">
							<g:renderErrors bean="${documentoCarreraInstance}" as="list" field="documento"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${documentoCarreraInstance}" field="imageExtension">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="imageExtension"><g:message code="documentoCarrera.imageExtension.label" default="Image Extension" /></label>
						</div>
						<div class="span-5">
							<g:textField id="imageExtensionId" name="imageExtension" class="ui-widget ui-corner-all ui-widget-content" value="${documentoCarreraInstance?.imageExtension}" />
						</div>
									
						<g:hasErrors bean="${documentoCarreraInstance}" field="imageExtension">
							<g:renderErrors bean="${documentoCarreraInstance}" as="list" field="imageExtension"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            
						<g:hasErrors bean="${documentoCarreraInstance}" field="carrera">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="carrera"><g:message code="documentoCarrera.carrera.label" default="Carrera" /></label>
						</div>
						<div class="span-5">
							<g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="colocar el valor del field descripcion" /> 
 <g:hiddenField id="carreraIdId" name="carrera.id" value="${carrera?.id}" />
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
