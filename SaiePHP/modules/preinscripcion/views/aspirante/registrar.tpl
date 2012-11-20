<h1>Registro de Aspirantes</h1>



<form id="formAspiranteId" method="post" enctype="multipart/form-data" >
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
                <div class="span-3">
                    <select class="ui-widget ui-corner-all ui-widget-content" id ="tipodocumentoId" name="tipodocumento">
                        <option value="-1">Seleccione tipo de Documento</option>
                        {foreach from=$tipoDocList item=fila}
                            <option value="{$fila.tipodocumento}">{$fila.descripcion}</option>
                        {/foreach}    
                    </select>
                </div> 
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="numerodocumento">N&uacute;mero de Documento: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="numerodocumentoId" name="numerodocumento" />
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="apellido">Apellido: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="apellidoId" name="apellido" />
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="nombre">Nombre: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="nombreId" name="nombre" />
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="fechanacimiento">Fecha Nacimiento: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="fechanacimientoId" name="fechanacimiento" />
                </div>
        </fieldset> 

        <fieldset>
            <legend>Datos de Nacimiento</legend>
                <div class="span-3 spanlabel">
                    <label for="localidadnacimientodesc">Localidad: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="localidadnacimientodescId" name="localidadnacimientodesc" />
                    <input type="hidden" id="localidadnacimientoId" name="localidadnacimiento" />
                </div>
                <div class="clear"></div>
                
                <div class="span-3 spanlabel">
                    <label for="provincianacimientodesc">Provincia: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="provincianacimientodescId" name="provincianacimientodesc" />
                    <input type="hidden" id="localidadnacimientoId" name="localidadnacimiento" />                    
                </div>
                <div class="clear"></div>
                
                <div class="span-3 spanlabel">
                    <label for="paisnacimientodesc">Pa&iacute;s: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="paisnacimientodescId" name="paisnacimientodesc" />
                    <input type="hidden" id="paisnacimientoId" name="paisnacimiento" />                    
                </div>
                <div class="clear"></div>
            
        </fieldset>            
                    
                    
        <fieldset>
            <legend>Domicilio</legend>
                <div class="span-3 spanlabel">
                    <label for="calle">Calle: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="calleId" name="calle" />
                </div>
                <div class="clear"></div>
            
                
                <div class="span-3 spanlabel">
                    <label for="callenumero">N&uacute;mero: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="callenumeroId" name="callenumero" />
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="barrio">Barrio: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="barrioId" name="barrio" />
                </div>
                <div class="clear"></div>
                
                <div class="span-3 spanlabel">
                    <label for="localidaddesc">Localidad: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="localidaddescId" name="localidaddesc" />
                    <input type="hidden" id="localidadId" name="localidad" />
                </div>
                <div class="clear"></div>
                
                <div class="span-3 spanlabel">
                    <label for="provinciadesc">Provincia: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="provinciadescId" name="provinciadesc" />
                    <input type="hidden" id="localidadId" name="localidad" />                    
                </div>
                <div class="clear"></div>
                
                <div class="span-3 spanlabel">
                    <label for="paisdesc">Pa&iacute;s: </label>
                </div>
                <div class="span-3">
                    <input class="ui-widget ui-corner-all ui-widget-content" readonly
                           style="background-color: #ddd" type="text" id="paisdescId" name="paisdesc" />
                    <input type="hidden" id="paisId" name="pais" />                    
                </div>
                <div class="clear"></div>

        </fieldset>  
                    
        <fieldset>
            <legend>Datos de Contacto</legend>
            <div class="span-3 spanlabel">
                <label for="telefonoparticular">Tel&eacute;fono Particular: </label>
            </div>
            <div class="span-3">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonoparticularId" name="telefonoparticular" />
            </div>
            <div class="clear"></div>
            <div class="span-3 spanlabel">
                <label for="telefonocelular">Tel&eacute;fono Particular: </label>
            </div>
            <div class="span-3">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonocelularId" name="telefonocelular" />
            </div>
            <div class="clear"></div>
            <div class="span-3 spanlabel">
                <label for="email">E-mail: </label>
            </div>
            <div class="span-3">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="emailId" name="email" />
            </div>
            <div class="clear"></div>
            <div class="span-3 spanlabel">
                <label for="email">Tel&eacute;fono Alternativo: </label>
            </div>
            <div class="span-3">
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
            <legend>Datos Labores</legend>
        </fieldset>

        <fieldset>
            <legend>Otros Datos</legend>
        </fieldset>
        
    </span> <!-- span fin datos del tutorgarante -->

</form>

{literal}                    
<script type="text/javascript">
      $(function(){
                    $("#formAspiranteId").formwizard({ 
        	    formPluginEnabled: true,
                    disableUIStyles : true,
                    validationEnabled: true,
                    focusFirstInput : true,
                    formOptions :{
                            success: function(data){$("#status").fadeTo(500,1,function(){ $(this).html("You are now registered!").fadeTo(5000, 0); })},
                            beforeSubmit: function(data){$("#data").html("data sent to the server: " + $.param(data));},
                            dataType: 'json',
                            resetForm: true
                        }	
                    });    
       });                 
</script>
{/literal}