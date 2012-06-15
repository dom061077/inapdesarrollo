

<%@ page import="com.educacion.academico.Division" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'division.label', default: 'Division')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">

        function initsubmit(){
    		var gridData = jQuery("#divisionesId").getRowData();
        	var postData = JSON.stringify(gridData);
        	$("#divisionesSerializedId").val(postData);
        	
        }

        function binddivisiones(){
        	var griddata = [];
        	
        	var data = jQuery.parseJSON($("#divisionesSerializedId").val());
        	if(data==null)
	        		data=[];
        	for (var i = 0; i < data.length; i++) {
        	    griddata[i] = {};
        	    griddata[i]["descricpion"] = data[i].descripcion;
        	    griddata[i]["letra"] = data[i].letra;	        	    	        	    
        	    griddata[i]["turno"] = data[i].turno;
        	    griddata[i]["descriturno"] = data[i].descriturno;
        	    griddata[i]["cupo"] = data[i].cupo;
            }

        	for (var i = 0; i <= griddata.length; i++) {
        	    jQuery("#divisionesSerializedId").jqGrid('addRowData', i + 1, griddata[i]);
        	}
        }


        $(document).ready(function(){
        	$('#carreraId').lookupfield({source:'<%out<<createLink(controller:'carrera',action:'listsearchjson')%>',
				 title:'Búsqueda de Carreras' 
   				,colNames:['Id','Denominación'] 
   				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
				,{name:'denominacion',index:'denominacion', width:100,  sortable:true,search:true}
				]  
				,hiddenid:'carreraIdId' 
				,descid:'carreraId' 
				,hiddenfield:'id' 
				,descfield:['denominacion']
    			,onSelected:function(){
					var filter = { groupOp: "AND", rules: []};
    				filter.rules.push({field:"carrera_id",op:"eq",data:$('#carreraIdId').val()});
    				var grid = $('#nivelIdtablesearchId') 
    				grid[0].p.search = filter.rules.length>0;
    				$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
    				grid.trigger("reloadGrid",[{page:1}]);
    				$('#nivelId').val('');
					$('#nivelIdId').val('');
				}
				,onKeyup:function(){
					if($.trim($('#carreraId').val())==""){
						var filter = { groupOp: "AND", rules: []};
	    				filter.rules.push({field:"carrera_id",op:"eq",data:0});
	    				var grid = $('#nivelIdtablesearchId') 
	    				grid[0].p.search = filter.rules.length>0;
	    				$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
	    				grid.trigger("reloadGrid",[{page:1}]);
	    				$('#nivelId').val('');
	    				$('#nivelIdId').val('');
                	}
				}
			}); 

	   		$('#carreraId' ).autocomplete({source: '<%out<<createLink(controller:'carrera',action:'listjsonautocomplete')%>',
				 minLength: 2, 
 				 select: function( event, ui ) {
					 if(ui.item){ 
						 $('#carreraIdId').val(ui.item.id) 
						 
						var filter = { groupOp: "AND", rules: []};
						filter.rules.push({field:"carrera_id",op:"eq",data:ui.item.id});
						var grid = $('#nivelIdtablesearchId') 
						grid[0].p.search = filter.rules.length>0;
						$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
						grid.trigger("reloadGrid",[{page:1}]);
						$('#nivelId').val('');
						$('#nivelIdId').val('');
						$('#matregcursarId').clearGridData();
						$('#mataprobcursarId').clearGridData();
						$('#matregrendirId').clearGridData();
						$('#mataprobrendirId').clearGridData();						
						
					 	} 
					}, 
				 open: function() { 
					$( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' ); 
				 }, 
				 close: function() {
					 $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' ); 
				 } 
				}); 

				
        	
	$('#nivelId').lookupfield({source:'<%out<<createLink(controller:'nivel',action:'listsearchjson')%>',
				 title:'Búsqueda de niveles' 
			,colNames:['Id','Descripcion','Carrera','Es primer nivel'] 
			,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
				,{name:'descripcion',index:'descripcion', width:100,  sortable:true,search:true}
				,{name:'carrera',index:'carrear',hidden:false}
			,{name:'esprimernivel',index:'esprimernivel',width:100,sortable:false,search:false} ]
				,hiddenid:'nivelIdId' 
				,descid:'nivelId' 
				,hiddenfield:'id' 
				,descfield:['descripcion']
			,onShowgrid:function(){
				if(($("#matregcursarId").getRowData().length>0)
						 || 
						   ($("#mataprobcursarId").getRowData().length>0)||
						   ($("#matregrendirId").getRowData().length>0) ||
						   ($("#mataprobcursarId").getRowData().length>0)
					){
		   			$("<div>Recuerde de que si cargo algunas materias en alguna grilla de abajo al cambiar de carrera se limpiaran dichas grillas</div>").dialog({
		   				resizable: false,
		   				height:140,
		   				modal: true,
		   				buttons: {
		   					Ok: function() {
		   						$( this ).dialog( "close" );
		   					}
		   				}
		   			});
		   		}
			}
	
				}); 

	$('#nivelId' ).autocomplete({
			source: function( request, response ) {
						$.ajax({
							url: '<%out<<createLink(controller:'nivel',action:'listjsonautocomplete')%>',
							//dataType: "jsonp",
							data: {
								carreraId:$('#carreraIdId').val(),
								term: request.term
							},
							success: function( data ) {
								response( $.map( data, function( item ) {
									return {
										label: item.label,
										value: item.value,
										id: item.id
									}
								}));
							},
							error:function(jqXHR, textStatus, errorThrown){
								alert('ERROR');									
							}
						});
					}
			,
				 minLength: 2,
				 select: function( event, ui ) {
					 if(ui.item){ 
					 	$('#nivelIdId').val(ui.item.id);
						  
				 } 
				}, 
				 open: function() { 
					$( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' ); 
				 }, 
				 close: function() {
					 $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' ); 
				 } 
				}); 
	

		// Grilla de Divisiones
		jQuery("#divisionesId").jqGrid({ 
			datatype: "local"
			,editurl:'editdivisiones'
			,width:600
			,colNames:['Descripción','Letra','Turno', 'Descripción Turno', 'Cupo']
			,colModel:[ 
				  {name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
			    , {name:'letra',index:'letra', width:50, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}						
			    , {name:'turno',index:'turno', width:50, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}						
			    , {name:'descriturno',index:'descriturno', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:false}, sortable:false}						
			    , {name:'cupo',index:'cupo', width:50, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}						
			]
			, pager: '#pagerdivisionesId'
			, sortname: 'id'
			, viewrecords: true, sortorder: "desc"
			, caption:"Divisiones"
			, height:140
		}); 
		
		jQuery("#divisionesId").jqGrid('navGrid','#pagerdivisionesId', {add:true,edit:true,del:true,search:false,refresh:false}, //options 
				{height:280,width:310,reloadAfterSubmit:false
					,recreateForm:true
					,modal:true
					,editCaption:'Modificar divisiones'
					, beforeSubmit:function(postData,formId){
						postData.estadoValue = $("#estado").val();
						return [true,'']
					}
					,beforeShowForm:function(form){
						$('#descripcion').focus();
					}
				
				}, // edit options 
				{height:170,width:310,reloadAfterSubmit:false
					,recreateForm:true
					,modal:true
					,addCaption:'Agregar Divisiones'
					,beforeSubmit: function(postData,formId){
						postData.estadoValue= $("#estado").val();
						return [true,'']
					}
					,beforeShowForm:function(form){
						$('#descripcion').focus();
					}
				}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
			);	

    		binddivisiones();
			
		});

        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>

            <g:hasErrors bean="${nivelInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${nivelInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" onSubmit="initsubmit()">
            		<div class="append-bottom">	
                        
							<div class="span-3 spanlabel">
								<label for="carreraDesc"><g:message code="materia.carrera.label" default="Carrera" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="${nivelInstance?.carrera?.denominacion}" /> 
 								<g:hiddenField id="carreraIdId" name="carreraId" value="${nivelInstance?.carrera?.id}" />
							</div>
						    <div class="clear"></div>
                        
							<g:hasErrors bean="${nivelInstance}" field="nivel">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="nivel"><g:message code="materia.nivel.label" default="Nivel" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="nivelId" name="nivelDesc"  value="${nivelInstance?.descripcion}" /> 
 								<g:hiddenField id="nivelIdId" name="nivelid" value="${nivelInstance?.id}" />
							</div>
								
		                    <div class="clear"></div>
							<fieldset>
								<g:hiddenField id="divisionesSerializedId" name="divisionesSerialized" value="${divisionesSerialized}"/>
								<legend>Divisiones</legend>
		   						<div id="pagerdivisionesId"></div>
		       					<table id="divisionesId">
									
		       					</table>
							</fieldset>
							
				</div>                        
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
