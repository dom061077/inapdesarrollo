
<%@ page import="com.educacion.academico.Materia" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'materia.label', default: 'Materia')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript">
        	$(document).ready(function(){
        		$("#matregcursarId").jqGrid({ 
        			url:'<%out << createLink(controller:"materia",action:"listmatregcursar",params:[id:materiaInstance.id])%>'
        			,datatype: "json"
        			,width:600
        			,rownumbers:true
        			,colNames:['Id','Denominación','Nivel','Carrera']
        			,colModel:[ 
        				{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
        				, {name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        				, {name:'nivel',index:'nivel', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        				, {name:'carrera',index:'carrera', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        							
        			]
        			//, rowNum:10, rowList:[10,20,30]
        			, pager: '#pagermatregcursarId'
        			, sortname: 'id'
        			, viewrecords: true, sortorder: "desc"
        			, caption:"Materias Regulares para Cursar"  
        			, height:130
        		});

        		$("#mataprobcursarId").jqGrid({ 
        			url:'<%out << createLink(controller:"materia",action:"listmataprobcursar",params:[id:materiaInstance.id])%>'
        			,datatype: "json"
        			,width:600
        			,rownumbers:true
        			,colNames:['Id','Denominación','Nivel','Carrera']
        			,colModel:[ 
        				{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
        				, {name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        				, {name:'nivel',index:'nivel', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        				, {name:'carrera',index:'carrera', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        							
        			]
        			//, rowNum:10, rowList:[10,20,30]
        			, pager: '#pagermatregcursarId'
        			, sortname: 'id'
        			, viewrecords: true, sortorder: "desc"
        			, caption:"Materias Regulares para Cursar"  
        			, height:130
        		}); 

        		$("#matregrendirId").jqGrid({ 
        			url:'<%out << createLink(controller:"materia",action:"listmatregrendir",params:[id:materiaInstance.id])%>'
        			,datatype: "json"
        			,width:600
        			,rownumbers:true
        			,colNames:['Id','Denominación','Nivel','Carrera']
        			,colModel:[ 
        				{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
        				, {name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        				, {name:'nivel',index:'nivel', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        				, {name:'carrera',index:'carrera', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        							
        			]
        			//, rowNum:10, rowList:[10,20,30]
        			, pager: '#pagermatregcursarId'
        			, sortname: 'id'
        			, viewrecords: true, sortorder: "desc"
        			, caption:"Materias Regulares para Cursar"  
        			, height:130
        		}); 

        		$("#mataprobrendirId").jqGrid({ 
        			url:'<%out << createLink(controller:"materia",action:"listmataprobrendir",params:[id:materiaInstance.id])%>'
        			,datatype: "json"
        			,width:600
        			,rownumbers:true
        			,colNames:['Id','Denominación','Nivel','Carrera']
        			,colModel:[ 
        				{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
        				, {name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        				, {name:'nivel',index:'nivel', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        				, {name:'carrera',index:'carrera', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        							
        			]
        			//, rowNum:10, rowList:[10,20,30]
        			, pager: '#pagermatregcursarId'
        			, sortname: 'id'
        			, viewrecords: true, sortorder: "desc"
        			, caption:"Materias Regulares para Cursar"  
        			, height:130
        		}); 

        		
        		 
            	$('#tabs').tabs();
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
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <div class="dialog">
                            <div class="span-4 spanlabel"><g:message code="materia.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: materiaInstance, field: "id")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.codigo.label" default="Codigo" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: materiaInstance, field: "codigo")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.denominacion.label" default="Denominacion" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: materiaInstance, field: "denominacion")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.descripcion.label" default="Descripcion" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: materiaInstance, field: "descripcion")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.duracion.label" default="Duracion" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="duracionMateria" action="show" id="${materiaInstance?.duracion?.id}">${materiaInstance?.duracion?.descripcion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="materia.estado.label" default="Estado" /></div>
                            
                            <div class="span-4 spanlabel">${materiaInstance?.estado?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
							
                            <div class="span-4 spanlabel"><g:message code="materia.nivel.carrera.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${materiaInstance?.nivel?.carrera?.id}">${materiaInstance?.nivel?.carrera?.denominacion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
							
                    
                            <div class="span-4 spanlabel"><g:message code="materia.nivel.label" default="Nivel" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${materiaInstance?.nivel?.carrera?.id}">${materiaInstance?.nivel?.descripcion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                    
                            <div class="span-4 spanlabel"><g:message code="materia.tipo.label" default="Tipo" /></div>
                            
                            <div class="span-4 spanlabel">${materiaInstance?.tipo?.name?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
						   <div id="tabs">
						   		<ul>
						   			<li><a href="#tabs-matregcursar">Mat. Regulares para Cursar</a></li>
						   			<li><a href="#tabs-mataprobcursar">Mat. Aprobadas para Cursar</a></li>
						   			<li><a href="#tabs-matregrendir">Mat. Regulares para Rendir</a></li>
						   			<li><a href="#tabs-mataprobrendir">Mat. Aprobadas para Rendir</a></li>
						   		</ul>
						   		<div id="tabs-matregcursar">
						   			<table id="matregcursarId"></table>
						   			<div id="pagermatregcursarId"></div>
						   		</div>

						   		<div id="tabs-mataprobcursar"> 
						   			<table id="mataprobcursarId"></table>
						   			<div id="pagermataprobcursarId"></div>
						   		</div>

						   		
						   		<div id="tabs-matregrendir">
						   			<table id="matregrendirId"></table>
						   			<div id="pagermatregrendirId"></div>
						   		</div>
						   		
						   		
						   		<div id="tabs-mataprobrendir">
						   			<table id="mataprobrendirId"></table>
						   			<div id="pagermataprobrendirId"></div>
						   		</div>
						   </div>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${materiaInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
