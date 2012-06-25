
<%@ page import="com.educacion.academico.Carrera" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'carrera.label', default: 'Carrera')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
				//----requisitos---
				jQuery("#requisitosId").jqGrid({ 
					url:'<%out << createLink(controller:'carrera',action:'listrequisitos',params:[id:carreraInstance.id])%>'
					,editurl:'editrequisitos'
					,datatype: "json"
					,width:600
					//,rownumbers:true
					,colNames:['Id','Id', 'Descripción']
					,colModel:[ 
						{name:'id',index:'id', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
						, {name:'id',index:'id', width:30,editable:true,hidden:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
						, {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
					]
					//, rowNum:10, rowList:[10,20,30]
					, pager: '#pagerRequisitos'
					, sortname: 'id'
					, viewrecords: true, sortorder: "desc"
					, caption:"Requisitos",  height:210
				}); 

				jQuery("#nivelesId").jqGrid({ 
					url:'<%out << createLink(controller:'carrera',action:'listniveles',params:[id:carreraInstance.id])%>'
					,editurl:'editrequisitos'
					,datatype: "json"
					,width:600
					//,rownumbers:true
					,colNames:['Id','Id', 'Descripción','Es primer nivel value','Nivel Introductorio?']
					,colModel:[ 
						{name:'id',index:'id', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}

						,{name:'id',index:'id', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
						,{name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
						,{name:'esprimernivelvalue',index:'esprimernivelvalue',hidden:true}
						,{name:'esprimernivel',index:'esprimernivel',sortable:false}						
					]
					//, rowNum:10, rowList:[10,20,30]
					, pager: '#pagerNiveles'
					, sortname: 'id'
					, viewrecords: true, sortorder: "desc"
					, caption:"Niveles",  height:210
				}); 

				jQuery("#aniosId").jqGrid({
						url:'<%out << createLink(controller:'carrera',action:'listanios',params:[id:carreraInstance.id])%>'
						,datatype: "json"
						,width:600
						//,rownumbers:true
						,colNames:['Id','Id','Año Lectivo','Cupo','Cupo Suplentes','Costo Matrícula', 'Fecha Inicio','Fecha Fin']
						,colModel:[ 
							{name:'id',index:'id', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
							,{name:'id',index:'id', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}							
							,{name:'anioLectivo',index:'anioLectivo', width:100,editable:true,hidden:false	,editoptions:{readonly:true,size:10}, sortable:false}						
							,{name:'cupo',index:'cupo', width:40, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
							,{name:'cupoSuplentes',index:'cupoSuplentes', width:50, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
							,{name:'costoMatricula',index:'costoMatricula', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
							,{name:'fechaInicio',index:'fechaInicio', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
							,{name:'fechaFin',index:'fechaFin', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
						]
						//, rowNum:10, rowList:[10,20,30]
						, pager: '#pagerAnios'
						, sortname: 'id'
						, viewrecords: true, sortorder: "desc"
						, caption:"Años Lectivos",  height:210

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
            <div class="ui-state-highlight ui-corner-all"><h2>${flash.message}</h2></div>
            </g:if>
            <div class="dialog">
            	<div class="span-16">


                    <div class="span-3 spanlabel">
                        <label><g:message code="carrera.campoOcupacional.label" default="Campo Ocupacional" /></label>
                    </div>
                    <div class="span-5 spanlabel">
                        ${fieldValue(bean: carreraInstance, field: "campoOcupacional")}
                    </div>
                    <div class="clear"></div>


                    <div class="span-3 spanlabel">
                        <label><g:message code="carrera.denominacion.label" default="Denominacion" /></label>
                    </div>
                    <div class="span-5 spanlabel">
                        ${fieldValue(bean: carreraInstance, field: "denominacion")}
                    </div>
                    <div class="clear"></div>


                    <div class="span-3 spanlabel">
                        <label><g:message code="carrera.duracion.label" default="Duracion" /></label>
                    </div>
                    <div class="span-5 spanlabel">
                        ${fieldValue(bean: carreraInstance, field: "duracion")}
                    </div>
                    <div class="clear"></div>


                    <div class="span-3 spanlabel">
                        <label><g:message code="carrera.modalidadFormacion.label" default="Modalidad Formacion" /></label>
                    </div>
                    <div class="span-5 spanlabel">
                        ${carreraInstance?.modalidadFormacion?.name?.encodeAsHTML()}
                    </div>
                    <div class="clear"></div>


                    <div class="span-3 spanlabel">
                        <label><g:message code="carrera.perfilEgresado.label" default="Perfil Egresado" /></label>
                    </div>
                    <div class="span-5 spanlabel">
                        ${fieldValue(bean: carreraInstance, field: "perfilEgresado")}
                    </div>
                    <div class="clear"></div>


                    <div class="span-3 spanlabel">
                        <label><g:message code="carrera.titulo.label" default="Titulo" /></label>
                    </div>
                    <div class="span-5 spanlabel">
                        ${fieldValue(bean: carreraInstance, field: "titulo")}
                    </div>
                    <div class="clear"></div>


                    <div class="span-3 spanlabel">
                        <label><g:message code="carrera.validezTitulo.label" default="Validez Titulo" /></label>
                    </div>
                    <div class="span-5 spanlabel">
                        ${fieldValue(bean: carreraInstance, field: "validezTitulo")}
                    </div>
                    <div class="clear"></div>


				</div>
			   <div class="clear"></div>
			   <div id="tabs">
				   		<ul>
				   			<li><a href="#tabs-requisitos">Requisitos</a></li>
				   			<li><a href="#tabs-niveles">Niveles</a></li>
				   			<li><a href="#tabs-anios">Años Lectivos</a></li>
				   		</ul>
         				<div class="clear"></div>
         				<div id="tabs-requisitos">
                       		<table id="requisitosId"></table>
                         	<div id="pagerRequisitos">	</div>
                         </div>
         				<div id="tabs-niveles">
                       		<table id="nivelesId"></table>
                         	<div id="pagerNiveles">	</div>
                         </div>
         				<div id="tabs-anios">
                       		<table id="aniosId"></table>
                         	<div id="pagerAnios">	</div>
                         </div>						   		
                         						   		
				   </div>
			   </div>                
            <div class="clear"></div>
            <div class="span-16">
                <g:form>
                    <g:hiddenField name="idCarrera" value="${carreraInstance?.id}" />
                    <g:hiddenField name="id" value="${carreraInstance?.id}" />
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" controller="carrera" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" controller="carrera" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
