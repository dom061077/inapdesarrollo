


 
<form id="formAspiranteId" method="post" enctype="multipart/form-data" action="{$_layoutParams.root}preinscripcion/aspirante/saveregistrar" >
    <span id="alumnoId" class="step">
        <span class="wizardspan"><h2>Primer Paso -Datos del Alumno</h2></span>
        <div class="clear"> </div>
        <fieldset>
            <legend>Datos Personales</legend>
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
                    {if (array_key_exists('numerodocumento',$_error))}
                        {assign var="numerodocumentoinvalid" value='invalid'}
                    {/if}
                    <input class="ui-widget ui-corner-all ui-widget-content {$numerodocumentoinvalid}" type="text" id="numerodocumentoId" value="{$datos["numerodocumento"]}" name="numerodocumento" />
                    {if (array_key_exists('numerodocumento',$_error))}
                        <div class="{$numerodocumentoinvalid}" for="apellidoId" generated="true">{$_error['numerodocumento']}</div>
                    {/if}    
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="apellido">Apellido: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content"  type="text" id="apellidoId" name="apellido" value="{$datos["apellido"]}" />
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="nombre">Nombre: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="nombreId" name="nombre" value="{$datos["nombre"]}"/>
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="fechanacimiento">Fecha Nacimiento: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="fechanacimientoId" name="fechanacimiento" value="{$datos["fechanacimiento"]}" />
                </div>
        </fieldset> 

        <fieldset>
            <legend>Datos de Nacimiento</legend>
                <div class="span-3">
                    <label for="paisnacimiento">Pa&iacute;s: </label>
                </div>
                <div class="span-7">
                    <input style="background-color: #ddd" type="text" id="paisnacimientoId" name="paisnacimientonacimiento" descValue="{$datos["paisnacimientoDesc"]}"
                           value="{$datos["paisnacimiento"]}" />
                </div>
                <div class="clear"></div>
            
                
                <div class="span-3 spanlabel">
                    <label for="provincianacimiento">Provincia: </label>
                </div>
                <div class="span-7 spanlabel">
                    <input class="ui-widget ui-corner-all ui-widget-content" 
                           style="background-color: #ddd" type="text" id="provincianacimientoId" name="provincianacimiento" 
                           descValue="{$datos["provincianacimientoDesc"]}" value="{$datos["provincianacimiento"]}"/>
                </div>
                <div class="clear"></div>
                
                <div class="span-3 spanlabel">
                    <label for="localidadnacimiento">Localidad: </label>
                </div>
                <div class="span-7 spanlabel">
                    <input class="ui-widget ui-corner-all ui-widget-content" 
                           style="background-color: #ddd" type="text" id="localidadnacimientoId" name="localidadnacimiento" 
                           descValue="{$datos["localidadnacimientoDesc"]}" value="{$datos["localidadnacimiento"]}"/>
                </div>
                <div class="clear"></div>
                
                
            
        </fieldset>            
                    
                    
        <fieldset>
            <legend>Domicilio</legend>
                <div class="span-3 spanlabel">
                    <label for="calle">Calle: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="calleId" name="calle" 
                           value="{$datos["calle"]}"/>
                </div>
                <div class="clear"></div>
            
                
                <div class="span-3 spanlabel">
                    <label for="callenumero">N&uacute;mero: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="callenumeroId" name="callenumero" 
                           value="{$datos["callenumero"]}"/>
                </div>
                <div class="clear"></div>

                <div class="span-3 spanlabel">
                    <label for="barrio">Barrio: </label>
                </div>
                <div class="span-7">
                    <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="barrioId" name="barrio" 
                           value="{$datos["barrio"]}"/>
                </div>
                <div class="clear"></div>

                
                <div class="span-3 spanlabel">
                    <label for="paisdesc">Pa&iacute;s: </label>
                </div>
                <div class="span-7 spanlabel">
                    <input  style="background-color: #666" type="text" id="paisdomicilioId" name="paisdomicilio" 
                            descValue="{$datos["paisdomicilioDesc"]}" value="{$datos["paisdomicilio"]}"/>
                </div>
                <div class="clear"></div>
                
                
                <div class="span-3 spanlabel">
                    <label for="provinciadesc">Provincia: </label>
                </div>
                <div class="span-7 spanlabel">
                    <input class="ui-widget ui-corner-all ui-widget-content" 
                           style="background-color: #ddd" type="text" id="provinciadomicilioId" name="provinciadomicilio" 
                           descValue="{$datos["provinciadomicilioDesc"]}" value="{$datos["provinciadomicilio"]}"/>
                </div>
                <div class="clear"></div>
                
                <div class="span-3 spanlabel">
                    <label for="localidaddesc">Localidad: </label>
                </div>
                <div class="span-7 spanlabel">
                    <input class="ui-widget ui-corner-all ui-widget-content" 
                           style="background-color: #ddd" type="text" id="localidaddomicilioId" name="localidaddomicilio" 
                           descValue="{$datos["localidaddomicilioDesc"]}" value="{$datos["localidaddomicilio"]}"/>
                </div>
                <div class="clear"></div>
                

        </fieldset>  
                    
        <fieldset>
            <legend>Datos de Contacto</legend>
            <div class="span-3 spanlabel">
                <label for="telefonoparticular">Tel&eacute;fono Particular: </label>
            </div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonoparticularId" name="telefonoparticular" 
                       value="{$datos["telefonoparticular"]}"/>
            </div>
            <div class="clear"></div>
            <div class="span-3 spanlabel">
                <label for="telefonocelular">Tel&eacute;fono Celular: </label>
            </div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonocelularId" name="telefonocelular" 
                       value="{$datos["telefonocelular"]}"/>
            </div>
            <div class="clear"></div>
            <div class="span-3 spanlabel">
                <label for="email">E-mail: </label>
            </div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="emailId" name="email" 
                       value="{$datos["email"]}"/>
            </div>
            <div class="clear"></div>
            <div class="span-3 spanlabel">
                <label for="email">Tel&eacute;fono Alternativo: </label>
            </div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonoalternativoId" name="telefonoalternativo" 
                       value="{$datos["telefonoalternativo"]}"/>
            </div>
            <div class="clear"></div>
        </fieldset>            
    </span> <!-- span fin datos del Alumno  -->

    
    <span id="datostutorgarenteId" class="step">
        <span class="wizardspan"><h2>Segundo Paso - Datos del Tutor y el Garante</h2></span>
        <div class="clear"></div>
        <fieldset>
            <legend>Datos del Tutor</legend>
            <div class="span-4  spanlabel">Apellido y Nombre:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="apellidoynombretutorId" name="apellidoynombretutor" 
                       value="{$datos["apellidoynombretutor"]}"/>
            </div>
            <div class="clear"></div>
            
            <div class="span-4  spanlabel">Profesión:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="profesiontutorId" name="profesiontutor" 
                       value="{$datos["profesiontutor"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Parentesco:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="parentescotutorId" name="parentescotutor" 
                       value="{$datos["parentescotutor"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Teléfono:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonotutorId" name="telefono" 
                       value="{$datos["telefono"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Calle:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="calletutorId" name="calletutor" 
                       value="{$datos["calletutor"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Barrio:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="barrio" name="numerocalletutor" 
                       value="{$datos["numerocalletutor"]}"/>
            </div>
            <div class="clear"></div>            
            
            
            <div class="span-4  spanlabel">Pa&iacute;s:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="paistutorId" name="paistutor" 
                       descValue="{$datos["paistutorDesc"]}" value="{$datos["paistutor"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Provincia:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="provinciatutorId" name="provinciatutor" 
                       descValue="{$datos["provinciatutorDesc"]}" value="{$datos["provinciatutor"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Localidad:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="localidadtutorId" name="localidadtutor" 
                       descValue="{$datos["localidadtutorDesc"]}" value="{$datos["localidadtutor"]}"/>
            </div>
            <div class="clear"></div>            
        </fieldset>    
        
        <fieldset>
            <legend>Datos del Garante</legend>
            <div class="span-4  spanlabel">Apellido y Nombre:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="apellidoynombregaranteId" name="apellidoynombregarante"
                       value="{$datos["apellidoynombregarante"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Profesi&oacute;n:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="profesiongaranteId" name="profesiongarante" 
                       value="{$datos["profesiongarante"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Parentesco:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="parentescogarenteId" name="parentescogarante" 
                       value="{$datos["parentescogarante"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Tel&eacute;fono:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonogaranteId" name="telefonogarante" 
                       value="{$datos["telefonogarante"]}"/>
            </div>
            <div class="clear"></div> 
            
            <div class="span-4  spanlabel">Calle:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="callegaranteId" name="callegarante" 
                       value="{$datos["callegarante"]}"/>
            </div>
            <div class="clear"></div>  
            
            <div class="span-4  spanlabel">N&uacute;mero:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="numerocallegaranteId" name="numerocallegarante" 
                       value="{$datos["numerocallegarante"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Barrio:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="barriogaranteId" name="barriogarante" 
                       value="{$datos["barriogarante"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Pa&iacute;s:</div>
            <div class="span-7 spanlabel">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="paisgaranteId" name="paisgarante" 
                       descValue="{$datos["paisgaranteDesc"]}" value="{$datos["paisgarante"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Provincia:</div>
            <div class="span-7 spanlabel">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="provinciagaranteId" name="provinciagarante" 
                       descValue="{$datos["provinciagaranteDesc"]}" value="{$datos["provinciagarante"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Localidad:</div>
            <div class="span-7 spanlabel">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="localidadgaranteId" name="localidadgarante" 
                       descValue="{$datos["localidadgaranteDesc"]}" value="{$datos["localidadgarante"]}"/>
            </div>
            <div class="clear"></div>            
        </fieldset>    
        <div class="clear"></div>
    </span> <!-- span fin datos del otrosdatos -->
    
    <span id="otrosdatosId" class="step">
        <span class="wizardspan"><h2>Segundo Paso - Datos del Tutor y el Garante</h2></span>
        <div class="clear"></div>
        <fieldset>
            <legend>Datos Acad&eacute;micos</legend>
            <div class="span-4  spanlabel">Establecimiento de Procedencia:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="establecimientoprocedeId" name="establecimientoprocede" 
                       value="{$datos["establecimientoprocede"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">T&iacute;tulo:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="tituloobtenidoId" name="tituloobtenido" 
                       value="{$datos["tituloobtenido"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">A&nacute;o de Egreso:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="anioegresoId" name="anioegreso" 
                       value="{$datos["anioegreso"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Secundario Completo:</div>
            <div class="span-7 spanlabel">
                <input class="ui-widget ui-corner-all ui-widget-content" type="checkbox" id="secundariocompletoId" name="secundariocompleto" 
                       value="{$datos["secundariocompleto"]}"/>
            </div>
            <div class="clear"></div>            
        </fieldset>
        
        <fieldset>
            <legend>Datos Laborales:</legend>
            <div class="span-4  spanlabel">Lugar:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="lugarlaboralId" name="lugarlaboral" 
                       value="{$datos["lugarlaboral"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Tel&eacute;fono:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="telefonolaboralId" name="telefonolaboral" 
                       value="{$datos["telefonolaboral"]}"/>
            </div>
            <div class="clear"></div>            
            
            
            <div class="span-4  spanlabel">Pa&iacute;s:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="paislaboralId" name="paislaboral" 
                       descValue="{$datos["paislaboralDesc"]}" value="{$datos["paislaboral"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Provincia:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="provincialaboralId" name="provincialaboral" 
                       descValue="{$datos["provincialaboralDesc"]}" value="{$datos["provincialaboral"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Localidad:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="localidadlaboralId" name="localidadlaboral" 
                       descValue="{$datos["localidadlaboralDesc"]}" value="{$datos["localidadlaboral"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">Barrio:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="barriolaboralId" name="barriolaboral" 
                       value="{$datos["barriolaboral"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Calle:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="callelaboralId" name="callelaboral" 
                       value="{$datos["callelaboral"]}"/>
            </div>
            <div class="clear"></div>            
            
            <div class="span-4  spanlabel">N&uacute;mero:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="numerocallelaboralId" name="numerocallelaboral" 
                       value="{$datos["numerocallelaboral"]}"/>
            </div>
            <div class="clear"></div>            
        </fieldset>
        
        <fieldset>
            <legend>Otros Datos</legend>
            <div class="span-4  spanlabel">Situaci&oacute;n Acad&eacute;mica:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="situacionacademicaId" name="situacionacademica" 
                       value="{$datos["situacionacademica"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Situaci&oacute;n Administrativa:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="situacionadministrativaId" name="situacionadministrativa" 
                       value="{$datos["situacionadministrativa"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Legajo:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="text" id="legajoId" name="legajo" 
                       value="{$datos["legajo"]}"/>
            </div>
            <div class="clear"></div>            

            <div class="span-4  spanlabel">Foto:</div>
            <div class="span-7">
                <input class="ui-widget ui-corner-all ui-widget-content" type="file" id="fotoId" name="foto" />
            </div>
            <div class="clear"></div>            
            
        </fieldset>
        
    </span>
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
                    $('#fechanacimientoId').datepicker({
                        onSelect: function(date){
                           var e = jQuery.Event("keyup");
                            e.which = 17;//tecla ctrl
                            $("#fechanacimientoId").trigger(e);

                        }
                    });    
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
                        errorElement:'div',
                        ignore:'',
                        //success: function(label){
                        //    alert(label);
                        //},
                        messages:{
                            'numerodocumento':{
                                remote:'Ya exite el numero de documento',
                                digits:'Ingrese solo valores numéricos',
                                required: 'Dato obligatorio'
                            },
                            'apellido':{
                                required: 'Dato obligatorio'
                            },
                            'fechanacimiento':{
                                required:'Dato obligatorio'
                                ,dateITA:'Ingrese una fecha correcta'
                            },
                            'nombre':{
                                required: 'Dato obligatorio'
                            },
                            'tipodocumento':{
                                required: 'Dato obligatorio'
                            },
                            'paisnacimiento':{
                                required: 'Dato obligatorio'
                            },
                            'provincianacimiento':{
                                required: 'Dato obligatorio'
                            },
                            'localidadnacimiento':{
                                required: 'Dato obligatorio'
                            },
                            'calle':{
                                required: 'Dato obligatorio'
                            },
                            'callenumero':{
                                required: 'Dato obligatorio'
                            },
                            'barrio':{
                                required:'Dato obligatorio'
                              },    
                            'paisdomicilio':{
                                required: 'Dato obligatorio'
                            },
                            'provinciadomicilio':{
                                required: 'Dato obligatorio'
                            },
                            'localidaddomicilio':{
                                required: 'Dato obligatorio'
                            },
                            'telefonoparticular':{
                                required: 'Dato obligatorio'
                            },
                            'email':{
                                required: 'Dato obligatorio',
                                email: 'Ingrese un e-mail correcto'    
                            }
                              
                              
                                
                                
                        },
			rules: {
                            
                            'fechanacimiento':{
                                required: true
                                ,dateITA: true
                            },
                            'apellido':{
                                required: true
                            },
                            'nombre':{
                               required: true
    
                            },
                            'numerodocumento':{
                                required:true,
                                digits:true,    
                                remote : //
                                    {
                                        url: locnrodocvalidation,
                                        type:'post',
                                        dataType: 'json',
                                        beforeSend: function(xhr){
                                            if(!flagerror){
                                                if($('#numeroCheckedId').length > 0)
                                                    $('#numeroCheckedId').hide();
                                                $('#numerodocumentoId').css('float','left');
                                                if($('#numeroDocumentoWaitId').length > 0)
                                                    $('#numeroDocumentoWaitId').show();
                                                else    
                                                    $('<div class=\"spinnerwait\" id=\"numeroDocumentoWaitId\">Verificando Numero...</div>').insertAfter('#numerodocumentoId');
                                                flagerror = true;
                                            }
                                        },
                                        complete: function(data){
                                            $('#numeroDocumentoWaitId').fadeOut(function(){
                                                flagerror = false;
                                            });
                                           if(data.responseText=="true" ){
                                               if ($('#numerodocumentoId').val().length>0){
                                                    if($('#numeroCheckedId').length > 0)
                                                         $('#numeroCheckedId').show();
                                                    else    
                                                         $('<div class=\"checked\" id=\"numeroCheckedId\">').insertAfter('#numerodocumentoId');
                                               }else
                                                    $('#numeroCheckedId').hide();
                                           }else
                                               $('#numeroCheckedId').hide();
                                         }
                                    }        
                            }/*,
                            'paisnacimiento':{
                                required:true
                             },
                            'provincianacimiento':{
                                required:true
                            },
                            'localidadnacimiento':{
                                required:true
                            },
                            'calle':{
                                required:true
                            },
                            'callenumero':{
                                required:true
                            },
                            'barrio':{
                                required:true
                            },
                            'paisdomicilio':{
                                required:true
                            },
                            'provinciadomicilio':{
                                required:true
                            },
                            'localidaddomicilio':{
                                required:true
                            },
                            'email':{
                                required:true,
                                email:true
                            },
                            'telefonoparticular':{
                                required:true
                            }*/
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
                       localidadNacimiento.clear();
                       var e = jQuery.Event("keyup");
                       e.which = 17;//tecla ctrl
                       $("#paisnacimientoId").trigger(e);
                     }
                });
                    
                var paisDomicilio = $('#paisdomicilioId').combolookupfield({
                    grid: {
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:locpaises
                    }
                    ,inputNameDesc: 'paisdomicilioDesc'
                    ,onSelected: function(){
                        provinciaDomicilio.clear();
                        localidadDomicilio.clear();
                       var e = jQuery.Event("keyup");
                       e.which = 17;//tecla ctrl
                       $("#paisdomicilioId").trigger(e);
                            
                     }
                });    

                var paisTutor = $('#paistutorId').combolookupfield({
                    grid: {
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:locpaises
                    }
                    ,inputNameDesc: 'paistutorDesc'
                    ,onSelected: function(){
                        provinciaTutor.clear();
                        localidadTutor.clear();
                       var e = jQuery.Event("keyup");
                       e.which = 17;//tecla ctrl
                       $("#paistutorId").trigger(e);
                            
                     }
                });    

                var paisGarante = $('#paisgaranteId').combolookupfield({
                    grid: {
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:locpaises
                    }
                    ,inputNameDesc: 'paisgaranteDesc'
                    ,onSelected: function(){
                        provinciaGarante.clear();
                        localidadGarante.clear();
                       var e = jQuery.Event("keyup");
                       e.which = 17;//tecla ctrl
                       $("#paisgaranteId").trigger(e);
                            
                     }
                });    

                var paisLaboral = $('#paislaboralId').combolookupfield({
                    grid: {
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:locpaises
                    }
                    ,inputNameDesc: 'paislaboralDesc'
                    ,onSelected: function(){
                        provinciaGarante.clear();
                        localidadGarante.clear();
                       var e = jQuery.Event("keyup");
                       e.which = 17;//tecla ctrl
                       $("#paislaboralId").trigger(e);
                            
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
                        var e = jQuery.Event("keyup");
                        e.which = 17;//tecla ctrl
                        $("#provincianacimientoId").trigger(e);
                        
                    }
                });
                var provinciaDomicilio = $('#provinciadomicilioId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:locprovincias
                    }
                    ,inputNameDesc:'provinciadomicilioDesc'
                    ,cascade:{
                        elementCascadeId:['paisdomicilioId'],
                        paramName:['id_pais']
                    }
                    ,onSelected:function(){
                        localidadDomicilio.clear();
                        var e = jQuery.Event("keyup");
                        e.which = 17;//tecla ctrl
                        $("#provinciadomicilioId").trigger(e);
                            
                    }
                });
                var provinciaTutor = $('#provinciatutorId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:locprovincias
                    }
                    ,inputNameDesc:'provinciatutorDesc'
                    ,cascade:{
                        elementCascadeId:['paistutorId'],
                        paramName:['id_pais']
                    }
                    ,onSelected:function(){
                        localidadTutor.clear();
                        var e = jQuery.Event("keyup");
                        e.which = 17;//tecla ctrl
                        $("#provinciadomicilioId").trigger(e);
                            
                    }
                });
                    
                var provinciaGarante = $('#provinciagaranteId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:locprovincias
                    }
                    ,inputNameDesc:'provinciagaranteDesc'
                    ,cascade:{
                        elementCascadeId:['paisgaranteId'],
                        paramName:['id_pais']
                    }
                    ,onSelected:function(){
                        localidadGarante.clear();
                        var e = jQuery.Event("keyup");
                        e.which = 17;//tecla ctrl
                        $("#provinciadomicilioId").trigger(e);
                            
                    }
                });

                var provinciaLaboral = $('#provincialaboralId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:locprovincias
                    }
                    ,inputNameDesc:'provincialaboralDesc'
                    ,cascade:{
                        elementCascadeId:['paislaboralId'],
                        paramName:['id_pais']
                    }
                    ,onSelected:function(){
                        localidadGarante.clear();
                        var e = jQuery.Event("keyup");
                        e.which = 17;//tecla ctrl
                        $("#provincialaboralId").trigger(e);
                            
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
                        paramName:['id_provincia']}
                    ,onSelected: function(){
                       var e = jQuery.Event("keyup");
                       e.which = 17;//tecla ctrl
                       $("#localidadnacimientoId").trigger(e);
                        
                    }
                });
                var localidadDomicilio = $('#localidaddomicilioId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:loclocalidades
                    }
                    ,inputNameDesc:'localidaddomicilioDesc'
                    ,cascade:{
                        elementCascadeId:['provinciadomicilioId'],
                        paramName:['id_provincia']
                    },
                    onSelected: function(){
                       var e = jQuery.Event("keyup");
                       e.which = 17;//tecla ctrl
                       $("#localidaddomicilioId").trigger(e);
                    }
                });
                var localidadTutor = $('#localidadtutorId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:loclocalidades
                    }
                    ,inputNameDesc:'localidadtutorDesc'
                    ,cascade:{
                        elementCascadeId:['provinciatutorId'],
                        paramName:['id_provincia']
                    },
                    onSelected: function(){
                       var e = jQuery.Event("keyup");
                       e.which = 17;//tecla ctrl
                       $("#localidadtutorId").trigger(e);
                    }
                });
                var localidadGarante = $('#localidadgaranteId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:loclocalidades
                    }
                    ,inputNameDesc:'localidadgaranteDesc'
                    ,cascade:{
                        elementCascadeId:['provinciagaranteId'],
                        paramName:['id_provincia']
                    },
                    onSelected: function(){
                       var e = jQuery.Event("keyup");
                       e.which = 17;//tecla ctrl
                       $("#localidadGaranteId").trigger(e);
                    }
                });
                var localidadLaboral = $('#localidadlaboralId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:loclocalidades
                    }
                    ,inputNameDesc:'localidadlaboralDesc'
                    ,cascade:{
                        elementCascadeId:['provincialaboralId'],
                        paramName:['id_provincia']
                    },
                    onSelected: function(){
                       var e = jQuery.Event("keyup");
                       e.which = 17;//tecla ctrl
                       $("#localidadLaboralId").trigger(e);
                    }
                });
                    
                    
                        
       });                 
</script>
{/literal}