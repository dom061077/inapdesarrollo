			$(function(){
				//-------------wizard ------------------
				$("#inscripcionFormId").formwizard({
					//formPluginEnabled: true,
				 	//validationEnabled: true,
				 	historyEnabled: true,
				 	focusFirstInput : true,
				 	textSubmit: 'Enviar',
				 	textNext: 'Siguiente',
				 	textBack: 'Anterior',
				 	formOptions :{
						success: function(data){$("#status").fadeTo(500,1,function(){ $(this).html("You are now registered!").fadeTo(5000, 0); })},
						beforeSubmit: function(data){$("#data").html("data sent to the server: " + $.param(data));},
						dataType: 'json',
						resetForm: true
				 	},
				 	validationOptions : {
				 		rules: {
							surname: "required",
							firstname : {
								required: true,
								email: true
							}
						},
						messages: {
							country: "Please specify your country",
							email: {
								required: "Please specify your email",
								email: "Correct format is name@domain.com"
							}
						}
				 	}
				 }
				);
				//--------------fin wizard----------------
        		$.datepicker.setDefaults($.datepicker.regional[ 'es' ]);
        		$('#fechaNacimientoId' ).datepicker({changeYear:true});




				$('#paisDomicilioId').lookupfield({source:'<%out << createLink(controller:"pais",action:"listsearchjson")%>',
					 title:'Pais de Domicilio' 
					,colNames:['Id','Nombre'] 
					,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:true,search:false} 
					,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}] 
					,hiddenid:'paisDomicilioIdId' 
					,descid:'paisDomicilioId' 
					,hiddenfield:'id' 
					,descfield:['nombre']
					,onSelected:function(){
						// addPostDataFilters("AND");
						var filter = { groupOp: "AND", rules: []};
		
						// addFilteritem("invdate", "gt", "2007-09-06");
						//myfilter.rules.push({field:"invdate",op:"gt",data:"2007-09-06"});
		
						// addFilteritem("invdate", "lt", "2007-10-04");
						//myfilter.rules.push({field:"invdate",op:"lt",data:"2007-10-04"});
		
						// addFilteritem("name", "bw", "test");
						filter.rules.push({field:"pais_id",op:"eq",data:$('#paisDomicilioIdId').val()});
		
						var grid = $('#provinciaDomicilioIdtablesearchId') 
						grid[0].p.search = filter.rules.length>0;
						$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
						grid.trigger("reloadGrid",[{page:1}]);
		
						
						//$('#provinciaDomicilioIdtablesearchId').setPostData(jQuery.parseJSON(filters));
						//var data = $("#provinciaDomicilioIdtablesearchId").jqGrid("getGridParam","postData");
						//$('#provinciaDomicilioIdtablesearchId').trigger('reloadGrid');
						
						
					}
				}); 
		
				$('#paisDomicilioId').keyup(function(){
			   		if($.trim($(this).val())==""){
			   			$('#paisDomicilioId').val("")
			   		}
			   	});	
				
						 
				//---------------------------------- 
				
				$('#provinciaDomicilioId').lookupfield({source:'<%out << createLink(controller:"provincia",action:"listsearchjson")%>',
		 				 title:'Provincia del Domicilio' 
						,colNames:['Id','Nombre'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 					,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}]
						,onSelected:function(){
							var filter = { groupOp: "AND", rules: []};
							filter.rules.push({field:"provincia_id",op:"eq",data:$('#provinciaDomicilioIdId').val()});
							var grid = $('#localidadDomicilioIdtablesearchId') 
							grid[0].p.search = filter.rules.length>0;
							$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
							grid.trigger("reloadGrid",[{page:1}]);
							
							
						}
		 				,hiddenid:'provinciaDomicilioIdId' 
		 				,descid:'provinciaDomicilioId'
		 				,hiddenfield:'id' 
		 				,descfield:['nombre']}); 
		
				$('#provinciaDomicilioId').keyup(function(){
			   		if($.trim($(this).val())==""){
			   			$('#provinciaDomicilioId').val("")
			   		}
			   	});	
		
				
				//---------------------------------- 
				
		        
				$('#localidadDomicilioId').lookupfield({source:'<%out<<createLink(controller:"localidad",action:"listsearchjson")%>',
		 				 title:'Localidad del Domicilio' 
						,colNames:['Id','Nombre','Código Postal'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false}
		 				,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}
		 				,{name:'codigoPostal',index:'codigoPostal', width:60,  sortable:true,search:true ,searchoptions:{sopt:['eq']}}]
		 				,hiddenid:'localidadDomicilioIdId' 
		 				,descid:'localidadDomicilioId' 
		 				,hiddenfield:'id' 
		 				,descfield:['nombre','codigoPostal']}); 
		
				$('#localidadDomicilioId').keyup(function(){
		        	if($.trim($(this).val())==""){
		        		$('#localidadDomicilioId').val("")
		        	}
		        });	
		
		        
				//---------------------------------- 	
				$('#paisLaboralId').lookupfield({source:'<%out << createLink(controller:"pais",action:"listsearchjson")%>',
					 title:'Pais de Laboral' 
					,colNames:['Id','Nombre'] 
					,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
					,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}] 
					,hiddenid:'paisLaboralIdId' 
					,descid:'paisLaboralId' 
					,hiddenfield:'id' 
					,descfield:['nombre']
					,onSelected:function(){
						var filter = { groupOp: "AND", rules: []};
		
						filter.rules.push({field:"pais_id",op:"eq",data:$('#paisLaboralIdId').val()});
		
						var grid = $('#provinciaLaboralIdtablesearchId') 
						grid[0].p.search = filter.rules.length>0;
						$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
						grid.trigger("reloadGrid",[{page:1}]);
						
						
					}
				}); 
		
				$('#paisLaboralId').keyup(function(){
			   		if($.trim($(this).val())==""){
			   			$('#paisLaboralId').val("")
			   		}
			   	});	
				
						 
				//---------------------------------- 
				
				$('#provinciaLaboralId').lookupfield({source:'<%out << createLink(controller:"provincia",action:"listsearchjson")%>',
		 				 title:'Provincia del Laboral' 
						,colNames:['Id','Nombre'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 					,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}]
						,onSelected:function(){
							var filter = { groupOp: "AND", rules: []};
							filter.rules.push({field:"provincia_id",op:"eq",data:$('#provinciaLaboralIdId').val()});
							var grid = $('#localidadLaboralIdtablesearchId') ;
							grid[0].p.search = filter.rules.length>0;
							$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
							grid.trigger("reloadGrid",[{page:1}]);
							
							
						}
		 				,hiddenid:'provinciaLaboralIdId' 
		 				,descid:'provinciaLaboralId'
		 				,hiddenfield:'id' 
		 				,descfield:['nombre']}); 
		
				$('#provinciaLaboralId').keyup(function(){
			   		if($.trim($(this).val())==""){
			   			$('#provinciaLaboralId').val("")
			   		}
			   	});	
		
				
				//---------------------------------- 
		
		
		
				$('#localidadLaboralId').lookupfield({source:'<%out<<createLink(controller:"localidad",action:"listsearchjson")%>',
		 				 title:'Localidad Laboral' 
						,colNames:['Id','Nombre','Código Postal'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 				,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}
						,{name:'codigoPostal',index:'codigoPostal', width:60,  sortable:true,search:true,searchoptions:{sopt:['eq']}}] 
		 				,hiddenid:'localidadLaboralIdId' 
		 				,descid:'localidadLaboralId' 
		 				,hiddenfield:'id' 
		 				,descfield:['nombre','codigoPostal'] 
		        	});
		
		
		//---------------------------------- 	
				$('#paisNacId').lookupfield({source:'<%out << createLink(controller:"pais",action:"listsearchjson")%>',
					 title:'Pais de Nacimiento' 
					,colNames:['Id','Nombre'] 
					,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
					,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}] 
					,hiddenid:'paisNacIdId' 
					,descid:'paisNacId' 
					,hiddenfield:'id' 
					,descfield:['nombre']
					,onSelected:function(){
						// addPostDataFilters("AND");
						var filter = { groupOp: "AND", rules: []};
		
						// addFilteritem("invdate", "gt", "2007-09-06");
						//myfilter.rules.push({field:"invdate",op:"gt",data:"2007-09-06"});
		
						// addFilteritem("invdate", "lt", "2007-10-04");
						//myfilter.rules.push({field:"invdate",op:"lt",data:"2007-10-04"});
		
						// addFilteritem("name", "bw", "test");
						filter.rules.push({field:"pais_id",op:"eq",data:$('#paisNacIdId').val()});
		
						var grid = $('#provinciaNacIdtablesearchId') 
						grid[0].p.search = filter.rules.length>0;
						$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
						grid.trigger("reloadGrid",[{page:1}]);
		
						
						//$('#provinciaDomicilioIdtablesearchId').setPostData(jQuery.parseJSON(filters));
						//var data = $("#provinciaDomicilioIdtablesearchId").jqGrid("getGridParam","postData");
						//$('#provinciaDomicilioIdtablesearchId').trigger('reloadGrid');
						
						
					}
				}); 
		
				$('#paisNacId').keyup(function(){
			   		if($.trim($(this).val())==""){
			   			$('#paisNacId').val("");
			   		}
			   	});	
				
						 
				//---------------------------------- 
				
				$('#provinciaNacId').lookupfield({source:'<%out << createLink(controller:"provincia",action:"listsearchjson")%>',
		 				 title:'Provincia del Nacimiento' 
						,colNames:['Id','Nombre'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 					,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}]
						,onSelected:function(){
							var filter = { groupOp: "AND", rules: []};
							filter.rules.push({field:"provincia_id",op:"eq",data:$('#provinciaNacIdId').val()});
							var grid = $('#localidadNacIdtablesearchId') ;
							grid[0].p.search = filter.rules.length>0;
							$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
							grid.trigger("reloadGrid",[{page:1}]);
							
							
						}
		 				,hiddenid:'provinciaNacIdId' 
		 				,descid:'provinciaNacId'
		 				,hiddenfield:'id' 
		 				,descfield:['nombre']}); 
		
				$('#provinciaNacId').keyup(function(){
			   		if($.trim($(this).val())==""){
			   			$('#provinciaNacId').val("")
			   		}
			   	});	
		
				
				//---------------------------------- 
		
		
				$('#localidadNacId').lookupfield({source:'<%out << createLink(controller:"localidad",action:"listsearchjson")%>',
		 				 title:'Localidad de Nacimiento' 
						,colNames:['Id','Nombre','Código Postal'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 				,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}
						,{name:'codigoPostal',index:'codigoPostal', width:60,  sortable:true,search:true,searchoptions:{sopt:['eq']}}] 
		 				,hiddenid:'localidadNacIdId' 
		 				,descid:'localidadNacId' 
		 				,hiddenfield:'id' 
		 				,descfield:['nombre','codigoPostal']});
				$('#localidadNacId').keyup(function(){
				   	if($.trim($(this).val())==""){
				   		$('#localidadNacId').val("")
				   	}
				   }); 
		
		
				//---------------------------------- 	
				$('#paisTutorId').lookupfield({source:'<%out << createLink(controller:"pais",action:"listsearchjson")%>',
					 title:'Pais de Laboral' 
					,colNames:['Id','Nombre'] 
					,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
					,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}] 
					,hiddenid:'paisTutorIdId' 
					,descid:'paisTutorId' 
					,hiddenfield:'id' 
					,descfield:['nombre']
					,onSelected:function(){
						var filter = { groupOp: "AND", rules: []};
		
						filter.rules.push({field:"pais_id",op:"eq",data:$('#paisTutorIdId').val()});
		
						var grid = $('#provinciaTutorIdtablesearchId') 
						grid[0].p.search = filter.rules.length>0;
						$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
						grid.trigger("reloadGrid",[{page:1}]);
						
						
					}
				}); 
		
				$('#paisTutorId').keyup(function(){
			   		if($.trim($(this).val())==""){
			   			$('#paisTutorId').val("")
			   		}
			   	});	
				
						 
				//---------------------------------- 
				
				$('#provinciaTutorId').lookupfield({source:'<%out << createLink(controller:"provincia",action:"listsearchjson")%>',
		 				 title:'Provincia del Tutor' 
						,colNames:['Id','Nombre'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 					,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}]
						,onSelected:function(){
							var filter = { groupOp: "AND", rules: []};
							filter.rules.push({field:"provincia_id",op:"eq",data:$('#provinciaTutorIdId').val()});
							var grid = $('#localidadTutorIdtablesearchId') ;
							grid[0].p.search = filter.rules.length>0;
							$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
							grid.trigger("reloadGrid",[{page:1}]);
							
							
						}
		 				,hiddenid:'provinciaTutorIdId' 
		 				,descid:'provinciaTutorId'
		 				,hiddenfield:'id' 
		 				,descfield:['nombre']}); 
		
				$('#provinciaTutorId').keyup(function(){
			   		if($.trim($(this).val())==""){
			   			$('#provinciaTutorId').val("")
			   		}
			   	});	
		
				
				//---------------------------------- 
		
				
				
		
				$('#localidadTutorId').lookupfield({source:'<%out<<createLink(controller:"localidad",action:"listsearchjson")%>',
		 				 title:'Localidad Tutor' 
						,colNames:['Id','Nombre','Código Postal'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 				,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}
						,{name:'codigoPostal',index:'codigoPostal', width:60,  sortable:true,search:true,searchoptions:{sopt:['eq']}}] 
		 				,hiddenid:'localidadTutorIdId' 
		 				,descid:'localidadTutorId' 
		 				,hiddenfield:'id' 
		 				,descfield:['nombre','codigoPostal'] 
		        	});
		
				
		
		//----------------------------------
		
				$('#paisGaranteId').lookupfield({source:'<%out << createLink(controller:"pais",action:"listsearchjson")%>',
					 title:'Pais del Garante' 
					,colNames:['Id','Nombre'] 
					,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
					,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}] 
					,hiddenid:'paisGaranteIdId' 
					,descid:'paisGaranteId' 
					,hiddenfield:'id' 
					,descfield:['nombre']
					,onSelected:function(){
						var filter = { groupOp: "AND", rules: []};
		
						filter.rules.push({field:"pais_id",op:"eq",data:$('#paisGaranteIdId').val()});
		
						var grid = $('#provinciaGaranteIdtablesearchId') 
						grid[0].p.search = filter.rules.length>0;
						$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
						grid.trigger("reloadGrid",[{page:1}]);
						
						
					}
				}); 
		
				$('#paisGaranteId').keyup(function(){
			   		if($.trim($(this).val())==""){
			   			$('#paisGaranteId').val("")
			   		}
			   	});	
				
						 
				//---------------------------------- 
				
				$('#provinciaGaranteId').lookupfield({source:'<%out << createLink(controller:"provincia",action:"listsearchjson")%>',
		 				 title:'Provincia del Garante' 
						,colNames:['Id','Nombre'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 					,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}]
						,onSelected:function(){
							var filter = { groupOp: "AND", rules: []};
							filter.rules.push({field:"provincia_id",op:"eq",data:$('#provinciaGaranteIdId').val()});
							var grid = $('#localidadGaranteIdtablesearchId') ;
							grid[0].p.search = filter.rules.length>0;
							$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
							grid.trigger("reloadGrid",[{page:1}]);
							
							
						}
		 				,hiddenid:'provinciaGaranteIdId' 
		 				,descid:'provinciaGaranteId'
		 				,hiddenfield:'id' 
		 				,descfield:['nombre']}); 
		
				$('#provinciaGaranteId').keyup(function(){
			   		if($.trim($(this).val())==""){
			   			$('#provinciaGaranteId').val("")
			   		}
			   	});	
		
				
				//---------------------------------- 
		
		
		
				$('#localidadGaranteId').lookupfield({source:'<%out<<createLink(controller:"localidad",action:"listsearchjson")%>',
		 				 title:'Localidad Garante' 
						,colNames:['Id','Nombre','Código Postal'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 				,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}
						,{name:'codigoPostal',index:'codigoPostal', width:60,  sortable:true,search:true,searchoptions:{sopt:['eq']}}] 
		 				,hiddenid:'localidadGaranteIdId' 
		 				,descid:'localidadGaranteId' 
		 				,hiddenfield:'id' 
		 				,descfield:['nombre','codigoPostal'] 
		        	});
		
		
		
		
				$('#situacionAdministrativaId').lookupfield({source:'<%createLink(controller:"situacionAdministrativa",action:"listsearchjson")%>',
		 				 title:'Situacion Admistrativa' 
						,colNames:['Id','Nombre'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 				,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}] 
		 				,hiddenid:'situacionAdministrativaIdId' 
		 				,descid:'situacionAdministrativaId' 
		 				,hiddenfield:'id' 
		 				,descfield:['descripcion']}); 
				
  		});
