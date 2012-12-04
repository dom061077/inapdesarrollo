$(document).ready(function(){
    $(document).click(function(e){
        var $clicked = $(e.target);
        if(!($clicked.parents().is('.jlookupfieldcascade')))
            $('.jlookupfieldcascade').hide();
    });
    $.fn.extend({

        combolookupfield: function(settings) {

            var defaults = {
                grid:{
                    url:'',
                    colNames:[],
                    colModel:[]
                },
                inputDesc:'',
                cascade: {
                    elementCascadeId:[],
                    paramName:[]
                },
                onSelected:function(){
                    //e.stopPropagation();
                }
            };
            var o = $.extend(defaults, settings),
            flagcascadelookupfield=false;
            var input,
                idobj ,
                idobjlookup,
                idgrid,
                idpager,
                idwrapper,
                select ;
             var wrapper;

            this.clear = function (){
                $('#'+idobj).val('');
                $('#'+idobjlookup).val('');
                $('#'+idobjlookup+'_wrapper').hide();
                flagcascadelookupfield =false;
            }

            return this.each(function() {

                idobj =$(this).attr('id');
                idobjlookup=$(this).attr('id')+'_lookupgrid',
                    idgrid=idobjlookup+'_grid';
                idpager=idobjlookup+'_pager';
                idwrapper=idobjlookup+'_wrapper';
                select = $(this).hide();

                /*var input,
                    o = this.options,
                    idobj = this.element[0].id;
                idobjlookup=this.element[0].id+'_lookupgrid',
                    idgrid=idobjlookup+'_grid';
                idpager=idobjlookup+'_pager';
                idwrapper=idobjlookup+'_wrapper';
                self = this,
                select = this.element.hide();*/

                wrapper = $( '<span id="'+idobj+'_wrapper">' )
                    .addClass( "ui-combobox" )
                    .insertAfter( select );
                input = $( '<input type="text"  style="margin: 0 0;" class="ui-widget ui-corner-all ui-widget-content" name="'+o.inputNameDesc+'" id="'+idobjlookup+'"/>' )
                    .appendTo( wrapper );
                input.val($('#'+idobj).attr('descValue'));
                $('#'+idobjlookup).keyup(function(e){
                    var colNames;
                    var colModel;
                    var filter;
                    o.onSelected();
                    var grid = $('#'+idgrid);
                    if(e.keyCode==27){
                        $('#'+idobjlookup+'_wrapper').hide();
                        flagcascadelookupfield = false;
                    }else{
                        if(e.keyCode==40){
                            if(!flagcascadelookupfield){
                                $('#'+idobjlookup+'_wrapper').show();
                                flagcascadelookupfield = true;
                            }
                            //grid[0].p.search = false;
                            grid.trigger("reloadGrid",[{page:1}]);
                        }
                        /*if(e.keyCode==8){
                            if($('#'+idobjlookup).val()==''){
                                $('#'+idobj).val('');
                                flagcascadelookupfield = false;
                                $('#'+idwrapper).hide();
                                grid[0].p.search = false;
                                grid.trigger("reloadGrid",[{page:1}]);
                                return
                            }
                        } */
                        if(e.keyCode==46){
                            if($('#'+idobjlookup).val()==''){
                                $('#'+idobj).val('');
                                flagcascadelookupfield = false;
                                $('#'+idwrapper).hide();
                                grid[0].p.search = false;
                                grid.trigger("reloadGrid",[{page:1}]);
                                return
                            }
                        }
                        if($('#'+idobjlookup).val()!=''){
                            if(!flagcascadelookupfield){
                                $('#'+idobjlookup+'_wrapper').show();
                                flagcascadelookupfield=true;
                            }
                            colNames = $('#'+idgrid).jqGrid('getGridParam','colNames');
                            colModel = $('#'+idgrid).jqGrid('getGridParam','colModel');
                            filter = { groupOp: "AND", rules: []},filterop='bw';
                            if(colModel[2].searchoptions )
                                filterop = colModel[2].searchoptions.sopt[0];

                            filter.rules.push({field:colModel[2].name,op:filterop,data:$('#'+idobjlookup).val()});
                            grid[0].p.search = true;
                            if(o.cascade.paramName.length>0)
                                $.each(o.cascade.paramName,function(i,l){
                                    var elementId = '#'+o.cascade.elementCascadeId[i];
                                    //$.extend(grid[0].p.postData,{paramName : l,paramData:$(elementId).val(),altfilters:JSON.stringify(filter)});
                                    filter.rules.push({field:l,op:'eq',data:$(elementId).val()});
                                });

                            //else
                            $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                        }else{
                            $('#'+idobj).val('');
                            filter = { groupOp: "AND", rules: []},filterop='bw';
                            if(o.cascade.paramName.length>0)
                                $.each(o.cascade.paramName,function(i,l){
                                    var elementId = '#'+o.cascade.elementCascadeId[i];
                                    //$.extend(grid[0].p.postData,{paramName : l,paramData:$(elementId).val()});
                                    filter.rules.push({field:l,op:'eq',data:$(elementId).val()});
                                });
                            $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                            //grid[0].p.search = false;
                        }
                        grid.trigger("reloadGrid",[{page:1}]);
                    }
                });
                $('<div style="display:none;float:left;position:absolute;z-index:4001" class="jlookupfieldcascade" id="'+idwrapper+'" >'
                    +'<table id="'+idgrid+'"></table> <div id="'+idpager+'"></div></div>').insertAfter(wrapper);
                /*$('#'+idobj+'_cerrar').click(function(){
                    $('#'+idobjlookup+'_wrapper').hide();
                    flagcascadelookupfield = false;
                });*/
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
                        o.onSelected();
                    }
                });


                $( '<a id="'+idobj+'_triangle">' )
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
                    .click(function(e) {
                        $('.jlookupfieldcascade').hide();
                        var grid = $('#'+idgrid);
                        var filter = { groupOp: "AND", rules: []},filterop='bw';
                        input.focus();
                        if($('#'+idobjlookup).val()!=''){
                            var colNames = $('#'+idgrid).jqGrid('getGridParam','colNames');
                            var colModel = $('#'+idgrid).jqGrid('getGridParam','colModel');
                            var filter = { groupOp: "AND", rules: []},filterop='bw';
                            if(colModel[2].searchoptions )
                                filterop = colModel[2].searchoptions.sopt[0];
                            filter.rules.push({field:colModel[2].name,op:filterop,data:$('#'+idobjlookup).val()});
                        }
                        grid[0].p.search = true;
                        if(o.cascade.paramName.length>0)
                            $.each(o.cascade.paramName,function(i,l){
                                var elementId = '#'+o.cascade.elementCascadeId[i];
                                filter.rules.push({field:l,op:'eq',data:$(elementId).val()});
                            });
                        $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                         grid.trigger("reloadGrid",[{page:1}]);
                         /*if(!flagcascadelookupfield){
                         $('#'+idwrapper).show();
                             flagcascadelookupfield=true;
                         }else{
                             $('#'+idwrapper).hide();
                             flagcascadelookupfield=false;
                         }*/
                         $('#'+idwrapper).show();                            
                         e.stopPropagation();

                    });


            });  //----------cierre de function each--------
        }
    });
    $('.jlookupfieldcascade').click(function(e){
        e.stopPropagation();
    });
});