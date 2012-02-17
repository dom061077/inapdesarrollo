<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'preinscripcion.label', default: 'Preinscripcion')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>                
        <script type="text/javascript">
        	jQuery(document).ready(function(){
				jQuery("#list").jqGrid({
				   	url:'listjson',
					datatype: "json",
					width:700,
					colNames:['Id','Denominación','Duración','Título','Validez del Título','Año Lectivo Vigente','Disponibilidad','Opciones'],
				   	colModel:[
				   		
				   		{name:'id',index:'id', width:40,hidden:true,search:false},
				   		{name:'denomicacion',index:'denominacion', width:92,sortable:true,search:true},
				   		{name:'duracion',index:'duracion', width:50,sortable:true,search:false},
				   		{name:'titulo',index:'titulo', width:100,sortable:true,search:false},
				   		{name:'validezTitulo',index:'validezTitulo',sortable:false, width:100,search:false},
				   		{name:'anioLectivo',index:'anioLectivo',sortable:false, width:100,search:false},
				   		{name:'cupo',index:'cupo', width:100,sortable:false,search:false},
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
						for(var i=0;i < ids.length;i++){ 
							var cl = ids[i];
							obj = jQuery("#list").getRowData(ids[i]); 
							be = "<a title='Editar' href='edit/"+ids[i]+"'><span class='ui-icon ui-icon-pencil' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
							var se = "<a title='Ver' href='show/"+ids[i]+"'><span class='ui-icon ui-icon-search' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
							jQuery("#list").jqGrid('setRowData',ids[i],{operaciones:be+se}); 
							}
						
						 
					}, 						    
				    caption:"Listado de ${message(code: 'preinscripcion.label', default: 'Preinscripcion')}"
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