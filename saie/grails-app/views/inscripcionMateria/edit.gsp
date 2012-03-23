

<%@ page import="com.educacion.academico.InscripcionMateria" %>
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
        var arrayDeletedMaterias = [];

        function initsubmit(){
            var gridDataMaterias = $('#materiasId').getRowData();
            var postDataMaterias = JSON.stringify(gridDataMaterias);
            $('#materiasSerializedId').val(postDataMaterias);
            $("#materiasDeletedSerializedId").val(JSON.stringify(arrayDeletedMaterias));
           
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
        	    griddata[i]["idDet"] = data[i].id;
        	    griddata[i]["idid"] = data[i].idid;	        	    
        	    griddata[i]["denominacion"] = data[i].denominacion;	        	    	        	    
        	    griddata[i]["estadovalue"] = data[i].estadovalue;
        	    griddata[i]["estado"] = data[i].estado;
        	    griddata[i]["tipovalue"] = data[i].tipovalue;
        	    griddata[i]["tipo"] = data[i].tipo;
        	    //griddata[i]["nota"] = data[i].nota;
        	}

        	for (var i = 0; i <= griddata.length; i++) {
        	    jQuery("#materiasId").jqGrid('addRowData', i + 1, griddata[i]);
        	}
        }
		
    	$(document).ready(function (){
			$('#busquedaMateriaId').jqGrid({
				url:'<%out << g.createLink(controller:"materia",action:"listjson")%>'
				,datatype:'json'
				,width:400
				,colNames:['Id','Denominación','Nivel','Carrera']
				,colModel:[
							{name:'id',index:'id',width:50,hidden:true}
							,{name:'denominacion',index:'denominacion',width:100,sortable:true,search:true}
							,{name:'nivel_descripcion',index:'nivel_descripcion',width:100,sortable:false,search:false}
							,{name:'carrera_denominacion',index:'carrera_denominacion',width:100,sortable:true,search:true}
					]
				,pager:'#pagerBusquedaMateriaId'
				,caption:'Buscar Materias'
				,ondblClickRow: function(id){
						var obj=$('#busquedaMateriaId').getRowData(id);
						$('#idid').val(obj.id)
						$('#denominacion').val(obj.denominacion);
						$('#dialogBusquedaMateria').dialog("close");
					} 
				});
				jQuery("#busquedaMateriaId").jqGrid('navGrid','#pagerBusquedaRequisitoId',{search:false,edit:false,add:false,del:false,pdf:true});
				jQuery('#busquedaMateriaId').jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});
				jQuery("#busquedaMateriaId").jqGrid('navButtonAdd','#pagerBusquedaMateriaId',{
				       caption:"Informe", 
				       onClickButton : function () {
				    	   var id = jQuery('#busquedaMateriaId').jqGrid('getGridParam','selrow');
				    	   if(id)
				    		   window.location = locvademecdetalle+'?target=_blank&id='+id;
				    	   else
				    		   $('<div>Seleccione una fila para activar esta opción</div>').dialog({title:'Mensaje',modal: true});
				    	   
				       } 
				});	
        	
        	$('#materiasId').jqGrid({
            	url:'<%out<< g.createLink(controller:"inscripcionMateria",action:"listjsonmateriasddd")%>'
                ,editurl:'<%out << g.createLink(controller:"inscripcionMateria",action:"editjsonmaterias")%>'
               	,datatype:'json'
                ,width:650
                ,colNames:['Id','Id DET','IdId','Denominación','Estado value','Estado Insc.','Tipo Value','Tipo Insc.']
            	,colModel:[
                       	{name:'id',index:'id',width:50,editable:false,hidden:true}
                       	,{name:'idDet',index:'idDet',hidden:true}
                       	,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:true,editoptions:{readOnly:true,size:10},editrules:{required:true}}
                       	,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:true,editoptions:{readOnly:true,size:40},editrules:{required:true}}
                       	,{name:'estadovalue',index:'estadovalue',hidden:false}
                       	,{name:'estado',index:'estado',width:120,editable:true,sortable:false
                           		,editoptions:{readOnly:false,size:40
                               					,value:'ESTADOINSMAT_INSCRIPTO:Inscripto;ESTADOINSMAT_REGULAR:Regular;ESTADOINSMAT_APROBADA:Aprobada;ESTADOINSMAT_DESAPROBADA:Desaprobada;ESTADOINSMAT_AUSENTE:Ausente'
                                   			 }
              					,edittype:'select'
                       	}
           				,{name:'tipovalue',index:'tipovalue',hidden:true}
                       	,{name:'tipo',index:'tipo',width:120,editable:true,sortable:false
                           		,editoptions:{readOnly:false,size:40
                           					,value:'TIPOINSMATERIA_CURSAR:Cursar;TIPOINSMATERIA_RENDIRLIBRE:Rendir Libre;TIPOINSMATERIA_RENDIRFINAL:Rendir Final'
                               				}
           						,edittype:'select'
                   				,editrules:{required:false}}
           				//,{name:'nota',index:'nota',width:30,editable:true,sortable:false,editoptions:{readOnly:false,size:10},editrules:{required:false}}
                ]
            	,sortname:'denominacion'
                ,pager: '#pagermateriasId'
            	,sortorder:'asc'
                ,caption: 'Materias Inscriptas'
            });

        	jQuery("#materiasId").jqGrid('navGrid','#pagermateriasId', {add:true,edit:true,del:true,search:false,refresh:false}, //options 
        			{height:280,width:450,reloadAfterSubmit:false
        				, recreateForm:true
        				,modal:false
        				,editCaption:'Modificar Materias'
        				, beforeShowForm:function(form){
        					//$('#TblGrid_materiasId').before('<a style="width:50px" id="searchlinkformgridId" href="#"><span  class="ui-icon ui-icon-search"></span>Vademecum</a>');
        					//listRequisitosId
        					$('#tr_denominacion').append('<td><a  id="searchlinkformgridId" href="#"><span style="float:left;"  class="ui-icon ui-icon-search"></span></a></td>');
        					$('#searchlinkformgridId').bind('click',function(){
        		            	$('#dialogBusquedaMateria').dialog({
        		            		title:'Buscar',
        		            		modal:true,
        		            		resizable:false,
        		            		autoOpen:true,
        		            		width : 600,
        		            		height: 'auto',
        		            		minHeight:350,
        		            		position:'center'
        		            	});
        					});
        				}
        				,bSubmit:'Modificar'
            			,beforeSubmit : function(postData,formId){
                			postData.estadovalue = $('#estado').val();
                			postData.tipovalue = $('#tipo').val();
       						return [true,''];
                		}
        			}, // edit options 
        			{height:280,width:450,reloadAfterSubmit:false
        				,recreateForm:true
        				,modal:false
        				,addCaption:'Agregar Materia'
        				,onclickSubmit: function(eparams){
        						//var obj=$('#busquedaMateriaId').jqGrid('getGridParam','selrow');
        						//if(obj){
        						//	return {descripcion:obj.descripcion};
        						//}else{
        						//	return{}
        						//}
        				}
        				,beforeSubmit: function(postData,formId){
        					/*var id = $('#busquedaMateriaId').jqGrid('getGridParam','selrow');
        					var obj;
        					if(!id){
        						alert('Seleccione una Materia de la Grilla');
        						return [false,''];
        					}else{
        						obj = $('#busquedaMateriaId').getRowData(id);						
        						postData.idid = obj.id;
        						postData.denominacion = obj.denominacion;
        						return [true,''];
        					}*/
                			postData.estadovalue = $('#estado').val();
                			postData.tipovalue = $('#tipo').val();
       						return [true,''];
        				}
        				,beforeShowForm:function(form){
        					$('#tr_denominacion').append('<td><a  id="searchlinkformgridId" href="#"><span style="float:left;"  class="ui-icon ui-icon-search"></span></a></td>');
        					$('#searchlinkformgridId').bind('click',function(){
        		            	$('#dialogBusquedaMateria').dialog({
        		            		title:'Buscar',
        		            		modal:true,
        		            		resizable:false,
        		            		autoOpen:true,
        		            		width : 600,
        		            		height: 'auto',
        		            		minHeight:350,
        		            		position:'center'
        		            	});
        					});
        					
        				}
        				,bSubmit:'Agregar'
        			
        			}, // add options 
        			{reloadAfterSubmit:false
            			,beforeSubmit : function(postData,formId){
                			var row = $('#materiasId').getRowData(postData);
                			arrayDeletedMaterias.push({id:row.idDet});
                			return[true,'']
                		
                		}
            		}, // del options 
        			{} // search options 
        		);	

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
                            
                            <div class="span-4 spanlabel"><g:link controller="alumno" action="show" id="${inscripcionMateriaInstance?.alumno?.id}">${inscripcionMateriaInstance?.alumno?.apellidoNombre?.encodeAsHTML()}</g:link></div>
                            
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
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
