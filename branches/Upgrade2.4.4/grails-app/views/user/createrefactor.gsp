

<%@ page import="com.medfire.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript" src="${resource(dir:'js/script',file:'jquicombobox.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
				//------------profesional search----------------
            	
                $("#profesionalDescId").lookupfield({
                	source:"<% out << g.createLink(controller:"profesional",action:'listjson')%>",
					title:'Búsqueda de Profesionales',
					colnames:['Id','C.U.I.T','Matricula','Nombre','Institucion','Telefono','urlfoto','foto'],
					colModel:[
							{name:'id',index:'id', width:10, sorttype:"int", sortable:true,hidden:true,search:false},
					   		{name:'cuit',index:'cuit', width:92,sortable:false,searchoptions:{sopt:['eq']}},
					   		{name:'matricula',index:'matricula', width:100,search:false,searchoptions:{sopt:['eq']}},
					   		{name:'nombre',index:'nombre', width:150, sortable:true},
					   		{name:'institucion_nombre',index:'institucion_nombre', width:150, sortable:true},					   		
					   		{name:'telefono',index:'telefono', width:80, align:"right",search:false, sortable:false,searchoptions:{sopt:['eq']}},
					   		{name:'urlphoto',index:'urlphoto', hidden:true, width:80,search:false, align:"right", sortable:false},						   		
					   		{name:'foto',index:'foto', width:80,hidden:true, align:"center",search:false, sortable:false}						   		
						],
					hiddenid:'profesionalId',
					descid:'profesionalDescId',
					hiddenfield:'id',
					descfield:['nombre']	
                 });	

               	
    			$("#profesionalDescId").autocomplete({
    				source: "<% out << g.createLink(controller:"profesional",action:'listjsonautocomplete')%>",
    				minLength:2,
    				select: function(event,ui){
    					if(ui.item){
    						$("#profesionalId").val(ui.item.id);
    					}
    				}
    	
    			});

    			//-----------------institucion search------------
                $("#institucionDescId").lookupfield({
                	source:"<% out << g.createLink(controller:"institucion",action:'listjson')%>",
					title:'Búsqueda de Instituciones',
					colnames:['Id','Nombre'],
					colModel:[
							{name:'id',index:'id', width:10, sorttype:"int", sortable:true,hidden:false,search:false},
					   		{name:'nombre',index:'nombre', width:150, sortable:true}
						],
					hiddenid:'institucionId',
					descid:'institucionDescId',
					hiddenfield:'id',
					descfield:['nombre']	
                 });	

               	
    			$("#institucionDescId").autocomplete({
    				source: "<% out << g.createLink(controller:"institucion",action:'listjsonautocomplete')%>",
    				minLength:2,
    				select: function(event,ui){
    					if(ui.item){
    						$("#institucionId").val(ui.item.id);
    					}
    				}
    	
    			});
    			
    			
            });
        </script>
        <style type="text/css">
        </style>
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <h1><g:message code="default.create.label" args="[entityName]" /></h1>
        
        <div class="span-10 prepend-3 body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="ui-state-error ui-corner-all" style="padding: 0pt 0.7em;">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <br/>
            
            <g:form   action="saverefactor" >
                             <g:hasErrors bean="${userInstance}" field="username">
                             	<div class="ui-state-error ui-corner-all" style="padding: 0pt 0.7em;">
	                         </g:hasErrors>
	                         	<div class="span-3 spanlabel">	
                                   <label for="username"><g:message code="user.username.label" default="Username" /></label>
                                </div>
                                <div class="span-4">
                                   <g:textField class="ui-widget ui-corner-all ui-widget-content" name="username" value="${userInstance?.username}" />
                                </div>   
                             <g:hasErrors bean="${userInstance}" field="username">
                            		<g:renderErrors bean="${userInstance}" as="list" field="username"/>
                            	</div>
                             </g:hasErrors>	
                                   
                                   
                        	<div class="clear"></div>	
                             <g:hasErrors bean="${userInstance}" field="userRealName">
                            	<div class="ui-state-error ui-corner-all" style="padding: 0pt 0.7em;">
	                         </g:hasErrors>
	                         	<div class="span-3 spanlabel">	
                                    <label for="userRealName"><g:message code="user.userRealName.label" default="User Real Name" /></label>
								</div>
								<div class="span-4">                                    
                                    <g:textField class="ui-widget ui-corner-all ui-widget-content" name="userRealName" value="${userInstance?.userRealName}" />
                                </div>    
                             <g:hasErrors bean="${userInstance}" field="userRealName">
                            		<g:renderErrors bean="${userInstance}" as="list" field="userRealName"/>
                            	</div>
                             </g:hasErrors>	
                        			
                        	 <div class="clear"></div>	
                             <g:hasErrors bean="${userInstance}" field="passwd">
                            	<div class="ui-state-error ui-corner-all" style="padding: 0pt 0.7em;">
	                         </g:hasErrors>
	                         	<div class="span-3 spanlabel">	
                                    <label for="passwd"><g:message code="user.passwd.label" default="Passwd" /></label>
                                </div>    
                                <div class="span-4">
                                    <g:passwordField class="ui-widget ui-corner-all ui-widget-content" name="passwd" value="${userInstance?.passwd}" />
                                </div>    
                             <g:hasErrors bean="${userInstance}" field="passwd">
                             	
                            		<g:renderErrors bean="${userInstance}" as="list" field="passwd"/>
                            	</div>
                             </g:hasErrors>	
                        			
							 <div class="clear"></div>
                             <g:hasErrors bean="${userInstance}" field="profesionalAsignado">
                            	<div class="ui-state-error ui-corner-all" style="padding: 0pt 0.7em;">
	                         </g:hasErrors>
		                         <div class="span-3 spanlabel">	
	                                    <label for="profesionalAsignado"><g:message code="user.profesionalAsignado.label" default="Profesional Asignado" /></label>
								 </div>
								 <div class="span-4">                                    
                                    <g:textField name="profesionalDesc" id="profesionalDescId"  class="ui-widget ui-corner-all ui-widget-content" value="${userInstance?.profesionalAsignado?.nombre}" />
                                 </div>   
                                 <g:hiddenField id="profesionalId" name="profesionalAsignado.id" value="${userInstance?.profesionalAsignado?.id}" />
							 <g:hasErrors bean="${userInstance}" field="profesionalAsignado">
								<g:renderErrors bean="${userInstance}" as="list" field="profesionalAsignado"/>
								</div>
							 </g:hasErrors>	
							 <div class="clear"></div>
							 
                             <g:hasErrors bean="${userInstance}" field="institucion">
                            	<div class="ui-state-error ui-corner-all" style="padding: 0pt 0.7em;">
	                         </g:hasErrors>
		                         <div class="span-3 spanlabel">	
	                                    <label for="institucionDesc"><g:message code="user.institucion.label" default="Institucion" /></label>
								 </div>
								 <div class="span-4">                                    
                                    <g:textField name="institucionDesc" id="institucionDescId"  class="ui-widget ui-corner-all ui-widget-content" value="${userInstance?.institucion?.nombre}" />
                                 </div>   
                                 <g:hiddenField id="institucionId" name="institucion.id" value="${userInstance?.institucion?.id}" />
							 <g:hasErrors bean="${userInstance}" field="institucion">
								<g:renderErrors bean="${userInstance}" as="list" field="institucion"/>
								</div>
							 </g:hasErrors>	
							 
                        			
                        
                        	 <div class="clear"></div>
                             <g:hasErrors bean="${userInstance}" field="email">
                            	<div class="ui-state-error ui-corner-all" style="padding: 0pt 0.7em;">
	                         </g:hasErrors>
	                         	<div class="span-3 spanlabel">	
                                    <label for="email"><g:message code="user.email.label" default="Email" /></label>
                                </div>    
                                <div class="span-4">
                                    <g:textField class="ui-widget ui-corner-all ui-widget-content" name="email" value="${userInstance?.email}" />
                                </div>    
                            <g:hasErrors bean="${userInstance}" field="email">
                          		<g:renderErrors bean="${userInstance}" as="list" field="email"/>
                          		</div>
                            </g:hasErrors>	
                        			
                        		
                        			
						   <div class="clear"></div>	
                           <g:hasErrors bean="${userInstance}" field="esProfesional">
	                          	<div class="ui-state-error ui-corner-all" style="padding: 0pt 0.7em;">
    	                   </g:hasErrors>	
    	                   		<div class="span-3 spanlabel">
                                    <label for="esProfesional"><g:message code="user.esProfesional.label" default="Es Profesional" /></label>
                                </div>    
                                <div class="span-4">
                                    <g:checkBox name="esProfesional" value="${userInstance?.esProfesional}" />
                                </div>    
                           <g:hasErrors bean="${userInstance}" field="esProfesional">
                          		<g:renderErrors bean="${userInstance}" as="list" field="esProfesional"/>
	                          	</div>
                           </g:hasErrors>	
                        			
  							<div class="clear"></div>
  							<div class="span-3 spanlabel">	
                                   <label for="enabled"><g:message code="user.enabled.label" default="Habilitado" /></label>
                            </div>       
                            <div class="span-4">
                                    <g:checkBox name="enabled" value="${userInstance?.enabled}" />
                        	</div>	
                        	<div class="clear"></div>	
                        			<fieldset>
                        				<legend>Roles Asignados</legend>
                        				<g:each var="entry" in="${authorityList}">
											${entry.key.description?.encodeAsHTML()}
											<g:checkBox name="${entry.key.authority}" value="${entry.value}"/>
										</g:each>
                        			</fieldset>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
