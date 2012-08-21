var lastSel;
    function initsubmit(){
        var gridDataMaterias = $("#materiasId").getRowData();
        var postDataMaterias = JSON.stringify(gridDataMaterias);

        var gridDataRequisitos = $('#tableRequisitosId').getRowData();
        var postDataRequisitos = JSON.stringify(gridDataRequisitos);

        $("#materiasSerializedId").val(postDataMaterias);
        $('#requisitosSerializedId').val(postDataRequisitos);

        $('#fechaNacimientoId_yearId').val($('#fechaNacimientoId').datepicker('getDate').getFullYear());
        $('#fechaNacimientoId_monthId').val($('#fechaNacimientoId').datepicker('getDate').getMonth()+1);
        $('#fechaNacimientoId_dayId').val($('#fechaNacimientoId').datepicker('getDate').getDate());
        if($('#fechaNacimientoId_monthId').val().length==1)
            $('#fechaNacimientoId_monthId').val('0'+$('#fechaNacimientoId_monthId').val());
        if($('#fechaNacimientoId_dayId').val().length==1)
            $('#fechaNacimientoId_dayId').val('0'+$('#fechaNacimientoId_dayId').val());
        var ids = jQuery("#materiasId").jqGrid('getDataIDs');
        var obj;
        //TODO probar el estado editado del tipo de inscripcion antes de guardar la preinscrpcion
        for(var i=0;i < ids.length;i++){
            var id = ids[i];
            $('#materiasId').jqGrid('restoreRow',id);
        }


    }


    function bindmaterias(){
        var griddata = [];

        var data = jQuery.parseJSON($("#materiasSerializedId").val());
        if(data==null)
            data=[];
        for (var i = 0; i < data.length; i++) {
            griddata[i] = {};
            griddata[i]['id'] = data[i].id;
            griddata[i]['idid'] = data[i].idid;
            griddata[i]['nivel'] = data[i].nivel;
            griddata[i]['codigomateria'] = data[i].codigomateria;
            griddata[i]['denominacion'] = data[i].denominacion;
            griddata[i]['tipo'] = data[i].tipo;
            griddata[i]['tipovalue'] = data[i].tipovalue;
            griddata[i]['seleccion'] = data[i].seleccion;
        }
        $('#materiasId').jqGrid("clearGridData");
        for (var i = 0; i <= griddata.length; i++) {
            jQuery("#materiasId").jqGrid('addRowData', i + 1, griddata[i]);
        }
    }


    function bindalumnodata(json){
        if(json){
            $('#alumnoId').val(json.alumno.id)
            $('#anioEgresoId').val(json.alumno.anioEgreso);
            $('#apellidoId').val(json.alumno.apellido);
            $('#nombreId').val(json.alumno.nombre);
            $('#apellidoNombreGaranteId').val(json.alumno.apellidoNombreGarante);
            $('#apellidoNombreTutorId').val(json.alumno.apellidoNombreTutor);
            $('#barrioDomicilioId').val(json.alumno.barrioDomicilio);
            $('#barrioGaranteId').val(json.alumno.barrioGarante);
            $('#barrioLaboralId').val(json.alumno.barrioLaboral);
            $('#barrioTutorId').val(json.alumno.barrioTutor);
            $('#calleDomicilioId').val(json.alumno.calleDomicilio);
            $('#calleGaranteId').val(json.alumno.calleGarante);
            $('#calleLaboralId').val(json.alumno.calleLaboral);
            $('#calleTutorId').val(json.alumno.calleTutor);
            $('#emailId').val(json.alumno.email);
            $('#establecimientoProcedenciaId').val(json.alumno.establecimientoProcedencia);
            if(json.alumno.estadoAcademico)
                $('#estadoAcademicoId').val(json.alumno.estadoAcademico.name);
            if(json.alumno.fechaNacimiento)
                $('#fechaNacimientoId').val(json.alumno.fechaNacimiento.substring(8,10)+'/'+json.alumno.fechaNacimiento.substring(5,7)+'/'
                    +json.alumno.fechaNacimiento.substring(0,4));
            $('#legajoId').val(json.alumno.legajo);

            if(json.localidadNac){
                $('#localidadNacId').val(json.localidadNac.nombre);
                $('#localidadNacIdId').val(json.localidadNac.id);

                $('#provinciaNacId').val(json.provinciaNac.nombre);
                $('#provinciaNacIdId').val(json.provinciaNac.id);

                $('#paisNacId').val(json.paisNac.nombre);
                $('#paisNacIdId').val(json.paisNac.id);
            }
            if(json.localidadDomicilio){
                $('#localidadDomicilioId').val(json.localidadDomicilio.nombre);
                $('#localidadDomicilioIdId').val(json.localidadDomicilio.id);

                $('#provinciaDomicilioId').val(json.provinciaDomicilio.nombre);
                $('#provinciaDomicilioIdId').val(json.provinciaDomicilio.id);

                $('#paisDomicilioId').val(json.paisDomicilio.nombre);
                $('#paisDomicilioIdId').val(json.paisDomicilio.id);
            }
            if(json.localidadLaboral){
                $('#localidadLaboralId').val(json.localidadLaboral.nombre);
                $('#localidadLaboralIdId').val(json.localidadLaboral.id);

                $('#provinciaLaboralId').val(json.provinciaLaboral.nombre);
                $('#provinciaLaboralIdId').val(json.provinciaLaboral.id);

                $('#paisLaboralId').val(json.paisLaboral.nombre);
                $('#paisLaboralIdId').val(json.paisLaboral.id);
            }

            if(json.localidadTutor ){
                $('#localidadTutorId').val(json.localidadTutor.nombre);
                $('#localidadTutorIdId').val(json.localidadTutor.id);

                $('#provinciaTutorId').val(json.provinciaTutor.nombre);
                $('#provinciaTutorIdId').val(json.provinciaTutor.id);

                $('#paisTutorId').val(json.paisTutor.nombre);
                $('#paisTutorIdId').val(json.paisTutor.id);
            }

            if(json.localidadGarante ){
                $('#localidadGaranteId').val(json.localidadGarante.nombre);
                $('#localidadGaranteIdId').val(json.localidadGarante.id);

                $('#provinciaGaranteId').val(json.provinciaGarante.nombre);
                $('#provinciaGaranteIdId').val(json.provinciaGarante.id);

                $('#paisGaranteId').val(json.paisGarante.nombre);
                $('#paisGaranteIdId').val(json.paisGarante.id);
            }



            $('#lugarLaboralId').val(json.alumno.lugarLaboral);
            $('#nombre').val(json.alumno.nombre);
            $('#numeroDomicilioId').val(json.alumno.numeroDomicilio);
            $('#numeroGaranteId').val(json.alumno.numeroGarante);
            $('#numeroLaboralId').val(json.alumno.numeroLaboral);
            $('#numeroTutorId').val(json.alumno.numeroTutor);
            $('#parentezcoGaranteId').val(json.alumno.parentezcoGarante);
            $('#parentezcoTutorId').val(json.alumno.parentezcoTutor);
            $('#profesionGaranteId').val(json.alumno.profesionGarante);
            $('#profesionTutorId').val(json.alumno.profesionTutor);
            if(json.alumno.sexo)
                $('#sexoId').val(json.alumno.sexo.name);
            if(json.alumno.situacionAcademicas)
                $('#situacionAcademicaId').val(json.alumno.situacionAcademicas.name);
            if(json.alumno.situacionAdministrativa)
                $('#situacionAdministrativaId').val(json.alumno.situacionAdministrativa.name);
            $('#telefonoAlternativoId').val(json.alumno.telefonoAlternativo);
            $('#telefonoCelularId').val(json.alumno.telefonoCelular);
            $('#telefonoGaranteId').val(json.alumno.telefonoGarante);
            $('#telefonoLaboralId').val(json.alumno.telefonoLaboral);
            if(json.alumno.tipoDocumento)
                $('#tipoDocumentoId').val(json.alumno.tipoDocumento.name);
            $('#tituloId').val(json.alumno.titulo);
            json.materiasCursarDisponibles
            var griddata = [];
            for(var i=0;i<json.materiasDisponibles.length;i++){
                griddata[i] = {};
                griddata[i]['id'] = json.materiasDisponibles[i].id;
                griddata[i]['idid'] = json.materiasDisponibles[i].id;
                griddata[i]['nivel'] = json.materiasDisponibles[i].nivel.descripcion;
                griddata[i]['codigomateria'] = json.materiasDisponibles[i].codigo;
                griddata[i]['denominacion'] = json.materiasDisponibles[i].denominacion;
                griddata[i]['tipo'] = 'Cursar';
                griddata[i]['tipovalue'] = 'TIPOINSMATERIA_CURSAR';
                griddata[i]['seleccion'] = 'Yes';
            }
            $('#materiasId').jqGrid("clearGridData");
            for (var i = 0; i <= griddata.length; i++) {
                $("#materiasId").jqGrid('addRowData', i + 1, griddata[i]);
            }

        }

     }



			$(function(){
				//-------------wizard ------------------
                var flagerror = false ;
				$("#inscripcionFormId").formwizard({
				 	validationEnabled: true,
				 	historyEnabled: true,
				 	focusFirstInput : true,
				 	textSubmit: 'Enviar',
				 	textNext: 'Siguiente',
				 	textBack: 'Anterior',
                    disableUIStyles : true,
				 	validationOptions : {
                        messages:{
                            'numeroDocumento':{
                                remote:''
                            },
                            'fechaNacimiento':{
                                required: 'dato obligatorio'
                            }
                        },
				 		rules: {
                            'fechaNacimiento':{
                                required: true
                            },
                            "numeroDocumento":{
                                remote : {
                                    url: locvalidate,
                                    type:'post',
                                    dataType: 'json',
                                    beforeSend: function(xhr){
                                        if(!flagerror){
                                            $('#numeroDocumentoId').css('float','left');
                                            $('<div class=\"spinnerwait\" id=\"numeroDocumentoWaitId\"></div>').insertAfter('#numeroDocumentoId');
                                            flagerror = true;
                                        }
                                    },
                                    complete: function(){
                                        $('#numeroDocumentoWaitId').fadeOut(function(){
                                            flagerror = false;
                                        });
                                        $.ajax({
                                            url:locgetdataalumno
                                            //,dataType:'json'
                                            ,data:{value:$('#numeroDocumentoId').val(),carreraId:$('#carreraId').val()}
                                            ,success: function(data){
                                                if(data!='false')
                                                    bindalumnodata(data);
                                                else{
                                                    $('#materiasId').jqGrid("clearGridData");
                                                    bindmaterias();
                                                }

                                            }
                                        });


                                    },
                                    error:function(jqXHR, textStatus, errorThrown){
                                        if(textStatus=='abort')
                                            $('#numeroDocumentoWaitId').fadeOut(function(){
                                                flagerror = false;
                                            });
                                        return false;
                                    }
                                }

                            }
						}
				 	}
				 }
				);
				//--------------fin wizard----------------
        		$.datepicker.setDefaults($.datepicker.regional[ 'es' ]);
        		$('#fechaNacimientoId' ).datepicker(
                    {changeYear:true
                    /*,onSelect: function(dateText, inst) {
                        $('#'+this.id+'_yearId').val(inst.currentYear);
                        $('#'+this.id+'_monthId').val(inst.currentMonth+1);
                        $('#'+this.id+'_dayId').val(inst.currentDay);
                        if($('#'+this.id+'_monthId').val().length==1)
                            $('#'+this.id+'_monthId').val('0'+$('#'+this.id+'_monthId').val());
                        if($('#'+this.id+'_dayId').val().length==1)
                            $('#'+this.id+'_dayId').val('0'+$('#'+this.id+'_dayId').val());
                        }
                        */
                    }
                  );




				$('#paisDomicilioId').lookupfield({source:locpaissearch,
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
				
				$('#provinciaDomicilioId').lookupfield({source:locprovinciasearch,
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
				
		        
				$('#localidadDomicilioId').lookupfield({source:loclocsearch,
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
				$('#paisLaboralId').lookupfield({source:locpaissearch,
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
				
				$('#provinciaLaboralId').lookupfield({source:locprovinciasearch,
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
		
		
		
				$('#localidadLaboralId').lookupfield({source:loclocsearch,
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
				$('#paisNacId').lookupfield({source:locpaissearch,
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
				
				$('#provinciaNacId').lookupfield({source:locprovinciasearch,
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
		
		
				$('#localidadNacId').lookupfield({source:loclocsearch,
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
				$('#paisTutorId').lookupfield({source:locpaissearch,
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
				
				$('#provinciaTutorId').lookupfield({source:locprovinciasearch,
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
		
				
				
		
				$('#localidadTutorId').lookupfield({source:loclocsearch,
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
		
				$('#paisGaranteId').lookupfield({source:locpaissearch,
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
				
				$('#provinciaGaranteId').lookupfield({source:locprovinciasearch,
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
		
		
		
				$('#localidadGaranteId').lookupfield({source:loclocsearch,
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
		
		
		
		
				$('#situacionAdministrativaId').lookupfield({source:locsitadministrativa,
		 				 title:'Situacion Admistrativa' 
						,colNames:['Id','Nombre'] 
						,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
		 				,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}] 
		 				,hiddenid:'situacionAdministrativaIdId' 
		 				,descid:'situacionAdministrativaId' 
		 				,hiddenfield:'id' 
		 				,descfield:['descripcion']});



                /*$('#siguienteId').click(function(){
                    if(lastSel>0){
                        $('#materiasId').jqGrid('saveRow', lastSel);
                        $('#materiasId').jqGrid('restoreRow',lastSel);
                        lastSel=0;
                        return false;
                    }
                });*/


                $('#materiasId').jqGrid({
                    datatype:'local'
                    ,editurl:''
                    ,width:500
                    ,colNames:['Id','IdId','Nivel','Código Materia','Denominación','Tipo','Tipo Value','Select']
                    ,colModel:[
                        {name:'id',index:'id',width:50,editable:false,hidden:true}
                        ,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:false,editoptions:{readOnly:false,size:10},editrules:{required:false}}
                        ,{name:'nivel',index:'nivel',sortable:false,hidden:true,width:120,editable:false,editoptions:{readOnly:false,size:40},editrules:{required:true}}
                        ,{name:'codigomateria',index:'codigomateria',sortable:true,width:120,editable:false,editoptions:{readOnly:false,size:40},editrules:{required:true}}
                        ,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:false,editoptions:{readOnly:false,size:40},editrules:{required:true}}
                        ,{name:'tipo',index:'tipo',sortable:false,width:120,editable:true,edittype:"select"
                                ,editoptions:{value:tiposinscripcion,readOnly:false,size:40},editrules:{required:true}}
                        ,{name:'tipovalue',index:'tipovalue',hidden:true,editable:true}
                        ,{ name: 'seleccion', index: 'seleccion',width:30,  formatter: "checkbox", formatoptions: { disabled: false }, editable: true, edittype: "checkbox" }
                    ]
                    ,onSelectRow: function(id){
                        if(id && id!==lastSel){
                            $('#materiasId').jqGrid('restoreRow',lastSel);
                            $('#materiasId').jqGrid('editRow',id,true);
                            lastSel=id;
                        }
                        return true;
                    },
                    serializeRowData: function (postData) {
                        //postData.name = postData.name.toUpperCase();
                        postData.tipovalue = postData.tipo;
                        return postData;
                    }
                    ,sortname:'denominacion'
                    //,pager: '#pagermateriasId'
                    ,sortorder:'asc'
                    ,caption: 'Materias a Inscribir'
                });
                bindmaterias();



				
  		});
