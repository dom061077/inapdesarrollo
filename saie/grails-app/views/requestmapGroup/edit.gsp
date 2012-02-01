

<%@ page import="com.educacion.seguridad.RequestmapGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'requestmapGroup.label', default: 'RequestmapGroup')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
	        function initsubmit(){
	    		var gridData = jQuery("#requestsId").getRowData();
	        	var postData = JSON.stringify(gridData);
	        	$("#requestsSerializedId").val(postData);
	        	return true;
	        }
	
	        function bindrequests(){
	        	var griddata = [];
	        	
	        	var data = jQuery.parseJSON($("#requestsSerializedId").val());
	        	if(data==null)
		        		data=[];
	        	for (var i = 0; i < data.length; i++) {
	        	    griddata[i] = {};
	        	    griddata[i]["id"] = data[i].id;
	        	    griddata[i]["url"] = data[i].url;	        	    	        	    
	        	    griddata[i]["descripcion"] = data[i].descripcion;
	        	}
	
	        	for (var i = 0; i <= griddata.length; i++) {
	        	    jQuery("#requestsId").jqGrid('addRowData', i + 1, griddata[i]);
	        	}
	        }
        
        	$(document).ready(function(){

				//----requests---
				jQuery("#requestsId").jqGrid({ 
					url:'<%out<<createLink(controller:"requestmapGroup",action:"listrequest")%>'
					,editurl:'<%out<<createLink(controller:"requestmapGroup",action:"editrequests")%>'
					,datatype: "json"
					,width:600
					//,rownumbers:true
					,colNames:['Id','URL', 'Descripción']
					,colModel:[ 
						{name:'id',index:'id', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
						, {name:'url',index:'url', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
						, {name:'descripcion',index:'descripcion',hidden:false, width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:false}, sortable:false}						
					]
					, pager: '#pagerRequests'
					, sortname: 'id'
					, viewrecords: true, sortorder: "desc"
					, caption:"URLs"
					, height:140
				}); 
				
				jQuery("#requestsId").jqGrid('navGrid','#pagerRequests', {add:true,edit:true,del:true,search:false,refresh:false}, //options 
						{height:280,width:310,reloadAfterSubmit:false
							, recreateForm:true
							,modal:true
							,editCaption:'Modificar URLs'
							, beforeSubmit:function(postData,formId){
								postData.estadoValue = $("#estado").val();
								return [true,'']
							}
							,beforeShowForm:function(form){
								$('#descripcion').focus();
							},
							bSubmit:'Modificar'
						
						}, // edit options 
						{height:280,width:310,reloadAfterSubmit:false
							,recreateForm:true
							,modal:true
							,addCaption:'Agregar URL'
							,beforeSubmit: function(postData,formId){
								postData.estadoValue= $("#estado").val();
								return [true,'']
							}
							,beforeShowForm:function(form){
								$('#descripcion').focus();
							},
							bSubmit:'Agregar'
						}, // add options 
						{reloadAfterSubmit:false}, // del options 
						{} // search options 
					);
					bindrequests();	
                
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
            <g:hasErrors bean="${requestmapGroupInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${requestmapGroupInstance}" as="list" />
            </div>
            </g:hasErrors>
            <form onsubmit="initsubmit(); " method="post" >
            	<div class="append-bottom">
                <g:hiddenField name="id" value="${requestmapGroupInstance?.id}" />
                <g:hiddenField name="version" value="${requestmapGroupInstance?.version}" />
		                
						<g:hasErrors bean="${requestmapGroupInstance}" field="descripcion">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="descripcion"><g:message code="requestmapGroup.descripcion.label" default="Descripcion" /></label>
						</div>
						<div class="span-5">
							<g:textField id="descripcionId" name="descripcion" class="ui-widget ui-corner-all ui-widget-content" value="${requestmapGroupInstance?.descripcion}" />
						</div>
									
						<g:hasErrors bean="${requestmapGroupInstance}" field="descripcion">
							<g:renderErrors bean="${requestmapGroupInstance}" as="list" field="descripcion"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
					   <fieldset>
					   		<legend>URLs</legend>
							<g:hiddenField id="requestsSerializedId" name="requestsSerialized" value="${requestsSerialized}"/>
           					<div class="clear"></div>
                           <div class="span-18">
                           		<table id="requestsId"></table>
                           </div>
                           <div id="pagerRequests">	</div>						   		
					   </fieldset>

		
																
		            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </form>
        </div>
    </body>
</html>
