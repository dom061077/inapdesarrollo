

<%@ page import="com.educacion.academico.Requisito" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'requisito.label', default: 'Requisito')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">

        function initsubmit(){
    		var gridData = jQuery("#subrequisitosId").getRowData();
        	var postData = JSON.stringify(gridData);
        	$("#subRequisitosSerializedId").val(postData);
        	
        }

        function bindrequisitos(){
        	var griddata = [];
        	
        	var data = jQuery.parseJSON($("#subRequisitosSerializedId").val());
        	if(data==null)
	        		data=[];
        	for (var i = 0; i < data.length; i++) {
        	    griddata[i] = {};
        	    griddata[i]["id"] = data[i].id;
        	    griddata[i]["codigo"] = data[i].codigo;
        	    griddata[i]["descripcion"] = data[i].descripcion;	        	    	        	    
        	    griddata[i]["estado"] = data[i].estado;
        	    griddata[i]["estadoValue"] = data[i].estadoValue;
        	}

        	for (var i = 0; i <= griddata.length; i++) {
        	    jQuery("#subrequisitosId").jqGrid('addRowData', i + 1, griddata[i]);
        	}
        }
        
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

			$('#claseRequisitosId' ).autocomplete({source: '<%out << createLink(controller:"claseRequisito",action:"listjsonautocomplete")%>',
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
	
			//----subrequisitos---
			jQuery("#subrequisitosId").jqGrid({ 
				url:'listsubrequisitos'
				,editurl:'editsubrequisitos'
				,datatype: "json"
				,width:600
				,rownumbers:true
				,colNames:['Id','Código', 'Descripción','Estado Valor','Estado']
				,colModel:[ 
					{name:'id',index:'id', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
					, {name:'codigo',index:'codigo', width:30,editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
					, {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
					, {name:'estadoValue',index:'estadoValue',hidden:true, width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:false}, sortable:false}						
					, {name:'estado',index:'estado', width:100, align:"left",editable:true,editoptions:{size:30,value:'ESTADOREQUISITO_ACTIVO:Activo;ESTADOREQUISITO_INACTIVO:Inactivo'},edittype:'select'
						,editrules:{required:true}, sortable:false}
				]
				, pager: '#pagerSubrequisitos'
				, sortname: 'id'
				, viewrecords: true, sortorder: "desc"
				, caption:"Subrequisitos",  height:210
			}); 
			
			jQuery("#subrequisitosId").jqGrid('navGrid','#pagerSubrequisitos', {add:true,edit:true,del:true,search:false,refresh:false}, //options 
					{height:280,width:310,reloadAfterSubmit:false
						, recreateForm:true
						,editCaption:'Modificar Subrequisitos'
						, beforeSubmit:function(postData,formId){
							postData.estadoValue = $("#estado").val();
							return [true,'']
						}
					
					}, // edit options 
					{height:280,width:310,reloadAfterSubmit:false
						,recreateForm:true
						,addCaption:'Agregar Subrequisito'
						,beforeSubmit: function(postData,formId){
							postData.estadoValue= $("#estado").val();
							return [true,'']
						}
						,beforeShowForm:function(form){
						}
					}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
				);	
	

        		bindrequisitos();
				
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
            <div class="ui-state-highlight ui-corner-all append-bottom">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${requisitoInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${requisitoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form onSubmit="initsubmit();return true;" method="post" >
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
 								<g:hiddenField id="claseRequisitoIdId" name="claseRequisitoId" value="${requisitoInstance?.claseRequisito?.id}" />
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
										value="${requisitoInstance?.estado?.name()}"  
										optionValue="name"/>
							</div>
										
							<g:hasErrors bean="${requisitoInstance}" field="estado">
								<g:renderErrors bean="${requisitoInstance}" as="list" field="estado"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
						   <fieldset>
						   		<legend>Sub Requisitos</legend>
								<g:hiddenField id="subRequisitosSerializedId" name="subRequisitosSerialized" value="${subRequisitosSerialized}"/>
            				<div class="clear"></div>
                            <div class="span-18">
                            	<table id="subrequisitosId"></table>
                            </div>
                            <div id="pagerSubrequisitos">	</div>						   		
						   </fieldset>
		
																
		            
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
                </div>
            </g:form>
            
        </div>
    </body>
</html>
