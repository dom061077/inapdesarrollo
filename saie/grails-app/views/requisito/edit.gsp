

<%@ page import="com.educacion.academico.Requisito" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'requisito.label', default: 'Requisito')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
        		$('#claseRequisitoId').lookupfield({source:'colocar aqui la url',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Prop.Id','Prop 1','Prop 2'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} 
 				,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] 
 				,hiddenid:'claseRequisitoId' 
 				,descid:'claseRequisitoId' 
 				,hiddenfield:'id' 
 				,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); 

		$('#claseRequisitoId' ).autocomplete({source: 'colocar aqui la url',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#claseRequisitoId').val(ui.item.id) 
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
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all append-bottom">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${requisitoInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${requisitoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
            	<div class="append-bottom">
                <g:hiddenField name="id" value="${requisitoInstance?.id}" />
                <g:hiddenField name="version" value="${requisitoInstance?.version}" />
		                
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
								<g:checkBox name="estado" value="${requisitoInstance?.estado}" />
							</div>
										
							<g:hasErrors bean="${requisitoInstance}" field="estado">
								<g:renderErrors bean="${requisitoInstance}" as="list" field="estado"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
		
																
		            
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
                </div>
            </g:form>
        </div>
    </body>
</html>
