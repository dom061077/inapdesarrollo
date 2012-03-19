
<%@ page import="com.educacion.academico.InscripcionMateria" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'inscripcionMateria.label', default: 'InscripcionMateria')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
		<script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>        
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript">
        	$(document).ready(function (){
            	$('#materiasId').jqGrid({
                	url:'<%out<< g.createLink(controller:"inscripcionMateria",action:"listjsonmaterias",params:[id:inscripcionMateriaInstance.id])%>'
                   	,datatype:'json'
                    ,width:650
                    ,colNames:['Id','IdId','Denominación','Estado Insc.','Tipo Insc.','Nota']
                	,colModel:[
                           	{name:'id',index:'id',width:50,editable:false,hidden:true}
                           	,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}}
                           	,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:true,editoptions:{readOnly:true,size:120},editrules:{required:false}}
                           	,{name:'estado',index:'estado',width:120,editable:true,sortable:false
                               		,editoptions:{readOnly:false,size:40
                                   					,value:'ESTADOINSMAT_INSCRIPTO:Inscripto;ESTADOINSMAT_REGULAR:Regular;ESTADOINSMAT_APROBADA:Aprobada;ESTADOINSMAT_DESAPROBADA:Desaprobada;ESTADOINSMAT_AUSENTE:Ausente'
                                       			 }
                           	}
                           	,{name:'tipo',index:'tipo',width:120,editable:true,sortable:false,editoptions:{readOnly:true,size:120},editrules:{required:false}}
               				,{name:'nota',index:'nota',width:30,editable:true,sortable:false,editoptions:{readOnly:true,size:20},editrules:{required:false}}
                    ]
                	,sortname:'denominacion'
                	,sortorder:'asc'
                    ,caption: 'Materias Inscriptas'
                });
            });
            
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body append-bottom">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMateria.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: inscripcionMateriaInstance, field: "id")}</div>
                            
							<div class="clear"></div>
							
                            <div class="span-4 spanlabel"><g:message code="inscripcionMateria.fechaAlta.label" default="Fecha Alta" /></div>
                            
                            <div class="span-4 spanlabel"><g:formatDate format="dd/MM/yyyy" date="${inscripcionMateriaInstance?.fechaAlta}" /></div>
                            
							<div class="clear"></div>
							
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMateria.alumno.label" default="Alumno" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="alumno" action="show" id="${inscripcionMateriaInstance?.alumno?.id}">${inscripcionMateriaInstance?.alumno?.apellidoNombre?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
<!--                            <div class="span-4 spanlabel"><g:message code="inscripcionMateria.anioLectivo.label" default="Anio Lectivo" /></div>-->
<!--                            -->
<!--                            <div class="span-4 spanlabel"><g:link controller="anioLectivo" action="show" id="${inscripcionMateriaInstance?.anioLectivo?.id}">${inscripcionMateriaInstance?.anioLectivo?.encodeAsHTML()}</g:link></div>-->
<!--                            -->
<!--							<div class="clear"></div>-->
                    
                            <div class="span-4 spanlabel"><g:message code="inscripcionMateria.carrera.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${inscripcionMateriaInstance?.carrera?.id}">${inscripcionMateriaInstance?.carrera?.denominacion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            
                    			
                    		<fieldset>
                    			<legend>Materias Inscriptas</legend>
                    			<table id="materiasId">
                    			</table>
                    			<div id=""pagermateriasId></div>
                    		</fieldset>	
                    
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="idIns" value="${inscripcionMateriaInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
