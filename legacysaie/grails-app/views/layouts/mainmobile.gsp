<html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title><g:layoutTitle default="Grails"/></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'jquery.mobile-1.3.2.css')}"/>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery-1.6.2.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jqm',file:'jquery.mobile-1.3.2.js')}"></script>
        <g:layoutHead/>
        <r:layoutResources />
    </head>
<body>
<div data-role="page" id="home" data-theme="f">
    <div data-role="header" data-theme="d">
        <h1>${(titlepage?titlepage:"Bienvenido")}</h1>
        <a href="${createLink(uri:"/logout")}"
           data-transition="flip"
           data-role="button"
           data-icon="gear"
           data-iconpos="notext"
           class="ui-btn-right"
           data-direction="reverse" data-ajax="false"></a>
    </div>

    <g:layoutBody/>



    <div data-role="footer" data-id="foo1" data-position="fixed">
        <div data-role="navbar" data-theme="d">
            <ul>
                <li><a id="menuinfoId" data-theme="d" href="${createLink(uri:"/panelControlAdmin/infousum")}">Info</a></li>
                <li><a href="b.html" data-theme="d">Alumnos</a></li>
                <li><a href="c.html" data-theme="d">Docentes</a></li>
            </ul>
        </div><!-- /navbar -->
    </div><!-- /footer -->
</div>

</body>

</html>