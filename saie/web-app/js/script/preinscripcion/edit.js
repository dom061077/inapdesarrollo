function initsubmit(){
    var gridDataMaterias = $("#materiasId").getRowData();
    var postDataMaterias = JSON.stringify(gridDataMaterias);
    $("#materiasSerializedId").val(postDataMaterias);

    var gridDataRequisitos = $("#requisitosId").getRowData();
    var postDataRequisitos = JSON.stringify(gridDataRequisitos);
    $("#requisitosSerializedId").val(postDataRequisitos);

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
        griddata[i]['codigomateria'] = data[i].codigomateria;
        griddata[i]['nivel'] = data[i].nivel;
        griddata[i]['denominacion'] = data[i].denominacion;
        griddata[i]['idmateria'] = data[i].idmateria;
        griddata[i]['tipo'] = data[i].tipo;
        griddata[i]['seleccion'] = data[i].seleccion;
    }

    for (var i = 0; i <= griddata.length; i++) {
        jQuery("#materiasId").jqGrid('addRowData', i + 1, griddata[i]);
    }
}

function bindrequisitos(){
    var griddata = [];

    var data = jQuery.parseJSON($("#requisitosSerializedId").val());
    if(data==null)
        data=[];
    for (var i = 0; i < data.length; i++) {
        griddata[i] = {};
        griddata[i]['id'] = data[i].id;
        griddata[i]['idid'] = data[i].idid;
        griddata[i]['descripcion'] = data[i].descripcion;
        griddata[i]['seleccion'] = data[i].seleccion;
    }

    for (var i = 0; i <= griddata.length; i++) {
        jQuery("#requisitosId").jqGrid('addRowData', i + 1, griddata[i]);
    }

}


$(document).ready(function(){
    var lastSel;
    var inlineEditOptions = {
        keys: true,
        aftersavefunc: function (rowid) {
            var obj=$('#materiasId').jqGrid('getGridParam','selrow');
            alert(obj);
            //var grid = $(this),
            //newName = grid.jqGrid("getCell", rowid, 'name');
            //$grid.jqGrid("setCell", rowid, 'name', newName.toUpperCase());
        }
    };

    $('#materiasId').jqGrid({
        datatype:'local'
        ,editurl:'editmateriajson'
        ,width:500
        ,colNames:['Id','IdId','Nivel','Código de Materia','Id materia','Denominación','Tipo','Tipo Value','Select']
        ,colModel:[
            {name:'id',index:'id',width:50,editable:false,hidden:true}
            ,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:false,editoptions:{readOnly:true,size:10},editrules:{required:false}}
            ,{name:'nivel',index:'nivel',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
            ,{name:'codigomateria',index:'codigomateria',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
            ,{name:'idmateria',index:'idmateria',width:50,hidden:true,sortable:false,editable:false,editoptions:{readOnly:true,size:10},editrules:{required:false}}
            ,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
            ,{name:'tipo',index:'tipo',sortable:false,width:80,editable:true,edittype:'select',editoptions:{value:tiposinscripcion,readOnly:true,size:40},editrules:{required:true}}
            ,{name:'tipovalue',index:'tipovalue',hidden:true,editable:true}
            ,{ name: 'seleccion', index: 'seleccion',width:60,  formatter: "checkbox", formatoptions: { disabled: false }, editable: true, edittype: "checkbox" }
        ]
        ,onSelectRow: function(rowid){

            if (rowid !== lastSel) {
                if (lastSel) {
                    $('#materiasId').jqGrid('saveRow', lastSel, inlineEditOptions);
                }
                lastSel = rowid;
            }
            $('#materiasId').jqGrid('editRow', rowid, inlineEditOptions);
            return true;

        },
        serializeRowData: function (postData) {
            //postData.name = postData.name.toUpperCase();
            postData.tipovalue = postData.tipo;
            return postData;
        }
        ,sortname:'denominacion'
        //,pager: '#pagermateriasId'
        ,sortorder:'asc'
        ,caption: 'Materias a Inscribir'
    });

    $('#materiasId').jqGrid('navGrid','#pagermateriasId',{add:false,edit:true,del:false,search:false,refresh:false}
            ,{
                beforeSubmit: function(postData,formId){
                    alert(postData);
                    return[true,'']
                }
            }//edit options
            ,{
                beforeSubmit: function(postData,formId){
                    alert(postData);
                    return[true,'']
                }
            }//add options
            ,{}//del options
            ,{}//search options
        );

    bindmaterias();

    $('#requisitosId').jqGrid({
        datatype:'local'
        ,width:500
        ,colNames:['Id','IdId','Descripción','Cubierto']
        ,colModel:[
            {name:'id',index:'id',hidden:true}
            ,{name:'idid',index:'idid',hidden:true}
            ,{name:'descripcion',index:'descripcion',sotable:false,search:false,width:500}
            ,{ name: 'seleccion', index: 'seleccion',width:60,  formatter: "checkbox", formatoptions: { disabled: false }, editable: true, edittype: "checkbox" }
        ]
    });
    bindrequisitos();
    $('#tabs').tabs();

});