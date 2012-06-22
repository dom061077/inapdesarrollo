

<%@ page import="com.educacion.academico.Preinscripcion"
  @ page import="com.educacion.academico.Carrera"	
 %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'preinscripcion.label', default: 'Preinscripcion')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript" src="${g.resource(dir:"js/wizard",file:"jquery.form.js")}"></script>
        <script type="text/javascript" src="${g.resource(dir:"js/wizard",file:"jquery.validate.js")}"></script>        
        <script type="text/javascript" src="${g.resource(dir:"js/wizard",file:"jquery.form.wizard-min.js")}"></script>
                
    <script type="text/javascript">
			$(function(){
				$("#inscripcion").formwizard({

					formPluginEnabled: true,
				 	validationEnabled: true,
				 	focusFirstInput : true,
				 	formOptions :{
						success: function(data){$("#status").fadeTo(500,1,function(){ $(this).html("You are now registered!").fadeTo(5000, 0); })},
						beforeSubmit: function(data){$("#data").html("data sent to the server: " + $.param(data));},
						dataType: 'json',
						resetForm: true
				 	},
				 	validationOptions : {
				 		rules: {
							country: "required",
							email: {
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
  		});
    </script>    
        
 		
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
			<form id="demoForm" method="post" action="json.html" class="bbq">        
	        <div id="inscripcion">
	        	<div id="fieldWrapper">
					<fieldset class="step" id="first">
						<h1>First step - Name</h1><br />
						<label for="firstname">First name</label><br />
						<input  name="firstname" id="firstname" /><br />
						<label for="surname">Surname</label><br />
						<input  name="surname" id="surname" /><br />
					</fieldset>
					<fieldset id="finland" class="step">
						<h1>Step 2 - Personal information</h1><br />
						<label for="day_fi">Social Security Number</label><br />
						<input  name="day" id="day_fi" value="DD" />
						<input  name="month" id="month_fi" value="MM" />
						<input  name="year" id="year_fi" value="YYYY" /> - 
						<input  name="lastFour" id="lastFour_fi" value="XXXX" /><br />
						<label for="countryPrefix_fi">Phone number</label><br />
						<input  name="countryPrefix" id="countryPrefix_fi" value="+358" /> - 
						<input  name="areaCode" id="areaCode_fi" /> - 
						<input  name="phoneNumber" id="phoneNumber_fi" /><br />
						<label for="myemail">*Email</label><br />
						<input  name="myemail" id="myemail" /><br />	 						
					</fieldset>
					<fieldset id="confirmation" class="step">
						<h1>Last step - Username</h1><br />
						<label for="username">User name</label><br />
						<input name="username" id="username" /><br />
						<label for="password">Password</label><br />
						<input  name="password" id="password" type="password" /><br />
						<label for="retypePassword">Retype password</label><br />
						<input  name="retypePassword" id="retypePassword" type="password" /><br />
					</fieldset>
					</div>
					<div id="demoNavigation"> 							
						<input class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="back" value="Back" type="reset" />
						<input class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="next" value="Next" type="submit" />
					</div>
        	
        	</div>	
        	</form>
    </body>
    
</html>
