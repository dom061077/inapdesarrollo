



<form id="formAspiranteId" method="post" enctype="multipart/form-data" action="{$_layoutParams.root}preinscripcion/aspirante/saveregistrar" >
    <span id="alumnoId" class="step">
        <span class="wizardspan"><h2>Primer Paso -Datos del Alumno</h2></span>
        <div class="clear"> </div>
        <fieldset>
            <legend>Datos Personales</legend>
                <!--div class="span-10">
                        <div class="span-3 spanlabel">
                            <label for="carreraDesc">Carrera:</label>
                        </div>
                        <div class="span-3">
                            <input class="ui-widget ui-corner-all ui-widget-content" style="background-color:#D9D9D9;"
                                   readonly type="text" id="carreraDescId" name="carreraDesc" value="{$datos.carreradesc|default:""}" />
                            <input type="hidden" id="carreraId" name="carrera" value="{$datos.carrera|default:""}"/>
                        </div>
                        <div class="clear"></div>

                        <div class="span-3 spanlabel">
                            <label for="aniolectivo">A&ntildeo:</label>
                        </div>
                        <div class="span-3">
                            <input type="text"class="ui-widget ui-corner-all ui-widget-content" style="background-color:#D9D9D9;"
                                   name="aniolectivo" />
                        </div>    
                </div>                        
                <div class="clear"></div -->
                
            
                <div class="span-3 spanlabel" >
                    <label for="tipodocumento"> Tipo Documento:</label>
                </div>
                <div class="span-7">
                    <select class="ui-widget ui-corner-all ui-widget-content required" id ="tipodocumentoId" name="tipodocumento">
                        <option value="">Seleccione tipo de Documento</option>
                        {foreach from=$tipoDocList item=fila}
                            <option value="{$fila.tipodocumento}">{$fila.descripcion}</option>
                        {/foreach}    
                    </select>
                </div> 
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="numerodocumento">N&uacute;mero de Documento: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="numerodocumentoId" value="{$datos["numerodocumento"]}" name="numerodocumento" />
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="apellido">Apellido: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="apellidoId" name="apellido" value="{$datos["apellido"]}" />
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="nombre">Nombre: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="nombreId" name="nombre" />
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="fechanacimiento">Fecha Nacimiento: </label>
                </div>
                <div class="span-7">
                    {literal}
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="fechanacimientoId" name="fechanacimiento" />
                    {/literal}
                </div>
        </fieldset> 

        <fieldset>
            <legend>Datos de Nacimiento</legend>
                <div class="span-3">
                    <label for="paisnacimiento">Pa&iacute;s: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="paisnacimientoId" name="paisnacimiento" />
                </div>
                <div class="clear"></div>
            
                
                <div class="span-3 spanlabel">
                    <label for="provincianacimiento">Provincia: </label>
                </div>
                <div class="span-7 spanlabel">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="provincianacimientoId" name="provincianacimiento" />
                </div>
                <div class="clear"></div>
                
                <div class="span-3 spanlabel">
                    <label for="localidadnacimiento">Localidad: </label>
                </div>
                <div class="span-7 spanlabel">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="localidadnacimientoId" name="localidadnacimiento" />
                </div>
                <div class="clear"></div>
                
                
            
        </fieldset>            
                    
                    
        <fieldset>
            <legend>Domicilio</legend>
                <div class="span-3 spanlabel">
                    <label for="calle">Calle: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="calleId" name="calle" />
                </div>
                <div class="clear"></div>
            
                
                <div class="span-3 spanlabel">
                    <label for="callenumero">N&uacute;mero: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="callenumeroId" name="callenumero" />
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="barrio">Barrio: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="barrioId" name="barrio" />
                </div>
                <div class="clear"></div>

                
                <div class="span-3">
                    <label for="paisdesc">Pa&iacute;s: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #666" type="text" id="paisdescId" name="paisdesc" />
                    <input type="hidden" id="paisId" name="pais" />                    
                </div>
                <div class="clear"></div>
                
                
                <div class="span-3 spanlabel">
                    <label for="provinciadesc">Provincia: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="provinciadescId" name="provinciadesc" />
                    <input type="hidden" id="localidadId" name="localidad" />                    
                </div>
                <div class="clear"></div>
                
                <div class="span-3 spanlabel">
                    <label for="localidaddesc">Localidad: </label>
                </div>
                <div class="span-7 spanlabel">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="localidaddescId" name="localidaddesc" />
                    <input type="hidden" id="localidadId" name="localidad" />
                </div>
                <div class="clear"></div>
                

        </fieldset>  
                    
        <fieldset>
            <legend>Datos de Contacto</legend>
            <div class="span-3 spanlabel">
                <label for="telefonoparticular">Tel&eacute;fono Particular: </label>
            </div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonoparticularId" name="telefonoparticular" />
            </div>
            <div class="clear"></div>
            <div class="span-3 spanlabel">
                <label for="telefonocelular">Tel&eacute;fono Particular: </label>
            </div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonocelularId" name="telefonocelular" />
            </div>
            <div class="clear"></div>
            <div class="span-3 spanlabel">
                <label for="email">E-mail: </label>
            </div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="emailId" name="email" />
            </div>
            <div class="clear"></div>
            <div class="span-3 spanlabel">
                <label for="email">Tel&eacute;fono Alternativo: </label>
            </div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonoalternativoId" name="telefonoalternativo" />
            </div>
            <div class="clear"></div>
        </fieldset>            
    </span> <!-- span fin datos del Alumno  -->

    <span id="tutorgaranteId" class="step">
        <span class="wizardspan"><h2>Segundo Paso - Tutor y Garante</h2></span>
        <div class="clear"></div>
        <fieldset>
            <legend>Datos Acad&eacute;micos</legend>
        </fieldset>
        
        <fieldset>
            <legend>Datos Labores</legend>
        </fieldset>

        <fieldset>
            <legend>Otros Datos</legend>
        </fieldset>
        
    </span> <!-- span fin datos del tutorgarante -->
    
    
    <span id="otrosdatosId" class="step">
        <span class="wizardspan"><h2>Tercer Paso - Otros Datos</h2></span>
        <div class="clear"></div>
        <fieldset>
            <legend>Datos Acad&eacute;micos</legend>
        </fieldset>
        
        <fieldset>
            <legend>Datos Laborales</legend>
        </fieldset>

        <fieldset>
            <legend>Otros Datos</legend>
            <div class="span-4 spanlabel">
                <label for="situacionacademica">Situaci&oacute;n Acad&eacute;mica: </label>
            </div>
            <div class="span-3">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="situacionacademicaId" name="situacionacademica" />
            </div>
            <div class="clear"></div>

            <div class="span-4 spanlabel">
                <label for="situacionadministrativa">Situaci&oacute;n Administrativa: </label>
            </div>
            <div class="span-3">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="situacionadministrativaId" name="situacionadministrativa" />
            </div>
            <div class="clear"></div>
            
            <div class="span-4 spanlabel">
                <label for="foto">Foto: </label>
            </div>
            <div class="span-3">
                <input class="ui-widget ui-corner-all ui-widget-content" type="file" id="fotoId" name="foto" />
            </div>
            <div class="clear"></div>

            
        </fieldset>
        
    </span> <!-- span fin datos del tutorgarante -->
    <input class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="anteriorId" value="Anterior" type="reset" />
    <input class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="siguienteId" value="Siguiente" type="submit" />

</form>

<script type="text/javascript">
    var locnrodocvalidation = '{$_layoutParams.root}/preinscripcion/aspirante/exitsnumerodocumento';
    var locpaises = '{$_layoutParams.root}/repositorio/paises';
    var locprovincias = '{$_layoutParams.root}/repositorio/provincias';
    var loclocalidades = '{$_layoutParams.root}/repositorio/localidades';
{literal}                        
      $(function(){
                    var flagerror=false;
                    $("#formAspiranteId").formwizard({ 
        	    formPluginEnabled: false,
                    disableUIStyles : true,
                    validationEnabled: true,
                    focusFirstInput : true,
                    historyEnabled: true,
                    textSubmit: 'Enviar',
                    textNext: 'Siguiente',
                    textBack: 'Anterior',
		    validationOptions : {
                        errorClass:'invalid',
                        messages:{
                            'numerodocumento':{
                                remote:'Ya exite el numero de documento',
                                digits:'Ingrese solo valores numéricos',
                                required: 'Dato boligatorio'
                            },
                            'apellido':{
                                required: 'Dato obligatorio'
                            },
                            'fechanacimiento':{
                                required:'Dato obligatorio'
                            },
                            'nombre':{
                                required: 'Dato obligatorio'
                            },
                            'tipodocumento':{
                                required: 'Dato obligatorio'
                            }
                        },
			rules: {
                            'fechanacimiento':{
                                required: true
                            },
                            'apellido':{
                                required: true
                            },
                            'nombre':{
                                required: true
                            },
                            "numerodocumento":{
                                required:true,
                                digits:true,    
                                remote : locnrodocvalidation
                            }
		      }
		    }                        
                    ,formOptions :{
                            success: function(data){$("#status").fadeTo(500,1,function(){ $(this).html("You are now registered!").fadeTo(5000, 0); })},
                            beforeSubmit: function(data){$("#data").html("data sent to the server: " + $.param(data));},
                            dataType: 'json',
                            resetForm: true
                        }	
                    });   
                        
                var paisNacimiento=$('#paisnacimientoId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:locpaises
                    }
                    ,inputNameDesc:'paisnacimientoDesc'
                    ,onSelected:function(){
                       provinciaNacimiento.clear();                          
                     }
                });
                    
                var provinciaNacimiento=$('#provincianacimientoId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:locprovincias
                    }
                    ,inputNameDesc:'provincianacimientoDesc'
                    ,cascade:{
                        elementCascadeId:['paisnacimientoId'],
                        paramName:['id_pais']
                    }

                    ,onSelected:function(){
                        localidadNacimiento.clear();
                        
                    }
                });
                var localidadNacimiento =  $('#localidadnacimientoId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:loclocalidades
                    }
                    ,inputNameDesc:'localidadnacimientoDesc'
                    ,cascade:{
                        elementCascadeId:['provincianacimientoId'],
                        paramName:['id_provincia']
                    }
                }); 
                    

                        
       });                 
</script>
{/literal}