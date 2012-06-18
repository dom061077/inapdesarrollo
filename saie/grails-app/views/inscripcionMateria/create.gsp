<%@ page import="com.educacion.academico.InscripcionMateria" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'inscripcionMateria.label', default: 'InscripcionMateria')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.cascade-select.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
		        //var arrayDeletedMaterias = [];
		        function clearMaterias(){
			        $('#materiasId').jqGrid('clearGridData');
			    }

			    function seleccionanio(){
				    $.ajax({url:'<% out << createLink(controller:"inscripcionMateria",action:"anioscascadedata") %>/?carreraId='+$('#carreraIdId').val()+'&anioLectivoId='+$('#anioLectivoIdId').val()+'&alumnoId='+$('#alumnoIdId').val() 
							,success: function(data){
									alert(data);
								}	
					    })

					    
				}
		
		        function initsubmit(){
		            var gridDataMaterias = $('#materiasId').getRowData();
		            var postDataMaterias = JSON.stringify(gridDataMaterias);
		            $('#materiasSerializedId').val(postDataMaterias);
		            $.post('<% out << createLink(controller:"inscripcionMateria",action:"save")%>',$('#formInscripcionMateriaId').serialize());
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
		        	    griddata[i]["denominacion"] = data[i].denominacion;	        	    	        	    
		        	    griddata[i]["estadovalue"] = data[i].estadovalue;
		        	    griddata[i]["estado"] = data[i].estado;
		        	    griddata[i]["tipovalue"] = data[i].tipovalue;
		        	    griddata[i]["tipo"] = data[i].tipo;
		        	    griddata[i]["nota"] = data[i].nota;
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
		               	datatype:'local'
		                ,width:500
		                ,colNames:['Id','IdId','Denominación','Select']
		            	,colModel:[
		                       	{name:'id',index:'id',width:50,editable:false,hidden:true}
		                       	,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:true,editoptions:{readOnly:true,size:10},editrules:{required:false}}
		                       	,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:true,editoptions:{readOnly:true,size:40},editrules:{required:true}}
		                       	,{ name: 'seleccion', index: 'seleccion',width:10,  formatter: "checkbox", formatoptions: { disabled: false }, editable: true, edittype: "checkbox" }
                   				
		                ]
		            	,sortname:'denominacion'
		                ,pager: '#pagermateriasId'
		            	,sortorder:'asc'
		                ,caption: 'Materias Inscriptas'
		            });
		
		        	jQuery("#materiasId").jqGrid('navGrid','#pagermateriasId', {add:false,edit:false,del:false,search:false,refresh:false}, //options 
		        			{height:280,width:350,reloadAfterSubmit:false
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
		        			{height:280,width:350,reloadAfterSubmit:false
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
		            			,beforeSubmit : function(postData,formId){
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
		            			/*,beforeSubmit : function(postData,formId){
		                			var row = $('#materiasId').getRowData(postData);
		                			arrayDeletedMaterias.push({id:row.idid});
		                			return[true,'']
		                		
		                		}*/
		            		}, // del options 
		        			{} // search options 
		        		);	

			        	$('#carreraId').cascade({
		                    source: '<%out << createLink(controller:'inscripcionMateria',action:'anioscascade',params:[alumnoId:inscripcionMateriaInstance?.alumno?.id])%>',
		                    cascaded: "anioLectivoId"
		                });		    		
		        		bindmaterias();
		
		            
		        });

        
		</script>
		
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="incripcionMateria.cursar.label" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${inscripcionMateriaInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${inscripcionMateriaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form id="formInscripcionMateriaId" onsubmit="initsubmit();return true;" action="save" >
            
                 
                         <g:hiddenField id="alumnoIdId" name="alumno.id" value="${inscripcionMateriaInstance?.alumno?.id}"/>
                         <g:hiddenField id="carreraIdId" name="carrera.id" value="${inscripcionMateriaInstance?.carrera?.id}" />
                         <g:hiddenField id="anioLectivoIdId" name="anioLectivo.id" value="${inscripcionMateriaInstance?.anioLectivo?.id}"/>
                         <g:hiddenField id="inscripcionMatriculaIdId" name="inscripcionMatricula.id" value="${inscripcionMateriaInstance?.inscripcionMatricula?.id}"/>
                         
                         <div class="span-2 spanlabel">
                         	<label>Alumno</label>
                         </div>
                         <div class="span-4 spanlabel">
                         	${inscripcionMateriaInstance?.alumno.apellido+"-"+inscripcionMateriaInstance?.alumno.nombre}
                         </div>
						<div class="clear"></div>
						
						
                         <div class="span-2 spanlabel"><label><g:message code="inscripcionMateria.carrera.label" default="Carrera" /></label></div>
                         <div class="span-4 spanlabel">${inscripcionMateriaInstance?.carrera?.denominacion}</div>
                         <div class="clear"></div>
                         
                         <div class="span-2 spanlabel"><label><g:message code="inscripcionMateria.anioLectivo.label" default="Año Lectivo" /></label></div>
                         <div class="span-4 spanlabel">${inscripcionMateriaInstance?.anioLectivo?.anioLectivo}</div>
                         <div class="clear"></div>
                          
                         
				<div class="clear"></div>
				<br/>
				<br/>
				<br/>
				                 
                         
                 		<g:hiddenField id="materiasSerializedId" name="materiasSerialized" value="${materiasSerialized}"/>	
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
         
            
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
