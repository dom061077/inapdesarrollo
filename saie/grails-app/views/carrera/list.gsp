
<%@ page import="com.educacion.academico.Carrera" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'carrera.label', default: 'Carrera')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'thickbox.js')}"></script>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'css',file:'thickbox.css')}" />
                

        <script type="text/javascript">
        	jQuery(document).ready(function(){
				jQuery("#list").jqGrid({
				   	url:'listjson',
					datatype: "json",
					width:680,
					colNames:['Id','Denomicación','Campo Ocupacional','Opciones'],
				   	colModel:[
				   		
				   		{name:'id',index:'id', width:40},
				   		{name:'denominacion',index:'denominacion', width:92,sortable:false},
				   		{name:'campoOcupacional',index:'campoOcupacional', width:100,search:true},
				   		{name:'operaciones',index:'operaciones', width:55,search:false,sortable:false}
				   	],
				   	
				   	rowNum:10,
				   	rownumbers:true,
				   	rowList:[10,20,30],
				   	pager: '#pager',
				   	sortname: 'id',
				    viewrecords: true,
				    sortorder: "desc",
					gridComplete: function(){ 
						var ids = jQuery("#list").jqGrid('getDataIDs');
						var obj;
						var se;
						var be;
						for(var i=0;i < ids.length;i++){ 
							var cl = ids[i];
							obj = jQuery("#list").getRowData(ids[i]);
							be = "<a title='Editar' href='"+ids[i]+"'><span class='ui-icon ui-icon-pencil' style='float:left;margin: 3px 3px 3px 10px'  ></span></a>";  
							se = "<a title='Ver' href='show/"+ids[i]+"'><span class='ui-icon ui-icon-search' style='float:left;margin: 3px 3px 3px 10px'  ></span></a>";
							jQuery("#list").jqGrid('setRowData',ids[i],{operaciones:be+se}); 
						}
					}
					,subGrid:true
					,subGridRowExpanded: function(subgrid_id, row_id) {
						var subgrid_table_id, pager_id;
						subgrid_table_id = subgrid_id+"_t";
						pager_id = "p_"+subgrid_table_id;
						var obj=$('#list').getRowData(row_id);
						$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
						jQuery("#"+subgrid_table_id).jqGrid({
							url:'<%out<<createLink(controller:"carrera",action:"listdocumentos")%>?id='+obj.id,
							datatype: "json",
							mtype:'POST',
							colNames: ['Id','Nombre PDF','URL Doc.PDF','URL Image','URL Large Image','Documento PDF','Imagen','Opciones'],
							colModel: [
								{name:"id",index:"id",width:80,key:true,hidden:true},				           
								{name:"nombreOriginalDocumento",index:"nombreOriginalDocumento",width:80,hidden:true},
								{name:"urlDocumentoPDF",index:"urlDocumentoPDF",width:80,hidden:true},
								{name:"image",index:"image",width:70,hidden:true},
								{name:"largeImage",index:"largeImage",width:70,hidden:true},
								{name:"documentoPDF",index:"documentoPDF",width:80},
								{name:"documentoImagen",index:"documentoImagen",width:20},
								{name:'operaciones',index:'operaciones',width:20,sorttype:'text',sortable:false,search:false}
							],
						   	rowNum:20,
						   	pager: pager_id,
						    height: '100%',
						    width: 600,
						    gridComplete: function(){
								var ids = jQuery('#'+subgrid_table_id).jqGrid('getDataIDs');
								var be;
								var row;
								var image;
								var documentoPDF;
								for(var i=0;i < ids.length;i++){ 
									var cl = ids[i];
									row = jQuery('#'+subgrid_table_id).getRowData(cl);
									be = "<a href='<%out << createLink(controller:"documentoCarrera",action:"edit")%>/"+row.id+"'><span style='float:left' class='ui-icon ui-icon-pencil'></span></a>";
									image = "<a class='thickbox' href='"+row.largeImage+"'><img src='"+row.image+"'/></a>";
									documentoPDF = "<a href='"+row.urlDocumentoPDF+"'>"+row.nombreOriginalDocumento+"</a>";
									jQuery("#"+subgrid_table_id).jqGrid('setRowData',ids[i],{operaciones:be,documentoImagen:image,documentoPDF:documentoPDF}); 
								} 
								tb_init('a.thickbox, area.thickbox, input.thickbox');
						    }
						});
						jQuery("#"+subgrid_table_id).jqGrid('navGrid',"#"+pager_id,{search:false,edit:false,add:false,del:false});
						//jQuery("#"+subgrid_table_id).jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});
					},
				    caption:"Listado de ${message(code: 'carrera.label', default: 'Carrera')}"
				});
				jQuery("#list").jqGrid('navGrid','#pager',{search:false,edit:false,add:false,del:false,pdf:true});

				jQuery("#list").jqGrid('navButtonAdd','#pager',{
				       caption:"Informe", 
				       onClickButton : function () { 
				           //jQuery("#list").excelExport();
				           jQuery("#list").jqGrid("excelExport",{url:"excelexport"});
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
            <div class="ui-state-highlight ui-corner-all"><H2> ${flash.message} </H2></div>
            </g:if>
			<table   id="list"></table>
			<div id="pager" ></div>
        </div>
    </body>
</html>
