/*var Ajax;
if (Ajax && (Ajax != null)) {
	Ajax.Responders.register({
	  onCreate: function() {
        if($('spinner') && Ajax.activeRequestCount>0)
          Effect.Appear('spinner',{duration:0.5,queue:'end'});
	  },
	  onComplete: function() {
        if($('spinner') && Ajax.activeRequestCount==0)
          Effect.Fade('spinner',{duration:0.5,queue:'end'});
	  }
	});
}*/

$(document).ready(function(){
        	$.ajaxPrefilter(function( options, _, jqXHR ) {
        	        jqXHR.success(function(msg) {
            	        if(msg.denied)
            	        	$('<div title="Mensaje"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 50px 0;"></span>Tiene el acceso denegado a alguna funcionalidad</div>').dialog({
	            	        		modal: true,
	            	    			buttons: {
	            	    				Ok: function() {
	            	    					$( this ).dialog( "close" );
	            	    				}
	            	    			}
                	        	});
        	        	if(msg.loginredirect)
            	        	$('<div title="Mensaje"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 50px 0;"></span>Sesión caducada</div>').dialog({
            	        		modal: true,
            	    			buttons: {
            	    				Ok: function() {
                	    				$( this ).dialog( "close" );
                	    				window.location=urlsesion;
            	    				}
            	    			}
            	        	});
        	            
        	        });
					jqXHR.error(function ( jqXHR, textStatus, errorThrown ) {
                    	if (jqXHR.status==401){
            	        	$('<div title="Mensaje"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 50px 0;"></span>Sesión caducada</div>').dialog({
            	        		modal: true,
            	    			buttons: {
            	    				Ok: function() {
                	    				$( this ).dialog( "close" );
                	    				window.location=urlsesion;
            	    				}
            	    			}
            	        	});
                    		
                    	}
                	});         	        
        	    
        	});
        	
});
