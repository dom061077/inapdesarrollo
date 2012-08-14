

<%@ page import="com.educacion.academico.InscripcionMateria" %>
<%@ page import="com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'inscripcionMateria.label', default: 'InscripcionMateria')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
         
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
		<script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>        
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
            
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
                 var lastSel;
                 var tiposinscripcion = '<%out << TipoInscripcionMateriaEnum.listforselectview()%>';
		        function initsubmit(){
		            var gridDataMaterias = $('#materiasId').getRowData();
		            var postDataMaterias = JSON.stringify(gridDataMaterias);
		            $('#materiasSerializedId').val(postDataMaterias);
		        }
		        
		        function bindmaterias(){
		        	var griddata = [];
		        	
		        	var data = jQuery.parseJSON($("#materiasSerializedId").val());
		        	if(data==null)
			        		data=[];
		        	for (var i = 0; i < data.length; i++) {
		        	    griddata[i] = {};
		        	    /*for (var j = 0; j < data[i].length; j++) {
		        	        griddata[i][names[j]] = data[i][j];
		        	    }*/
		        	    griddata[i]["id"] = data[i].id;
		        	    griddata[i]["idid"] = data[i].idid;	     
		        	    griddata[i]["idmateria"] = data[i].idmateria;
                        griddata[i]["nivel"] = data[i].nivel;
                        griddata[i]["codigomateria"] = data[i].codigomateria;
		        	    griddata[i]["denominacion"] = data[i].denominacion;
                        griddata[i]["tipo"] = data[i].tipo;
                        griddata[i]["tipovalue"] = data[i].tipovalue;
		        	    griddata[i]["seleccion"] = data[i].seleccion;
		        	}
		
		        	for (var i = 0; i <= griddata.length; i++) {
		        	    jQuery("#materiasId").jqGrid('addRowData', i + 1, griddata[i]);
		        	}
		        }
				
		    	$(document).ready(function (){
		        	
		        	$('#materiasId').jqGrid({
		               	datatype:'local'
                        ,editurl:'<%out << createLink(controller:"inscripcionMateria",action:"editmaterias")%>'
		                ,width:500
		                ,colNames:['Id','IdId','Id materia','Nivel','Código Materia','Denominación','Tipo','Tipo Value','Select']
		            	,colModel:[
		                       	{name:'id',index:'id',width:50,editable:false,hidden:true}
		                       	,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:true,editoptions:{readOnly:true,size:10},editrules:{required:false}}
		                       	,{name:'idmateria',index:'idmateria',width:50,hidden:true,sortable:false,editable:true,editoptions:{readOnly:true,size:10},editrules:{required:false}}
                                ,{name:'nivel',index:'nivel',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
                                ,{name:'codigomateria',index:'codigomateria',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
		                       	,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
                                ,{name:'tipo',index:'tipo',sortable:false,width:80,editable:true,edittype:"select"
                                    ,editoptions:{value:tiposinscripcion,readOnly:false,size:40},editrules:{required:true}}
                                ,{name:'tipovalue',index:'tipovalue',hidden:true,editable:true}
		                       	,{ name: 'seleccion', index: 'seleccion',width:60,  formatter: "checkbox", formatoptions: { disabled: false }, editable: true, edittype: "checkbox" }
		           				
		                ]
		            	,sortname:'denominacion'
		                //,pager: '#pagermateriasId'
		            	,sortorder:'asc'
		                ,caption: 'Materias Inscriptas'
                        ,onSelectRow: function(id){
                            if(id && id!==lastSel){
                                $('#materiasId').jqGrid('restoreRow',lastSel);
                                $('#materiasId').jqGrid('editRow',id,true);
                                lastSel=id;
                            }
                            return true;
                        },
                        serializeRowData: function (postData) {
                            //postData.name = postData.name.toUpperCase();
                            postData.tipovalue = postData.tipo;
                            return postData;
                        }

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
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all append-bottom"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${inscripcionMateriaInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${inscripcionMateriaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form name="inscripcionform" onSubmit="initsubmit();return true;" method="post" id="${inscripcionMateriaInstance?.id}" >
            	<div class="append-bottom">
<!--                <g:hiddenField name="id" value="${inscripcionMateriaInstance?.id}"  />-->
                <g:hiddenField name="version" value="${inscripcionMateriaInstance?.version}" />
		                
                            <div class="span-4 spanlabel"><g:message code="inscripcionMateria.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: inscripcionMateriaInstance, field: "id")}</div>
                            
							<div class="clear"></div>
							
                            <div class="span-4 spanlabel"><g:message code="inscripcionMateria.fechaAlta.label" default="Fecha Alta" /></div>
                            
                            <div class="span-4 spanlabel"><g:formatDate format="dd/MM/yyyy" date="${inscripcionMateriaInstance?.fechaAlta}" /></div>
                            
							<div class="clear"></div>
							
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMateria.alumno.label" default="Alumno" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="alumno" action="show" id="${inscripcionMateriaInstance?.alumno?.id}">${inscripcionMateriaInstance?.alumno?.apellido?.encodeAsHTML()+"-"+inscripcionMateriaInstance?.alumno?.nombre?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMateria.carrera.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${inscripcionMateriaInstance?.carrera?.id}">${inscripcionMateriaInstance?.carrera?.denominacion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            
                    		<g:hiddenField id="materiasSerializedId" name="materiasSerialized" value="${materiasSerialized}"/>
                    		<g:hiddenField id="materiasDeletedSerializedId" name="materiasDeletedSerialized"/>	
                    		<fieldset>
                    			<legend>Materias Inscriptas</legend>
                    			<table id="materiasId">
                    			</table>
                    			<div id="pagermateriasId"></div>
                    		</fieldset>	
							<div style="display:none" id="dialogBusquedaMateria">
								<table  id ="busquedaMateriaId"></table>
								<div id="pagerBusquedaMateriaId"></div>
							</div>	
		            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="update" value="${message(code: 'com.educacion.academico.InscripcionMateria.button.confirmar', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.anular.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
