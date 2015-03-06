$(document).ready(function(){
	$('#tabs').tabs();
	$('#tabs-graficos').tabs();
	$("#fechaDesdeId" ).datepicker($.datepicker.regional[ "es" ]);
	$("#fechaHastaId" ).datepicker($.datepicker.regional[ "es" ]);
	
	//------------pesta�a general---------------
	jQuery("#generalgrid").jqGrid({
	   	url:'pacientesatendidosjson',
	   	postData:{
	   		fechaDesde:function(){
	   					return $('#fechaDesdeId').val();
	   				},
	   		fechaHasta:function(){return $('#fechaHastaId').val()},
	   		profesional:function(){return $('#profesionalId').val()},
	   		profesionalId:function(){
	   					if($('#profesionalIdId').val()==undefined)
	   						return '';
	   					else
	   						return $('#profesionalIdId').val()
	   				},
	   		obraSocial:function(){
	   					return $('#obraSocialId').val();
	   				},
	   		obraSocialId:function(){
	   					if($('#obraSocialIdId')==undefined)
	   						return '';
	   					else
	   						return $('#obraSocialIdId').val();
	   		},
	   		cie10Id:function(){
				if($('#cie10IdId')==undefined)
					return '';
				else
					return $('#cie10IdId').val();
	   			
	   			
	   		}
	   		
	   	},
		datatype: "json",
		width:680,
	   	colNames:['Id','Fecha Consulta', 'Paciente', 'Obra Social','Telefono','E-mail','Nro.H.C'],
	   	colModel:[
	   		
	   		{name:'id',index:'id', width:40,hidden:true},
	   		{name:'fechaConsulta',index:'fechaConsulta', width:92,sortable:false},
	   		{name:'paciente',index:'paciente', width:150},
	   		{name:'obraSocial',index:'obraSocial', width:150, sortable:false},
	   		{name:'telefono',index:'telefono', width:80, align:"left", sortable:false},
	   		{name:'email',index:'email', width:160, align:"left", sortable:false},		
	   		{name:'hc',index:'hc', width:150,align:"left",sortable:false}
	   	],
	   	
	   	rowNum:10,
	   	rownumbers:true,
	   	rowList:[10,20,30],
	   	pager: '#pagergeneral',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "desc",
	    caption:"Listado General"
	});
	jQuery("#generalgrid").jqGrid('navGrid','#pagergeneral',{edit:false,search:false,add:false,del:false,pdf:true});

	jQuery("#generalgrid").jqGrid('navButtonAdd','#pagergeneral',{
	       caption:"Reporte", 
	       onClickButton : function () { 
	    	   var fechaDesde = $('#fechaDesdeId').val();
	    	   var fechaHasta = $('#fechaHastaId').val();
	    	   var profesionalId;
	    	   var obraSocialId;
	    	   var cie10Id
	    	   if($('#profesionalIdId').val()==undefined)
					profesionalId='';
				else
					profesionalId=$('#profesionalIdId').val();
	    	   
	    	   if($('#obraSocialIdId').val()==undefined)
					obraSocialId='';
	    	   else
					obraSocialId=$('#obraSocialIdId').val();
	    	   
	    	   if($('#cie10IdId').val()==undefined)
					cie10Id='';
	    	   else
					cie10Id=$('#cie10IdId').val();
	           window.location = 'reportegral?target=_blank&fechaDesde='+fechaDesde+'&fechaHasta='+fechaHasta+'&profesionalId='
	           						+profesionalId+'&obraSocialId='+obraSocialId+'&cie10Id='+cie10Id;
	       } 
	});
	
	//----------------Por profesional----------------
	
	jQuery("#profesionalgrid").jqGrid({
	   	url:'porprofesionaljson',
	   	postData:{
	   		fechaDesde:function(){
	   					return $('#fechaDesdeId').val();
	   				},
	   		fechaHasta:function(){return $('#fechaHastaId').val()},
	   		profesional:function(){return $('#profesionalId').val()},
	   		profesionalId:function(){
	   					if($('#profesionalIdId').val()==undefined)
	   						return '';
	   					else
	   						return $('#profesionalIdId').val()
	   				},
	   		obraSocial:function(){
	   					return $('#obraSocialId').val();
	   				},
	   		obraSocialId:function(){
	   					if($('#obraSocialIdId')==undefined)
	   						return '';
	   					else
	   						return $('#obraSocialIdId').val();
	   		},
	   		cie10Id:function(){
				if($('#cie10IdId')==undefined)
					return '';
				else
					return $('#cie10IdId').val();
	   			
	   			
	   		}
	   		
	   	},
		datatype: "json",
		width:680,
	   	colNames:['Id','Matrícula', 'Profesional', 'Pacientes','Minutos'],
	   	colModel:[
	   		{name:'id',index:'id', width:40,hidden:true},
	   		{name:'matricula',index:'matricula', width:92,sortable:false},
	   		{name:'profesional',index:'profesional', width:150},
	   		{name:'cantPacientes',index:'cantPacientes', width:80, sortable:false},
	   		{name:'minutos',index:'minutos', width:80, sortable:false}	   		
	   	],
	   	gridview:true,
	   	pgbuttons:false,
	   	pgtext:'',
	   	//rowNum:10,
	   	rownumbers:true,
	   	//rowList:[10,20,30],
	   	pager: '#pagerprofesional',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "desc",
	    caption:"Listado Por Profesional"
	});
	jQuery("#profesionalgrid").jqGrid('navGrid','#pagerprofesional',{edit:false,search:false,add:false,del:false,pdf:true});

	jQuery("#profesionalgrid").jqGrid('navButtonAdd','#pagerprofesional',{
	       caption:"Reporte", 
	       onClickButton : function () { 
	    	   var fechaDesde = $('#fechaDesdeId').val();
	    	   var fechaHasta = $('#fechaHastaId').val();
	    	   var profesionalId;
	    	   var obraSocialId;
	    	   var cie10Id
	    	   if($('#profesionalIdId').val()==undefined)
					profesionalId='';
				else
					profesionalId=$('#profesionalIdId').val();
	    	   
	    	   if($('#obraSocialIdId').val()==undefined)
					obraSocialId='';
	    	   else
					obraSocialId=$('#obraSocialIdId').val();
	    	   
	    	   if($('#cie10IdId').val()==undefined)
					cie10Id='';
	    	   else
					cie10Id=$('#cie10IdId').val();
	           window.location = 'reporteporprof?target=_blank&fechaDesde='+fechaDesde+'&fechaHasta='+fechaHasta+'&profesionalId='
	           						+profesionalId+'&obraSocialId='+obraSocialId+'&cie10Id='+cie10Id;
	       } 
	});
	
	//----------------Por diagnostico----------------
	
	jQuery("#diagnosticogrid").jqGrid({
	   	url:'pordiagnosticojson',
	   	postData:{
	   		fechaDesde:function(){
	   					return $('#fechaDesdeId').val();
	   				},
	   		fechaHasta:function(){return $('#fechaHastaId').val()},
	   		profesional:function(){return $('#profesionalId').val()},
	   		profesionalId:function(){
	   					if($('#profesionalIdId').val()==undefined)
	   						return '';
	   					else
	   						return $('#profesionalIdId').val()
	   				},
	   		obraSocial:function(){
	   					return $('#obraSocialId').val();
	   				},
	   		obraSocialId:function(){
	   					if($('#obraSocialIdId')==undefined)
	   						return '';
	   					else
	   						return $('#obraSocialIdId').val();
	   		},
	   		cie10Id:function(){
				if($('#cie10IdId')==undefined)
					return '';
				else
					return $('#cie10IdId').val();
	   			
	   			
	   		}
	   		
	   	},
		datatype: "json",
		width:680,
	   	colNames:['Id','Diagnóstico', 'Descripción', 'Total'],
	   	colModel:[
	   		{name:'id',index:'id', width:40,hidden:true},
	   		{name:'diagnostico',index:'diagnostico', width:92,sortable:false},
	   		{name:'descripcion',index:'descripcion', width:150},
	   		{name:'total',index:'total', width:80, sortable:false}	   		
	   	],
	   	gridview:true,
	   	pgbuttons:false,
	   	pgtext:'',
	   	//rowNum:10,
	   	rownumbers:true,
	   	//rowList:[10,20,30],
	   	pager: '#pagerdiagnostico',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "desc",
	    caption:"Listado Por Diagnóstico"
	});
	jQuery("#diagnosticogrid").jqGrid('navGrid','#pagerdiagnostico',{edit:false,search:false,add:false,del:false,pdf:true});

	jQuery("#diagnosticogrid").jqGrid('navButtonAdd','#pagerdiagnostico',{
	       caption:"Reporte", 
	       onClickButton : function () { 
	    	   var fechaDesde = $('#fechaDesdeId').val();
	    	   var fechaHasta = $('#fechaHastaId').val();
	    	   var profesionalId;
	    	   var obraSocialId;
	    	   var cie10Id
	    	   if($('#profesionalIdId').val()==undefined)
					profesionalId='';
				else
					profesionalId=$('#profesionalIdId').val();
	    	   
	    	   if($('#obraSocialIdId').val()==undefined)
					obraSocialId='';
	    	   else
					obraSocialId=$('#obraSocialIdId').val();
	    	   
	    	   if($('#cie10IdId').val()==undefined)
					cie10Id='';
	    	   else
					cie10Id=$('#cie10IdId').val();
	           window.location = 'reportepordiag?target=_blank&fechaDesde='+fechaDesde+'&fechaHasta='+fechaHasta+'&profesionalId='
	           						+profesionalId+'&obraSocialId='+obraSocialId+'&cie10Id='+cie10Id;
	       } 
	});	
	
});