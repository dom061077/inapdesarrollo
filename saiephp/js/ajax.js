function objetoAjax(){
	var xmlhttp=false;
	try {
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	} catch (e) {
		try {
		   xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (E) {
			xmlhttp = false;
  		}
	}

	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
		xmlhttp = new XMLHttpRequest();
	}
	return xmlhttp;
}

/********************************************/
function BuscaxDoc(){
	if (!document.forms[0].elements['NroDocIdentidad'].value){
		alert("Debe Ingresar Numero de DNI"+document.forms[0].elements['NroDocIdentidad'].value);
	}
	else{
		enviaPeticion("consulta_paciente.php?TipoDoc="+document.forms[0].elements['TipoDoc'].value+"&NroDocumento="+document.forms[0].elements['NroDocIdentidad'].value,retorno);
  }
}
/*********************************************/
function BuscaxDocTrans(){
	if (!document.forms[0].elements['NroDocIdentidad'].value){
		alert("Debe Ingresar Numero de DNI");
	}
	else{
		enviaPeticion("consulta_paciente_trans.php?TipoDoc="+document.forms[0].elements['TipoDoc'].value+"&NroDocumento="+document.forms[0].elements['NroDocIdentidad'].value,retorno);
  }
}
/********************************************/
function BuscaxAfi(){
	if (!document.forms[0].elements['NroBenef'].value){
		alert("Debe Ingresar Numero Beneficio"+document.forms[0].elements['NroBenef'].value);
	}
	else{
		enviaPeticion("consulta_paciente.php?NroBenef="+document.forms[0].elements['NroBenef'].value+"&Gpar="+document.forms[0].elements['Gpar'].value,xafi);
	}
}
/********************************************/
function BuscaxAfiTrans(){
	if (!document.forms[0].elements['NroBenef'].value){
		alert("Debe Ingresar Numero Afiliado");
	}
	else{
		enviaPeticion("consulta_paciente_trans.php?NroBenef="+document.forms[0].elements['NroBenef'].value,xafi);
	}
}
/**********************************************/
function enviaPeticion(url,callback) {
    objAjax = getXMLHTTP();
    objAjax.open("GET",url,true);
    objAjax.onreadystatechange = function() {
    	if (objAjax.readyState == 4) {
    		callback(objAjax.responseText);
		}
    }
    objAjax.send(null);
}
/****************************************************/
function getXMLHTTP(){
    var obj = null;
    try {
      	obj = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e) {
    	try {
        	obj = new ActiveXObject("Microsoft.XMLHTTP");
    	} catch(e2) {
        obj = null;
    	}
    }
    if (!obj && typeof XMLHttpRequest != "undefined") {
      	obj = new XMLHttpRequest();
    }
    return obj;
}
/********************************************************/
function retorno(respuesta) {
	var array_res = respuesta.split("/**/")
	document.forms[0].elements['NroBenef'].value=array_res[0];
	document.forms[0].elements['ApeNom'].value=array_res[1];
	document.forms[0].elements['CodUbicacionGeo'].value=array_res[2];
	document.forms[0].elements['Calle'].value=array_res[3];
	document.forms[0].elements['Puerta'].value=array_res[4];
	document.forms[0].elements['Piso'].value=array_res[5];
	document.forms[0].elements['CodPostal'].value=array_res[6];
	document.forms[0].elements['FecNacmiento'].value=array_res[7];
	document.forms[0].elements['Edad'].value=array_res[8];
	document.forms[0].elements['Sexo'].value=array_res[9];
	document.forms[0].elements['Obs_Paciente'].value=array_res[10];
	document.getElementById('ubica').innerHTML =array_res[11];
	document.getElementById('mensaje').innerHTML =array_res[12];		
	document.getElementById('mensaje1').innerHTML ='';
}
/***********************************************************/
function xafi(respuesta) {
	var array_res = respuesta.split("/**/")
	document.forms[0].elements['TipoDoc'].value=array_res[0];
	document.forms[0].elements['NroDocIdentidad'].value=array_res[1];	
	document.forms[0].elements['ApeNom'].value=array_res[2];
	document.forms[0].elements['CodUbicacionGeo'].value=array_res[3];	
	document.forms[0].elements['Calle'].value=array_res[4];
	document.forms[0].elements['Puerta'].value=array_res[5];
	document.forms[0].elements['Piso'].value=array_res[6];
	document.forms[0].elements['CodPostal'].value=array_res[7];
	document.forms[0].elements['FecNacmiento'].value=array_res[8];
	document.forms[0].elements['Edad'].value=array_res[9];
	document.forms[0].elements['Sexo'].value=array_res[10];
	document.forms[0].elements['Obs_Paciente'].value=array_res[11];
	document.getElementById('ubica').innerHTML =array_res[12];
	document.getElementById('mensaje1').innerHTML =array_res[13];	
	document.getElementById('mensaje').innerHTML ='';
}
/**************************************************************/
function CalcularEdad() {
  var vop1 = document.forms[0].FecNacmiento.value;
  enviaPeticion("../includes/calcular_edad.php?edad="+vop1,miEdad);
}
/*****************************************************************/
function sf(ID){
document.getElementById(ID).focus();
}