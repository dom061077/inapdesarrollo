$(document).ready(function(){
    var flagcascadelookupfield=false;
    $.widget('ui.cascadelookupfield',{
        input:null,
        localvar:null,
        options:{
            grid:{
                url:'',
                colNames:[],
                colModel:[]
            },
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
                idobj = $(this).attr('id');
                idobjlookup=$(this).attr('id')+'_lookupgrid',
                idgrid='#'+idobjlookup+'_grid';
                iddialog='#'+idobjlookup+'_dialog';
                idpager='#'+idobjlookup+'_pager';
                self = this,
                select = this.element.hide(),
                wrapper = this.wrapper = $( "<span>" )
                    .addClass( "ui-combobox" )
                    .insertAfter( select );
            input = $( '<input class="ui-widget ui-corner-all ui-widget-content" id="'+idobjlookup+'"/>' )
                .appendTo( wrapper );
            $('#'+idobjlookup).keyup(function(e){
                var grid = $(idgrid);
                if(e.keyCode==27){
                    $('#'+idobjlookup+'_wrapper').hide();
                    flagcascadelookupfield = false;
                }else{
                    if($('#'+idobjlookup).val()!=''){
                        var filter = { groupOp: "AND", rules: []};
                        filter.rules.push({field:"denominacion",op:"bw",data:$('#'+idobjlookup).val()});
                        grid[0].p.search = true;
                        $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                    }else
                        grid[0].p.search = false;
                    grid.trigger("reloadGrid",[{page:1}]);
                }
            });
            $('<div id="'+idobjlookup+'_wrapper" style="display:none;position:fixed;z-index:4001"><table id="'+idobjlookup+'_grid"></table> <div id="'+idobjlookup+'_pager"></div></div>').insertAfter(wrapper);

           $(idgrid).jqGrid({
                //caption:'colocar caption',
                width:300,
                url:o.grid.url,
                //postData:{profesionalId:$("#profesionalId").val()},
                mtype:"POST",
                rownumbers:true,
                rowList:[10,20,30],
                pager:idpager,
                datatype:"json",
                colNames:o.grid.colNames,
                colModel:o.grid.colModel,
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
                    input.focus();
                    $(idgrid).trigger("reloadGrid",[{page:1}]);
                    if(!flagcascadelookupfield){
                        $('#'+idobjlookup+'_wrapper').show();
                        flagcascadelookupfield=true;
                    }else{
                        $('#'+idobjlookup+'_wrapper').hide();
                        flagcascadelookupfield=false;
                    }
                });
        },

        destroy: function() {
            this.wrapper.remove();
            this.element.show();
            $.Widget.prototype.destroy.call( this );
        }
    })
});