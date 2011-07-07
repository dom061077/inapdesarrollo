$(document).ready(function(){
						jQuery("#list").jqGrid({
						   	url:'listjson',
							datatype: "json",
						   	colNames:['Id','D.N.I', 'Apellido', 'Nombre','Domicilio','Telófono','C.P','Operaciones'],
						   	colModel:[
						   		
						   		{name:'id',index:'id', width:40},
						   		{name:'dni',index:'dni', width:92,sortable:false},
						   		{name:'apellido',index:'apellido', width:100,sortable:true},
						   		{name:'nombre',index:'nombre', width:100,sortable:true},
						   		{name:'domicilio',index:'domicilio', width:150, sortable:false},
						   		{name:'telefono',index:'telefono', width:80, align:"right", sortable:false},
						   		{name:'codigoPostal',index:'codigoPostal', width:40, align:"right", sortable:false},
						   		{name:'operaciones',index:'operaciones', width:40, align:"right", sortable:false}
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
								for(var i=0;i < ids.length;i++){ 
									var cl = ids[i]; 
									be = "<a href='edit/"+ids[i]+"'><span class='ui-icon ui-icon-pencil' style='margin: 3px 3px 3px 10px'  ></span></a>"; 
									jQuery("#list").jqGrid('setRowData',ids[i],{operaciones:be}); 
									} 
							}, 						    
						    caption:"Listado de Pacientes"
						});
						jQuery("#list").jqGrid('navGrid','#pager',{edit:false,add:false,del:false,pdf:true});

						jQuery("#list").jqGrid('navButtonAdd','#pager',{
						       caption:"Excel", 
						       onClickButton : function () { 
						           //jQuery("#list").excelExport();
						           jQuery("#list").jqGrid("excelExport",{url:"excelexport"});
						       } 
						});
	
	
});