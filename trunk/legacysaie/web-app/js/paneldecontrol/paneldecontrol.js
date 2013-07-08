Ext.onReady(function(){

    function getRowsDataFinal(){
        var storeInscFinal = Ext.getCmp('gridcorrelfinId').getStore();
       inscFinalArr=[];
       storeInscFinal.data.each(function(rec){
           inscFinalArr.push(rec.data);
       });
       return Ext.encode(inscFinalArr);
    }

    function getRowsDataCursar(){
        var storeInscCursar = Ext.getCmp('gridcorrelcurId').getStore();
        inscCurArr = [];
        storeInscCursar.data.each(function(rec){
            inscCurArr.push(rec.data);
        });
        return Ext.encode(inscCurArr);
    }



    var nestedRowGrid = new Ext.grid.RowExpander({
        tpl: new Ext.XTemplate('<div class="detailData">','','</div>'),
        listeners:
        {
            expand:function(ex,record,body,rowIndex){
                processRowExpander(record,body,rowIndex);
            },
            collapse : function(ex,record,body,rowIndex){

            }
        }
    });



    var storelistadoinscdet = new Ext.data.JsonStore({
        root:'rows',
        url:inscDetUrl,
        fields:[{name:'id'},{name:'denominacion'},{name:'nivel'},{name:'estado'},{name:'notafinal',type:'float'}],
        autoLoad:false
    });

    function processRowExpander(record, body, rowIndex){
        if(Ext.DomQuery.select("div.x-panel-bwrap",body).length==0){
            var innerRowDiv=Ext.DomQuery.select("div.detailData",body)[0];
            var nestedGrid = new Ext.grid.GridPanel({
                id:'gridlistadoInscDetalleId',
                stripeRows:true,
                store:storelistadoinscdet,
                columns: [
                    {header: "id",dataIndex:'id',hidden:true},
                    {header: "Materia",width:200,sortable:false,dataIndex:'denominacion'},
                    {header: "Nivel",width:100,sortable:false,dataIndex:"nivel"},
                    {header: "Estado",width:100,sortable:false,dataIndex:"estado"},
                    {header: "Nota Final", width:80,dataIndex:"notafinal",align:'right',renderer: Ext.util.Format.numberRenderer('00,00/i')}
                ],
                stripeRows: true,
                height:250,
                width:500,
                loadMask:true,

                title:'Detalle de Mis Inscripciones',
                iconCls: 'icon-grid',
                listeners:{
                },
                renderTo: innerRowDiv,
                listeners: {
                    cellclick: function(grid,rowIndex, columnIndex,e){
                        e.stopEvent();
                    },
                    headerclick:function(grid,columnIndex,e){
                        e.stopEvent();
                    }
                }
            });
            storelistadoinscdet.load({
                params:{
                    inscripcionId:record.data.id
                }
            });

        }
    }

    Ext.QuickTips.init();
    var storelistadoinscripciones = new Ext.data.JsonStore({
        root:'rows',
        url:inscUrl,
        baseParams:{
          alumnoId:alumnoId
        },
        fields:[{name:'id'},{name:'carrera'},{name:'aniolectivo'},{name:'fecha',type:'date'}],
        autoLoad:true
    });
    var viewport = new Ext.Viewport({
        layout:'fit',
        items:[
            {
                xtype: 'grouptabpanel',
                tabWidth: 200,
                activeGroup: 0,
                items: [

                        {
                            expanded:true,
                            items:[
                                {
                                    title:username,
                                    iconCls: 'x-icon-templates',
                                    tabTip: 'Templates tabtip',
                                    style: 'padding: 10px;'//,


                                },{
                                    title:'Modificación',
                                    iconCls: 'x-icon-templates',
                                    tabTip: 'Templates tabtip',
                                    style: 'padding: 10px;'//,

                                }
                            ]
                        },
                        {
                            mainItem: 1,
                            items: [
                                {
                                    title: 'Inscribirme en Finales',
                                    layout: 'fit',
                                    iconCls: 'x-icon-tickets',
                                    tabTip: 'Registrar Inscripción en examen final',
                                    style: 'padding: 10px;',

                                    items: [
                                        {
                                            xtype:'panel',
                                            items:[
                                                {
                                                    xtype:'form'
                                                    ,style: 'margin:0 auto;margin-top:100px;'
                                                    ,id:'forminscfinalId'
                                                    ,url:submitFinUrl
                                                    ,frame:true
                                                    ,width:500
                                                    ,title:'Inscripción de Finales'
                                                    ,listeners:{
                                                        afterrender: function(component){
                                                            /*var rowselected = Ext.getCmp('combocarreraId').getStore().getAt(0);
                                                            Ext.getCmp('combocarreraId').setValue(rowselected.get('denominacion'));
                                                            Ext.getCmp('comboaniolectivoId').getStore().load({
                                                                params:{
                                                                    alumnoId:alumnoId,
                                                                    carreraId:rowselected.get('id')
                                                                }
                                                            });
                                                            rowselected = Ext.getCmp('comboaniolectivoId').getStore().getAt(0);
                                                            Ext.getCmp('comboaniolectivoId').setValue(rowselected.get('descripcion'));  */
                                                        }
                                                    }
                                                    ,items:[
                                                        {
                                                            xtype:'textfield'
                                                            ,hidden:true
                                                            ,name:'matriculacursado'
                                                            ,id:'matriculacursadoId'
                                                        },
                                                        {
                                                            xtype:'combo'
                                                            ,fieldLabel:'Carrera'
                                                            ,id:'combocarreraId'
                                                            ,valueField:'id'
                                                            ,mode:'local'
                                                            ,displayField:'denominacion'
                                                            ,hiddenName:'carrera_id'
                                                            ,store:new Ext.data.JsonStore({
                                                                root:'rows',
                                                                url:carreraUrl,
                                                                fields:['id','denominacion'],
                                                                baseParams:{
                                                                    alumnoId: alumnoId
                                                                },
                                                                autoLoad:true
                                                            }),
                                                            listeners:{
                                                                change:function(combo,newValue,oldValue){
                                                                    if(newValue==''){
                                                                        Ext.getCmp('comboaniolectivoId').getStore().removeAll();
                                                                        Ext.getCmp('gridcorrelfinId').getStore().removeAll();
                                                                        Ext.getCmp('comboaniolectivoId').clearValue();
                                                                    }
                                                                },
                                                                afterrender: function(combo){
                                                                    /*var rowselected = combo.getStore().getAt(0);
                                                                    Ext.getCmp('comboaniolectivoId').getStore().load({
                                                                        params:{
                                                                            alumnoId:alumnoId,
                                                                            carreraId:rowselected.get('id')
                                                                        }
                                                                    });
                                                                    rowselected = Ext.getCmp('comboaniolectivoId').getStore().getAt(0);
                                                                    Ext.getCmp('comboaniolectivoId').setValue(rowselected.get('descripcion'));*/

                                                                },
                                                                select:function(combo,record,index){
                                                                    var rowselectedCarrera = Ext.getCmp('combocarreraId').getStore().getAt(0);
                                                                    Ext.getCmp('comboaniolectivoId').getStore().load({
                                                                        params:{
                                                                            alumnoId:alumnoId,
                                                                            carreraId:rowselectedCarrera.get('id')
                                                                        }
                                                                    });

                                                                }
                                                            }
                                                        },
                                                        {
                                                            xtype:'textfield',
                                                            id:'inscfinalesmateriasId',
                                                            name:'inscfinalesmaterias',
                                                            hidden:true
                                                        },
                                                        {   xtype:'combo'
                                                            ,fieldLabel:'Año Lectivo'
                                                            ,id:'comboaniolectivoId'
                                                            ,valueField:'id'
                                                            ,mode:'local'
                                                            ,displayField:'descripcion'
                                                            ,hiddenName:'aniolectivo_id'
                                                            ,store:new Ext.data.JsonStore({
                                                                    root:'rows',
                                                                    url:anioLectivoUrl,
                                                                    fields:['id','descripcion'],
                                                                    baseParams:{
                                                                        alumnoId:alumnoId
                                                                    },
                                                                    autoLoad:false
                                                                }),
                                                            listeners:{
                                                                /*afterrender: function(combo){
                                                                    var rowselected = combo.getStore().getAt(0);
                                                                    combo.setValue(rowselected.get('descripcion'));
                                                                }, */
                                                                select:function(combobox,record,index){
                                                                    Ext.getCmp('gridcorrelfinId').getStore().load({
                                                                        params:{
                                                                            alumnoId:alumnoId,
                                                                            anioLectivoId:Ext.getCmp('comboaniolectivoId').hiddenField.value,
                                                                            carreraId:Ext.getCmp('combocarreraId').hiddenField.value
                                                                        }
                                                                    });
                                                                    rowselectedAnioLectivo = Ext.getCmp('combocarreraId').getStore().getAt(0);
                                                                    Ext.getCmp('matriculacursadoId').setValue(rowselectedAnioLectivo.get('matricula'));
                                                                }
                                                            }
                                                        },new Ext.grid.GridPanel({
                                                            id:'gridcorrelfinId',
                                                            store:new Ext.data.JsonStore({
                                                                root:'rows',
                                                                url:correlFinal,
                                                                fields:[{name:'id'},{name:'denominacion'},{name:'nivel'},{name:'seleccionada',type:'bool'}],
                                                                autoLoad:false
                                                            }),
                                                            columns: [
                                                                {header: "id",dataIndex:'id',hidden:true},
                                                                {header: "Denominación",width:200,sortable:false,dataIndex:'denominacion'},
                                                                {header: "Nivel",width:100,sortable:false,dataIndex:"nivel"},
                                                                {
                                                                    xtype: 'checkcolumn',
                                                                    header: 'Seleccionada',
                                                                    dataIndex: 'seleccionada',
                                                                    width: 70,
                                                                    editor:{
                                                                        xtype:'checkbox'
                                                                    }
                                                                }
                                                            ],
                                                            stripeRows: true,
                                                            height:250,
                                                            width:500,
                                                            loadMask:true,
                                                            title:'Materias a Inscribir',
                                                            iconCls: 'icon-grid',
                                                            listeners:{
                                                            }
                                                            })

                                                    ],
                                                    buttons:[
                                                        {
                                                            text:'Inscribir en Final',
                                                            handler: function(){

                                                            }
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                },{
                                        xtype: 'portal',
                                        title: 'Inscripciones',
                                        tabTip: 'Inscripciones'
                                }, {
                                        title: 'Inscribirme en Cursado',
                                        iconCls: 'x-icon-subscriptions',
                                        tabTip: 'Inscripciones para el cursado',
                                        style: 'padding: 10px;',
                                        layout: 'fit',
                                        items: [{
                                            xtype: 'panel',
                                            activeTab: 1,
                                            items:[
                                                {
                                                    xtype:'form'
                                                    ,id:'formcursadoId'
                                                    ,style: 'margin:0 auto;margin-top:100px;'
                                                    ,url:submitCurUrl
                                                    ,frame:true
                                                    ,width:500
                                                    ,title:'Inscripción de Cursado'
                                                    ,items:[
                                                    {
                                                        xtype:'textfield'
                                                        ,hidden:true
                                                        ,name:'matriculacursado'
                                                        ,id:'matriculacursadoId'
                                                    },
                                                    {
                                                        xtype:'textfield'
                                                        ,hidden:true
                                                        ,name:'insccursadomaterias'
                                                        ,id:'insccursadomateriasId'
                                                    },
                                                    {
                                                        xtype:'combo'
                                                        ,fieldLabel:'Carrera'
                                                        ,id:'combocarreracurId'
                                                        ,valueField:'id'
                                                        ,mode:'local'
                                                        ,displayField:'denominacion'
                                                        ,hiddenName:'carrera_id'
                                                        ,store:new Ext.data.JsonStore({
                                                        root:'rows',
                                                        url:carreraUrl,
                                                        fields:['id','denominacion'],
                                                        baseParams:{
                                                            alumnoId: alumnoId
                                                        },
                                                        autoLoad:true
                                                    }),
                                                        listeners:{
                                                            change:function(combo,newValue,oldValue){
                                                                if(newValue==''){
                                                                    Ext.getCmp('comboaniolectivocurId').getStore().removeAll();
                                                                    Ext.getCmp('gridcorrelcurId').getStore().removeAll();
                                                                    Ext.getCmp('comboaniolectivocurId').clearValue();
                                                                }
                                                            },
                                                            afterrender: function(combo){
                                                                /*var rowselected = combo.getStore().getAt(0);
                                                                 Ext.getCmp('comboaniolectivoId').getStore().load({
                                                                 params:{
                                                                 alumnoId:alumnoId,
                                                                 carreraId:rowselected.get('id')
                                                                 }
                                                                 });
                                                                 rowselected = Ext.getCmp('comboaniolectivoId').getStore().getAt(0);
                                                                 Ext.getCmp('comboaniolectivoId').setValue(rowselected.get('descripcion'));*/

                                                            },
                                                            select:function(combo,record,index){
                                                                var rowselectedCarrera = Ext.getCmp('combocarreracurId').getStore().getAt(0);
                                                                Ext.getCmp('comboaniolectivocurId').getStore().load({
                                                                    params:{
                                                                        alumnoId:alumnoId,
                                                                        carreraId:rowselectedCarrera.get('id')
                                                                    }
                                                                });

                                                            }
                                                        }
                                                    },
                                                    {   xtype:'combo'
                                                        ,fieldLabel:'Año Lectivo'
                                                        ,id:'comboaniolectivocurId'
                                                        ,valueField:'id'
                                                        ,mode:'local'
                                                        ,displayField:'descripcion'
                                                        ,hiddenName:'aniolectivo_id'
                                                        ,store:new Ext.data.JsonStore({
                                                        root:'rows',
                                                        url:anioLectivoUrl,
                                                        fields:['id','descripcion','matricula'],
                                                        baseParams:{
                                                            alumnoId:alumnoId
                                                        },
                                                        autoLoad:false
                                                    }),
                                                        listeners:{
                                                            /*afterrender: function(combo){
                                                             var rowselected = combo.getStore().getAt(0);
                                                             combo.setValue(rowselected.get('descripcion'));
                                                             }, */
                                                            select:function(combobox,record,index){
                                                                Ext.getCmp('gridcorrelcurId').getStore().load({
                                                                    params:{
                                                                        alumnoId:alumnoId,
                                                                        anioLectivoId:Ext.getCmp('comboaniolectivocurId').hiddenField.value,
                                                                        carreraId:Ext.getCmp('combocarreracurId').hiddenField.value
                                                                    }
                                                                });
                                                            }
                                                        }
                                                    }

                                                    ,new Ext.grid.GridPanel({
                                                        id:'gridcorrelcurId',
                                                        stripeRows:true,
                                                        store:new Ext.data.JsonStore({
                                                            root:'rows',
                                                            url:correlCursar,
                                                            fields:[{name:'id'},{name:'denominacion'},{name:'nivel'},{name:'seleccionada',type:'bool'}],
                                                            autoLoad:false
                                                        }),
                                                        columns: [
                                                            {header: "id",dataIndex:'id',hidden:true},
                                                            {header: "Denominación",width:200,sortable:false,dataIndex:'denominacion'},
                                                            {header: "Nivel",width:100,sortable:false,dataIndex:"nivel"},
                                                            {
                                                                xtype: 'checkcolumn',
                                                                header: 'Seleccionada',
                                                                dataIndex: 'seleccionada',
                                                                width: 70,
                                                                editor:{
                                                                    xtype:'checkbox'
                                                                }
                                                            }
                                                        ],
                                                        stripeRows: true,
                                                        height:250,
                                                        width:500,
                                                        loadMask:true,

                                                        title:'Materias a Inscribir',
                                                        iconCls: 'icon-grid',
                                                        listeners:{
                                                        }
                                                    })
                                                ],buttons:[
                                                        {
                                                            text:'Inscribir en Cursado',
                                                            handler: function(){
                                                                var rowselectedMatricula = Ext.getCmp('comboaniolectivocurId').getStore().getAt(0);
                                                                Ext.getCmp('matriculacursadoId').setValue(rowselectedMatricula.get('matricula'));
                                                                Ext.getCmp('insccursadomateriasId').setValue(getRowsDataCursar());
                                                                Ext.getCmp('formcursadoId').getForm().submit({
                                                                    success: function(f,resp){
                                                                        var respuesta = Ext.decode(resp.response.responseText);
                                                                        mensaje = respuesta.msg+'<br><br>';
                                                                        Ext.Msg.show({
                                                                            title:'Mensajes',
                                                                            //icon:Ext.MessageBox.INFO,
                                                                            msg: mensaje,
                                                                            buttons: Ext.MessageBox.OK,
                                                                            fn: function(btn){
                                                                                Ext.getCmp('gridcorrelcurId').getStore().load({
                                                                                    alumnoId:alumnoId,
                                                                                    anioLectivoId:Ext.getCmp('comboaniolectivocurId').hiddenField.value,
                                                                                    carreraId:Ext.getCmp('combocarreracurId').hiddenField.value
                                                                                })

                                                                            }
                                                                        });

                                                                    },
                                                                    failure: function(f,resp){
                                                                        var respuesta = Ext.decode(resp.response.responseText);
                                                                        mensaje = respuesta.msg+'<br><br>';
                                                                        for(var i=0;i<respuesta.errors.length;i++){
                                                                            mensaje = mensaje +'- '+respuesta.errors[i].msg+'<br>';
                                                                        }

                                                                        Ext.Msg.show({
                                                                            title:'Mensajes',
                                                                            icon:Ext.MessageBox.ERROR ,
                                                                            msg: mensaje,
                                                                            buttons: Ext.MessageBox.OK,
                                                                            fn: function(btn){
                                                                            }
                                                                        });

                                                                    }
                                                                });
                                                            }
                                                        }
                                                    ]
                                                }

                                            ]
                                        }]
                                }, {
                                        title: 'Listado de Inscripciones',
                                        iconCls: 'x-icon-users',
                                        tabTip: 'Users tabtip',
                                        style: 'padding: 10px;',
                                        layout:'fit',
                                        items:[
                                            {
                                              xtype:'panel',
                                              items:[
                                                  new Ext.grid.GridPanel({
                                                      style: 'margin:0 auto;margin-top:100px;',
                                                      id:'gridlistadoInscripcionesId',
                                                      stripeRows:true,
                                                      store:storelistadoinscripciones,
                                                      columns: [
                                                          nestedRowGrid,

                                                          {header: "id",dataIndex:'id',hidden:true},
                                                          {header: "Carrera",width:200,sortable:false,dataIndex:'carrera'},
                                                          {header: "Año",width:150,sortable:false,dataIndex:"aniolectivo"},
                                                          {header: "Fecha",width:100,sortable:false,dataIndex:"fecha",renderer: Ext.util.Format.dateRenderer('d/m/y')}
                                                      ],
                                                      stripeRows: true,
                                                      height:400,
                                                      width:650,
                                                      loadMask:true,
                                                      plugins:nestedRowGrid,
                                                      title:'Mis Inscripciones',
                                                      iconCls: 'icon-grid',
                                                      listeners:{
                                                      },
                                                       bbar: new Ext.PagingToolbar({
                                                           pageSize: 10,
                                                           store: storelistadoinscripciones,
                                                           displayInfo:true,
                                                           displayMsg: 'Visualizando registros {0} - {1} de {2}',
                                                           emptyMsg: 'No hay registros para visualizar'
                                                       })
                                                  })

                                              ]
                                            }
                                        ]
                                }
                            ]
                        }, {
                            expanded: true,
                            items: [

                                {
                                title: 'Mis Cuotas',
                                layout:'fit',
                                iconCls: 'x-icon-configuration',
                                tabTip: 'Configuration tabtip',
                                style: 'padding: 10px;',//,
                                items:[
                                ]
                                }, {
                                    title: 'Impresión de Recibos',
                                    iconCls: 'x-icon-templates',
                                    tabTip: 'Templates tabtip',
                                    style: 'padding: 10px;'//,
                                    //html: Ext.example.shortBogusMarkup
                                }, {
                                title: 'Estado de Deudas',
                                iconCls: 'x-icon-templates',
                                tabTip: 'Templates tabtip',
                                style: 'padding: 10px;'//,
                                //html: Ext.example.shortBogusMarkup
                                }
                            ]
                        },{
                            expanded:true,
                            items:[
                                {
                                    title:'Mi Estado Académico',
                                    iconCls:'',
                                    tabTip:'Detalle sobre mi estado academico',
                                    style: 'padding: 10px;'//,
                                },{
                                    title:'Materias Aprobadas',
                                    iconCls: 'x-icon-templates',
                                    tabTip:'Finales Aprobados',
                                    style: 'padding: 10px;',
                                    items:[
                                        {
                                            xtype:'form',
                                            id:'formmateriasaprobadasId',
                                            style: 'margin:0 auto;margin-top:100px;',
                                            frame:true,
                                            width:500,
                                            items:[
                                                {
                                                    layout:'column',
                                                    border:false,
                                                    items:[
                                                        {
                                                            layout:'form',
                                                            border:false,
                                                            items:[
                                                                {
                                                                    xtype : 'textfield',
                                                                    fieldLabel : 'Filtrar por Materia',
                                                                    id:'filtromateriaId',
                                                                    width:200,
                                                                    anchor:0
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            width:60,
                                                            border:false,
                                                            items:[
                                                                {
                                                                    xtype:'button',
                                                                    text:'Buscar',
                                                                    listeners:{

                                                                    }
                                                                }
                                                            ]
                                                        }
                                                    ]
                                                },new Ext.grid.GridPanel({
                                                    id:'gridmateriasaprobadasId',
                                                    stripeRows:true,
                                                    store:storelistadoinscripciones,
                                                    columns: [
                                                        nestedRowGrid,

                                                        {header: "id",dataIndex:'id',hidden:true},
                                                        {header: "Carrera",width:200,sortable:false,dataIndex:'carrera'},
                                                        {header: "Año",width:150,sortable:false,dataIndex:"aniolectivo"},
                                                        {header: "Fecha",width:100,sortable:false,dataIndex:"fecha",renderer: Ext.util.Format.dateRenderer('d/m/y')}
                                                    ],
                                                    stripeRows: true,
                                                    height:400,
                                                    width:650,
                                                    loadMask:true,
                                                    plugins:nestedRowGrid,
                                                    title:'Mis Inscripciones'
                                                })
                                            ]
                                        }
                                    ]
                                },{
                                    title:'Materias Regulares',
                                    iconCls: 'x-icon-templates',
                                    tabTip:'Cursado Regular',
                                    style: 'padding: 10px;'//,
                                }
                            ]
                        }
                ]
            }
        ]
    });

    /*Ext.getCmp('gridcorrelcurId').getStore().load({
        params:{
            alumnoId:alumnoid,
            anioLectivoId:Ext.getCmp('comboaniolectivoId').hiddenField.value,
            carreraId:Ext.getCmp('combocarreraId').hiddenField.value
        }
    });*/

});