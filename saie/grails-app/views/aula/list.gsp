
<%@ page import="com.educacion.academico.Aula" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'aula.label', default: 'Aula')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
		<script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>        
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        

        <script type="text/javascript">
        	jQuery(document).ready(function(){
				jQuery("#list").jqGrid({
				   	url:'listjson',
					datatype: "json",
					width:600,
					colNames:['Id', 'Nombre', 'Cupo', 'Estado', 'Opciones'],
				   	colModel:[
							  {name:'id',index:'id', width:55,editable:false,hidden:true,editoptions:{readonly:true,size:10}, sortable:false}
							, {name:'nombre',index:'nombre', width:50, align:"left",editable:true,editoptions:{readOnly:false,size:30},editrules:{required:true}, sortable:false}
							, {name:'cupo',index:'cupo', width:10, align:"left",editable:true,editoptions:{readOnly:false,size:10},editrules:{required:true}, sortable:false, search:false}
							, {name:'estado',index:'estado', width:40, align:"center",editable:true,editoptions:{readOnly:false,size:10},editrules:{required:true}, sortable:false, search:false}
					   		, {name:'operaciones',index:'operaciones', align:"center",width:25,search:false,sortable:false}
				   	],
				   	
				   	rowNum:10,
				   	//rownumbers:true,
				   	rowList:[10,20,30],
				   	pager: '#pager',
				   	sortname: 'id',
				    viewrecords: true,
				    sortorder: "desc",
					gridComplete: function(){ 
						var ids = jQuery("#list").jqGrid('getDataIDs');
						var obj; 
						for(var i=0;i < ids.length;i++){ 
							var cl = ids[i];
							obj = jQuery("#list").getRowData(ids[i]); 
							be = "<a title='Editar' href='edit/"+ids[i]+"'><span class='ui-icon ui-icon-pencil' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
							var se = "<a title='Ver' href='show/"+ids[i]+"'><span class='ui-icon ui-icon-search' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
							jQuery("#list").jqGrid('setRowData',ids[i],{operaciones:be+se}); 
							}
						
						 
					}, 						    
				    caption:"Listado de ${message(code: 'aula.label', default: 'Aula')}"
					// Aqui está el detalle de aula con la lista de carreras 
				    ,subGrid:true
					,subGridRowExpanded: function(subgrid_id, row_id) {
							var subgrid_table_id, pager_id;
							subgrid_table_id = subgrid_id+"_t";
							pager_id = "p_"+subgrid_table_id;
							var obj=$('#list').getRowData(row_id);
							$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
							jQuery("#"+subgrid_table_id).jqGrid({
								url:'<%out<<createLink(controller:"aula",action:"listdetallecarreras")%>/?aula_id='+obj.id,
								datatype: "json",
								mtype:'POST',
								colNames: ['Id','Carrera','Descripcion'],
								colModel: [
									{name:"id",index:"id",width:80,key:true,hidden:true},				           
									{name:"carrera",index:"carrera",width:20},
									{name:'descripcion',index:'descripcion',width:20,sorttype:'text',sortable:false,search:false}
								],
							   	rowNum:20,
							   	pager: pager_id,
							    height: '100%',
							    width: 600
							});
							jQuery("#"+subgrid_table_id).jqGrid('navGrid',"#"+pager_id,{search:false,edit:false,add:false,del:false});
						},

				});
				jQuery("#list").jqGrid('navGrid','#pager',{search:false,edit:false,add:false,del:false,pdf:true});

				jQuery("#list").jqGrid('navButtonAdd','#pager',{
				       caption:"Informe", 
				       onClickButton : function () { 
				           //jQuery("#list").excelExport();
				           //jQuery("#list").jqGrid("excelExport",{url:"excelexport"});
				    	   window.location = '<%out << createLink(controller:"aula",action:"reporteaulas") %>';
				       } 
				});

				jQuery("#list").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});						
	
            });
		</script>        
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2> ${flash.message}</H2> </div>
            </g:if>
			<table style="z-index:1"  id="list"></table>
			<div id="pager" ></div>
        </div>
    </body>
</html>
