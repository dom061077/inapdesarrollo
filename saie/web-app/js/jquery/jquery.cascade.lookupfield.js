$(document).ready(function(){
    $.widget('ui.cascadelookupfield',{
        input:null,
        localvar:null,
        options:{
            reload: {
                url:null,
                params:{}
            },
            emptyMsg:'',
            onSelect:function(event,ui){
            }
        },
        _create: function() {
            var input,
                o = this.options,
                self = this,
                select = this.element.hide(),
                wrapper = this.wrapper = $( "<span>" )
                    .addClass( "ui-combobox" )
                    .insertAfter( select );
            input = $( '<input id="'+$(this).attr('id')+'_oculto">' )
                .appendTo( wrapper );

            var table = $('<table id="'+$(this).attr('id')+'"></table>');
            var dialog = $('<div></div>').append(table);

            var grid=table.jqGrid({
                //caption:'colocar caption',
                width:380,
                url:'',
                //postData:{profesionalId:$("#profesionalId").val()},
                mtype:"POST",
                rownumbers:false,
                //pager:'#'+pagerSearchId,
                datatype:"json",
                colnames:['Id','D.N.I','Apellido','Nombre'],
                 colModel:[
                 {name:'id',index:'id', width:10, sorttype:"int", sortable:false,hidden:true,search:false},
                 {name:'dni',index:'dni', width:100, sorttype:"int", sortable:false,search:true, searchoptions: {sopt:['eq']} },
                 {name:'apellido',index:'apellido', width:100,sortable:false,search:true},
                 {name:'nombre',index:'nombre', width:100, sortable:false,search:true}
                 ],
                //colnames:settings.colnames,
                //colModel:settings.colModel,
                //hiddengrid:true,

                //colNames:settings.colNames,
                //colModel:settings.colModel,
                //postData: settings.postData,
                ajaxGridOptions: {cache: false},
                ondblClickRow: function(id){
                    var obj=$('#'+tableSearchId).getRowData(id);
                    var descriptions = "";
                    $.each(settings.descfield,function(index,value){
                        descriptions=descriptions+"-"+obj[value];
                    });
                    descriptions = descriptions.substring(1,descriptions.length);
                    $('#'+settings.hiddenid).val(obj[settings.hiddenfield]);
                    $('#'+settings.descid).val(descriptions);
                    $('#'+searchDialogId).dialog("close");
                    settings.onSelected();

                }
            });



            $( "<a>" )
                .attr( "tabIndex", -1 )
                .attr( "title", "Mostrar todas las opciones" )
                .appendTo( wrapper )
                .button({
                    icons: {
                        primary: "ui-icon-triangle-1-s"
                    },
                    text: false
                })
                .removeClass( "ui-corner-all" )
                .addClass( "ui-corner-right ui-combobox-toggle" )
                .click(function() {
                    var top,left,height;
                    var pos = $(wrapper).offset();
                    left = pos.left;
                    top = pos.top;
                    height = input.attr("height");
                    alert('height:'+height);

                    input.focus();
                    dialog.dialog({show: "blind",  hide: "blind",position:[left,top+height]});
                    dialog.dialog('widget').find(".ui-dialog-titlebar").hide();
                    //$('#example').dialog('widget').find(".ui-dialog-titlebar").hide();

                });
        },

        destroy: function() {
            this.wrapper.remove();
            this.element.show();
            $.Widget.prototype.destroy.call( this );
        }
    })
});