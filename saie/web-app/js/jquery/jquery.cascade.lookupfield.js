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
            cascade: {
                elementCascadeId:'',
                paramName:''
            }
        },
        _create: function() {
            var input,
                o = this.options,
                idobj = this.element[0].id;
                idobjlookup=this.element[0].id+'_lookupgrid',
                idgrid=idobjlookup+'_grid';
                idpager=idobjlookup+'_pager';
                idwrapper=idobjlookup+'_wrapper';
                self = this,
                //select = this.element.hide(),
                select = this.element,
                wrapper = this.wrapper = $( "<span>" )
                    .addClass( "ui-combobox" )
                    .insertAfter( select );
            input = $( '<input class="ui-widget ui-corner-all ui-widget-content" id="'+idobjlookup+'"/>' )
                .appendTo( wrapper );
            input.val($('#'+idobj).attr('descValue'));
            $('#'+idobjlookup).keyup(function(e){
                var grid = $('#'+idgrid);
                if(e.keyCode==27){
                    $('#'+idobjlookup+'_wrapper').hide();
                    flagcascadelookupfield = false;
                }else{
                    if(e.keyCode==40){
                        if(!flagcascadelookupfield)
                            $('#'+idobjlookup+'_wrapper').show();
                        $('#'+idgrid).focus();
                    }
                    if(e.keyCode==8){
                        if($('#'+idobjlookup).val()==''){
                            $('#'+idobj).val('');
                            flagcascadelookupfield = false;
                            $('#'+idwrapper).hide();
                            return
                        }
                    }
                    if(e.keyCode==46){
                        if($('#'+idobjlookup).val()==''){
                            $('#'+idobj).val('');
                            flagcascadelookupfield = false;
                            $('#'+idwrapper).hide();
                            return
                        }
                    }
                    if($('#'+idobjlookup).val()!=''){
                        if(!flagcascadelookupfield){
                            $('#'+idobjlookup+'_wrapper').show();
                            flagcascadelookupfield=true;
                        }
                        var colNames = $('#'+idgrid).jqGrid('getGridParam','colNames');
                        var colModel = $('#'+idgrid).jqGrid('getGridParam','colModel');
                        var filter = { groupOp: "AND", rules: []};
                        var filterop = 'bw';
                        if(colModel[2].searchoptions )
                            filterop = colModel[2].searchoptions.sopt[0];

                        filter.rules.push({field:colModel[2].name,op:filterop,data:$('#'+idobjlookup).val()});
                        grid[0].p.search = true;
                        if(o.paramName!='')
                            $.extend(grid[0].p.postData,{paramName : o.paramName,paramData:$('#'+o.elementCascadeId).val(),altfilters:JSON.stringify(filter)});
                        else
                            $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                    }else
                        grid[0].p.search = false;
                    grid.trigger("reloadGrid",[{page:1}]);
                }
            });
            $('<div style="display:none;float:left;position:absolute;z-index:4001" id="'+idwrapper+'" ><table id="'+idgrid+'"></table> <div id="'+idpager+'"></div></div>').insertAfter(wrapper);

           $('#'+idgrid).jqGrid({
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
                    var colModel = $('#'+idgrid).jqGrid('getGridParam','colModel');
                    var obj=$('#'+idgrid).getRowData(id);
                    $('#'+idobj).val(obj.id);
                    $('#'+idobjlookup).val(obj[colModel[2].name]);
                    $('#'+idobjlookup+'_wrapper').hide();
                    flagcascadelookupfield = false;
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
                    var grid = $('#'+idgrid);
                    input.focus();
                    if(o.paramName!='')
                        $.extend(grid[0].p.postData,{paramName : o.paramName,paramData:$('#'+o.elementCascadeId).val()});

                    grid.trigger("reloadGrid",[{page:1}]);
                    if(!flagcascadelookupfield){
                        $('#'+idwrapper).show();
                        //carreraId_lookupgrid_wrapper
                        flagcascadelookupfield=true;
                    }else{
                        $('#'+idwrapper).hide();
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