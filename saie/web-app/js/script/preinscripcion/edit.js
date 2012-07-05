function initsubmit(){
    var gridDataMaterias = $("#materiasId").getRowData();
    var postDataMaterias = JSON.stringify(gridDataMaterias);
    $("#materiasSerializedId").val(postDataMaterias);
    $('#fechaNacimientoId_yearId').val($('#fechaNacimientoId').datepicker('getDate').getFullYear());
    $('#fechaNacimientoId_monthId').val($('#fechaNacimientoId').datepicker('getDate').getMonth()+1);
    $('#fechaNacimientoId_dayId').val($('#fechaNacimientoId').datepicker('getDate').getDate());
    if($('#fechaNacimientoId_monthId').val().length==1)
        $('#fechaNacimientoId_monthId').val('0'+$('#fechaNacimientoId_monthId').val());
    if($('#fechaNacimientoId_dayId').val().length==1)
        $('#fechaNacimientoId_dayId').val('0'+$('#fechaNacimientoId_dayId').val());

}
function bindmaterias(){
    var griddata = [];

    var data = jQuery.parseJSON($("#materiasSerializedId").val());
    if(data==null)
        data=[];
    for (var i = 0; i < data.length; i++) {
        griddata[i] = {};
        griddata[i]['id'] = data[i].id;
        griddata[i]['idid'] = data[i].idid;
        griddata[i]['denominacion'] = data[i].denominacion;
        griddata[i]['seleccion'] = data[i].seleccion;
    }

    for (var i = 0; i <= griddata.length; i++) {
        jQuery("#materiasId").jqGrid('addRowData', i + 1, griddata[i]);
    }
}


$(document).ready(function(){

    $('#materiasId').jqGrid({
        datatype:'local'
        ,width:500
        ,colNames:['Id','IdId','Denominación','Select']
        ,colModel:[
            {name:'id',index:'id',width:50,editable:false,hidden:true}
            ,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:false,editoptions:{readOnly:true,size:10},editrules:{required:false}}
            ,{name:'idmateria',index:'idmateria',width:50,hidden:true,sortable:false,editable:false,editoptions:{readOnly:true,size:10},editrules:{required:false}}
            ,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
            ,{ name: 'seleccion', index: 'seleccion',width:10,  formatter: "checkbox", formatoptions: { disabled: false }, editable: true, edittype: "checkbox" }


        ]
        ,sortname:'denominacion'
        //,pager: '#pagermateriasId'
        ,sortorder:'asc'
        ,caption: 'Materias a Inscribir'
    });
    bindmaterias();


});