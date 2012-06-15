
<%@ page import="com.educacion.academico.Preinscripcion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'preinscripcion.label', default: 'Preinscripcion')}" />
        <title><g:message code="preinscripcion.confirminscripcion.title"/></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript">
	        function initsubmit(){
	    		var gridDataMaterias = $("#materiasId").getRowData();
	        	var postDataMaterias = JSON.stringify(gridDataMaterias);
	        	$("#materiasSerializedId").val(postDataMaterias);
	        }

	        function checkboxsave(){
	        	$('#materiasId').saveRow('"+rowObject.id+"'); 
		    }
        
        	$(document).ready(function(){
            	function savecheckbox(cellvalue, options, rowObject){
            		return '<input type="checkbox"' + (cellvalue ? ' checked="checked"' : '') + 
            	      "onclick=\"checkboxsave()\"/>";
               	}

    	        function bindmaterias(){
    	        	var griddata = [];
    	        	
    	        	var data = jQuery.parseJSON($("#materiasSerializedId").val());
    	        	if(data==null)
    		        		data=[];
    	        	for (var i = 0; i < data.length; i++) {
    	        	    griddata[i] = {};
    	        	    griddata[i]['id'] = data[i].id;
    	        	    griddata[i]['idid'] = data[i].idid;	        	    
    	        	    griddata[i]['denominacion'] = data[i].denominacion;
    	        	    griddata[i]['seleccion'] = data[i].seleccion;	        	    	        	    
    	        	}

    	        	for (var i = 0; i <= griddata.length; i++) {
    	        	    jQuery("#materiasId").jqGrid('addRowData', i + 1, griddata[i]);
    	        	}
    	        }
    	        

            	var lastsel2;
	        	$('#materiasId').jqGrid({
	            	url:''//url:'<%out << createLink(controller:"preinscripcion",action:"materiasmatriculacion",id:preinscripcionInstance.id)%>'
	               	,datatype:'local'
	                ,width:500
	                ,colNames:['Id','IdId','Denominación','Select']
	            	,colModel:[
	                       	{name:'id',index:'id',width:50,editable:false,hidden:true}
	                       	,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:false,editoptions:{readOnly:true,size:10},editrules:{required:false}}
	                       	,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
	                       	,{ name: 'seleccion', index: 'seleccion',width:10,  formatter: "checkbox", formatoptions: { disabled: false }, editable: true, edittype: "checkbox" }
               				
	                ]
	        		,onSelectRow: function(id){ 
		        			if(id && id!==lastsel2){ 
			        				$('#materiasId').jqGrid('restoreRow',lastsel2); 
			        				$('#materiasId').jqGrid('editRow',id,true); 
			        				lastsel2=id; 
			        		} 
			        }
	            	,sortname:'denominacion'
	                //,pager: '#pagermateriasId'
	            	,sortorder:'asc'
	                ,caption: 'Materias a Inscribir'
	            });
	            bindmaterias();
	
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
            <h1><g:message code="preinscripcion.confirminscripcion.title"/></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            
            <g:hasErrors bean="${preinscripcionInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${preinscripcionInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            <g:hasErrors bean="${preinscripcionInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${preinscripcionInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            <g:hasErrors bean="${inscripcionMatriculaInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${inscripcionMatriculaInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            
            
            <div class="dialog">
                            <div class="span-4 spanlabel"><g:message code="preinscripcion.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: preinscripcionInstance, field: "id")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="preinscripcion.alumno.label" default="Alumno:" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="alumno" action="show" id="${preinscripcionInstance?.alumno?.id}">${preinscripcionInstance?.alumno?.apellidoNombre?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="preinscripcion.carrera.label" default="Carrera:" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${preinscripcionInstance?.carrera?.id}">${preinscripcionInstance?.carrera?.denominacion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="preinscripcion.anioLectivo.label" default="Nivel:" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${preinscripcionInstance?.carrera?.id}">${preinscripcionInstance?.anioLectivo?.anioLectivo?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="preinscripcion.estado.label" default="Estado:" /></div>
                            
                            <div class="span-4 spanlabel">${preinscripcionInstance?.estado?.name?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="preinscripcion.fechaAlta.label" default="Fecha Alta:" /></div>
                            
                            <div class="span-4 spanlabel"><g:formatDate format='dd/MM/yyyy' date="${preinscripcionInstance?.fechaAlta}" /></div>
                            
							<div class="clear"></div>
							<fieldset>
								<legend>Materias a Inscribir</legend>
								<table id='materiasId'></table>
								<div id = 'pagermateriasId'></div>
							</fieldset>
            </div>
            <div class="buttons">
                <g:form onsubmit="initsubmit();return true;">
					<g:hiddenField id='materiasSerializedId' name='materiasSerialized' value="${materiasSerialized}"></g:hiddenField>
                    <g:hiddenField name="insid" value="${preinscripcionInstance?.id}" />
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="confirminscripcion" value="${message(code: 'preinscripcion.button.matricular', default: 'Ins')}" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
