<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">

    <link rel="stylesheet" href="${resource(dir:'js/extjs/ux/css',file:'Portal.css')}"/>
    <link rel="stylesheet" href="${resource(dir:'js/extjs/ux/css',file:'GroupTab.css')}"/>

    <script type="text/javascript" src="${resource(dir:"js/extjs/ux",file:"GroupTab.js")+'?id='+randomlink}"></script>
    <script type="text/javascript" src="${resource(dir:"js/extjs/ux",file:"GroupTabPanel.js")+'?id='+randomlink}"></script>
    <script type="text/javascript" src="${resource(dir:"js/extjs/ux",file:"Portal.js")+'?id='+randomlink}"></script>
    <script type="text/javascript" src="${resource(dir:"js/extjs/ux",file:"PortalColumn.js")+'?id='+randomlink}"></script>
    <script type="text/javascript" src="${resource(dir:"js/extjs/ux",file:"Portlet.js")+'?id='+randomlink}"></script>
    <script type="text/javascript" src="${resource(dir:"js/extjs/ux",file:"RowExpander.js")}"></script>
    <%--script type="text/javascript" src="${resource(dir:"js/panelcontroldocente",file:"panelcontroldocente.js")+'?id='+randomlink}"></script --%>
    <script type="text/javascript" src="${resource(dir:"js/panelcontroldocente",file:"panelcontroldocente.js")}"></script >

    <style type="text/css">
    .upload-icon {
        background: url('${resource(dir:'js/extjs/resources/images',file:'image_add.png')}') no-repeat 0 0 !important;
    }
    #fi-button-msg {
        border: 2px solid #ccc;
        padding: 5px 10px;
        background: #eee;
        margin: 5px;
        float: left;
    }
    </style>
    <script type="text/javascript">
        var docente = '${docenteInstance.apellido+', '+docenteInstance.nombre}';
        var docenteId = '${docenteInstance.id}';
        var logoUrl = '${resource(dir:'reports/images',file:'imagecomprobante.png')}';
        var storefechaexamen = '${createLink(uri:'/panelControlDocente/cargaexamenlist/')+docenteInstance.id}';
        var docentemateriaUrl = '${createLink(uri:'/panelControlDocente/cargaexamenlist/')+docenteInstance.id}';
        var aniolectivoUrl = '${createLink(uri:'/panelControlDocente/aniolectivonotas')}';
    </script>

    <title>Panel de control de Docente</title>
</head>
<body>
<div id="dummydiv"></div>
</body>
</html>