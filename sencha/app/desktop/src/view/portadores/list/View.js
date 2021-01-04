Ext.define('AppSamos.view.portadores.list.View', {
    extend: 'Ext.Panel',
    xtype: 'portadoreslist',

    requires: [
       'AppSamos.view.portadores.form.View',
       'AppSamos.view.portadores.list.ViewController',
       'AppSamos.view.portadores.list.ViewModel'
    ],

    title: 'Portadores',

    bodyPadding: 0,

    defaultFocus: 'textfield',
    
    listeners: {
        show: 'init'
    },

    controller: 'portadoreslist',
    viewModel: 'portadoreslist',

    layout: {
        type: 'vbox',
        align: 'stretch'
    },

    items: [
        {
            xtype: 'panel',
            layout: 'hbox',
            padding: '8 20',
            items: [
                {
                    xtype: 'button',
                    text: 'Incluir',
                    cls: 'primary-button',
                    width: 100,
                    handler: 'onIncluirClick'
                },
                {
                    xtype: 'container',
                    flex: 1
                },
                {
                    xtype: 'button',
                    text: 'Sair',
                    cls: 'secondary-button',
                    handler: 'onSairClick',
                    width: 100
                }
            ]
        }, 
        {
            xtype: 'panel',
            flex: 1,
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            margin: '0 20 20 20',
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
                            height: 30,
                            text: 'Buscar',
                            margin: '12 0 12 0',
                            cls: 'primary-button',
                            handler: 'onBuscarClick'
                        }
                    ]
                },
                {
                    xtype: 'grid',
                    flex: 1,
                    //height: 500,
                    listeners: {
                        childdoubletap: 'onChildDblTap'
                    },
                    bind: {
                        store: '{portadores}'
                    },
                    plugins: 'pagingtoolbar',
                    columns: [
                        {
                            text: 'Código',
                            align: 'center',
                            dataIndex: 'PORTADORES_ID',
                            flex: 1
                        }, 
                        {
                            text: 'Nome',
                            dataIndex: 'PORTADORES_NOME',
                            flex: 4
                        },
                        {
                            text: 'Endereço',
                            dataIndex: 'PORTADORES_ENDERECO',
                            flex: 4
                        },
                        {
                            text: 'Número',
                            dataIndex: 'PORTADORES_NUMERO',
                            flex: 1
                        },
                        {
                            text: 'Cidade',
                            dataIndex: 'CIDADES_NOME',
                            flex: 3
                        },
                        {
                            text: 'Estado',
                            dataIndex: 'CIDADES_ESTADO',
                            flex: 1
                        }
                    ]
                }
            ]
        }
    ]
});