Ext.define('AppSamos.view.cidades.search.View', {
    extend: 'Ext.Panel',
    xtype: 'cidadessearch',

    requires: [
       'AppSamos.view.cidades.form.View',
       'AppSamos.view.cidades.search.ViewController',
       'AppSamos.view.cidades.search.ViewModel'
    ],

    title: 'Cidades',

    bodyPadding: 0,

    defaultFocus: 'textfield',

    controller: 'cidadessearch',
    viewModel : 'cidadessearch',

    modal    : true,
    centered : true,
    floated  : true,
    closable : true,

    width  : '80%',
    height : '80%',

    maxWidth  : 800,
    maxHeight : 450,

    layout: {
        type: 'vbox',
        align: 'stretch'
    },

    items: [
        {
            xtype: 'panel',
            flex: 1,
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            margin: '20',
            border: 'solid 1px',
            style: 'box-shadow: 0 0 5px 0px #b1b1b1',
            items: [
                {
                    xtype: 'panel',
                    padding: '0 5 5 5',
                    layout: 'hbox',
                    cls: 'toolbar-cls',
                    defaults: {
                        margin: '0 10 0 0',
                        labelInPlaceholder: false,
                        labelAlign: 'top'
                    },
                    items: [
                        {
                            xtype: 'textfield',
                            flex: 1,
                            label: 'Pesquisar...',
                            triggers: null,
                            bind: {
                                value: '{valueConteudo}'
                            },
                            listeners: {
                                keydown: 'onKeyDownPesquisar'
                            }
                        },
                        {
                            xtype: 'combobox',
                            label: 'Ordem',
                            editable: false,
                            width: 100,
                            queryMode: 'local',
                            displayField: 'field2',
                            valueField: 'field1',
                            bind: {
                                value: '{valueOrdem}',
                            },
                            store: [
                                ['0', 'Nome'],
                                ['1', 'Código'],
                                ['2', 'Conteúdo']
                            ]
                        },
                        {
                            xtype: 'combobox',
                            label: 'Status',
                            editable: false,
                            width: 100,
                            queryMode: 'local',
                            displayField: 'field2',
                            valueField: 'field1',
                            bind: {
                                value: '{valueStatus}',
                            },
                            store: [
                                ['0', 'Ativos'],
                                ['1', 'Inativos'],
                                ['2', 'Todos']
                            ]
                        },
                        {
                            xtype: 'button',
                            width: 100,
                            text: 'Buscar',
                            margin: '12 0 12 0',
                            height: 30,
                            cls: 'primary-button',
                            handler: 'onBuscarClick'
                        }
                    ]
                },
                {
                    xtype: 'grid',
                    flex: 1,
                    listeners: {
                        childdoubletap: 'onChildDblTap'
                    },
                    bind: {
                        store: '{cidades}'
                    },
                    plugins: 'pagingtoolbar',
                    columns: [
                        {
                            text: 'Código',
                            align: 'center',
                            dataIndex: 'CIDADES_ID',
                            flex: 1
                        },
                        {
                            text: 'Nome',
                            dataIndex: 'CIDADES_NOME',
                            flex: 4
                        },
                        {
                            text: 'Estado',
                            dataIndex: 'CIDADES_ESTADO',
                            flex: 1
                        },
                        {
                            text: 'Ibge',
                            dataIndex: 'CIDADES_IBGE',
                            flex: 1
                        }
                    ]
                }
            ]
        }
    ]
});