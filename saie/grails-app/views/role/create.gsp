<head>
	<link rel="stylesheet" href="${resource(dir:'css/jstree/themes/default',file:'style.css')}" />
	<script type="text/javascript" src="${resource(dir:'js/jstree',file:'jquery.jstree.js')}"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />

	<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}"/>
	<title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="body">



	<div id="requests" class="jstree jstree-0 jstree-default jstree-focused" style="height: 365px;">
			<ul>
				<g:each var="requestGroup" in="${requestmaps}">
					<li id="${requestGroup.id}" class="jstree-open">
						<a href="#">${requestGroup.descripcion}</a>
						<ul>
							<g:each var="reqs" in="${requestGroup.requests}">
								<li id="${"req"+reqs.id}">
									<ins class="jstree-icon"></ins>
									<a href="#">${reqs.descripcion}</a>
								</li>
							</g:each>
						</ul>
					</li>
				</g:each>
			
			
<!--				<li id="phtml_1">-->
<!--					<a href="#">Root node 1</a>-->
<!--					<ul>-->
<!--						<li id="phtml_2" class="jstree-checked">-->
<!--							<a href="#">Child node 1</a>-->
<!--						</li>-->
<!--			-->
<!--						<li id="phtml_3">-->
<!--							<ins class="jstree-icon">&nbsp;</ins>-->
<!--							<a href="#">A Child node 2</a>-->
<!--						</li>-->
<!--					</ul>-->
<!--				</li>-->
<!--				<li id="phtml_4">-->
<!--					<a href="#">Root node 2</a>-->
<!--				</li>-->
			
			</ul>
	</div>
	<button id="test">Chequeados</button>
</div>
<script>
$(document).ready(function() {
	$('#authority').focus();

	$("#requests").jstree({ 
		"plugins" : [ "themes", "html_data", "checkbox", "sort", "ui" ]
	});

	$('#test').click('click',function(){
			$('#requests').jstree("get_checked",null,true).each 
            (function () { 
                alert(this.id); 
            }); 
	});


});
</script>

</body>
