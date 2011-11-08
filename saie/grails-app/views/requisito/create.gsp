

<%@ page import="com.educacion.academico.Requisito" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'requisito.label', default: 'Requisito')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
        		$('#claseRequisitoId').lookupfield({source:'<%out << createLink(controller:"claseRequisito",action:"listsearchjson")%>',
 				 title:'Clase de Requisito' 
				,colNames:['Id','Código','Descripción'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'codigo',index:'codigo', width:100,  sortable:true,search:true} 
 				,{name:'descripcion',index:'descripcion', width:100,  sortable:true,search:true}] 
 				,hiddenid:'claseRequisitoIdId' 
 				,descid:'claseRequisitoId' 
 				,hiddenfield:'id' 
 				,descfield:['codigo','descripcion']}); 

		$('#claseRequisitoId' ).autocomplete({source: '<%out << createLink(controller:"claseRequisito",action:"listjsonautocomplete")%>',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#claseRequisitoIdId').val(ui.item.id) 
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
            <div class="ui-state-highlight ui-corner-all">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${requisitoInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${requisitoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            		<div class="append-bottom">	
                        
							<g:hasErrors bean="${requisitoInstance}" field="codigo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="codigo"><g:message code="requisito.codigo.label" default="Codigo" /></label>
							</div>
							<div class="span-5">
								<g:textField name="codigo" id="codigoId" class="ui-widget ui-corner-all ui-widget-content" value="${requisitoInstance?.codigo}" />
							</div>
										
							<g:hasErrors bean="${requisitoInstance}" field="codigo">
								<g:renderErrors bean="${requisitoInstance}" as="list" field="codigo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${requisitoInstance}" field="descripcion">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="descripcion"><g:message code="requisito.descripcion.label" default="Descripcion" /></label>
							</div>
							<div class="span-5">
								<g:textField name="descripcion" id="descripcionId" class="ui-widget ui-corner-all ui-widget-content" value="${requisitoInstance?.descripcion}" />
							</div>
										
							<g:hasErrors bean="${requisitoInstance}" field="descripcion">
								<g:renderErrors bean="${requisitoInstance}" as="list" field="descripcion"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${requisitoInstance}" field="claseRequisito">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="claseRequisito"><g:message code="requisito.claseRequisito.label" default="Clase Requisito" /></label>
							</div>
							<div class="span-7">
								<g:textField class="ui-widget ui-corner-all ui-widget-content searchinput" id="claseRequisitoId" name="claseRequisitoDesc"  value="${requisitoInstance?.claseRequisito?.descripcion}" /> 
 								<g:hiddenField id="claseRequisitoIdId" name="claseRequisito.id" value="${requisitoInstance?.claseRequisito?.id}" />
							</div>
										
							<g:hasErrors bean="${requisitoInstance}" field="claseRequisito">
								<g:renderErrors bean="${requisitoInstance}" as="list" field="claseRequisito"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${requisitoInstance}" field="estado">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="estado"><g:message code="requisito.estado.label" default="Estado" /></label>
							</div>
							<div class="span-5">
								<g:select id="tipoDocumentoId" class="ui-widget ui-corner-all ui-widget-content" name="estado" 
										from="${com.educacion.enums.EstadoRequisitoEnum?.values()}" 
										keys="${com.educacion.enums.EstadoRequisitoEnum?.values()*.name()}" 
										value="${alumnoInstance?.estado?.name()}"  
										optionValue="name"/>
							</div>
										
							<g:hasErrors bean="${requisitoInstance}" field="estado">
								<g:renderErrors bean="${requisitoInstance}" as="list" field="estado"/>
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
