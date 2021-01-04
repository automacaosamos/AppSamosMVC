Ext.define('AppSamos.view.cidades.form.View', {
    extend: 'Ext.form.Panel',
    xtype: 'cidadesform',

    requires: [
       'AppSamos.view.cidades.form.ViewController',
       'AppSamos.view.cidades.form.ViewModel',
       'Ext.field.Spinner'
    ],

    title: 'Cidades',

    platformConfig: {
        desktop: {
            title: 'Cidades'
        },

        '!desktop': {
            title: 'Cidades'
        }
    },

    bodyPadding: '0',

    controller: 'cidadesform',
    viewModel: 'cidadesform',

    layout: 'vbox',

    scrollable: true,

    modal: true,
    centered: true,
    floated: true,
    closable: true,

    width: '90%',
    height: '90%',

    maxWidth: 1024,
    maxHeight: 900,

    defaultFocus: 'textfield:not([readOnly])',

    defaults: {
        padding: '0 20',
        defaults: {
            labelInPlaceholder: false,
            labelAlign: 'top',
        }
    },

    items: [
        {
            xtype: 'panel',
            layout: 'hbox',
            cls: 'toolbar-cls',
            border: 'none none solid none',
            padding: '10 20',
            defaults: {
                margin: '0 5 0 0'
            },
            items: [
                {
                    xtype: 'button',
                    width: 90,
                    text: 'Incluir',
                    handler: 'onIncluirClick',
                    cls: 'primary-button',
                    bind: {
                        disabled: '{emEdicao}'
                    }
                },
                {
                    xtype: 'button',
                    width: 90,
                    text: 'Editar',
                    cls: 'secondary-button',
                    handler: 'onEditarClick',
                    bind: {
                        disabled: '{emEdicao}'
                    }
                },
                {
                    xtype: 'button',
                    width: 90,
                    text: 'Excluir',
                    cls: 'danger-button',
                    handler: 'onExcluirClick',
                    bind: {
                        disabled: '{emEdicao}'
                    }
                },
                {
                    xtype: 'component',
                    flex: 1
                },
                {
                    xtype: 'button',
                    width: 95,
                    text: 'Cancela',
                    cls: 'secondary-button',
                    handler: 'onCancelaClick',
                    bind: {
                        disabled: '{readOnly}'
                    }
                },
                {
                    xtype: 'button',
                    width: 90,
                    text: 'Gravar',
                    cls: 'primary-button',
                    handler: 'onGravarClick',
                    bind: {
                        disabled: '{readOnly}'
                    }
                }
            ]
        },
        {
            xtype: 'panel',
            layout: 'hbox',
            defaults: {
                triggers: null
            },
            items: [
                {
                    xtype: 'numberfield',
                    label: 'Código',
                    textAlign: 'right',
                    triggers: null,
                    minValue: 0,
                    maxValue: 99999,
                    flex: 1,
                    bind: {
                        value: '{model.CIDADES_ID}',
                        readOnly: true
                    }
                },
                {
                    xtype: 'togglefield',
                    labelTextAlign: 'center',
                    bodyAlign: 'center',
                    flex: 1,
                    label: 'Ativo',
                    reference: 'status',
                    bind: {
                        value: '{valueCidadesStatus}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    label: 'Nome',
                    reference : 'nome',
                    flex: 3,
                    bind: {
                        value: '{model.CIDADES_NOME}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    label: 'Estado',
                    reference : 'estado',
                    flex: 1,
                    bind: {
                        value: '{model.CIDADES_ESTADO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    label: 'Ibge',
                    reference : 'ibge',
                    flex: 1,
                    bind: {
                        value: '{model.CIDADES_IBGE}',
                        readOnly: '{readOnly}'
                    }
                }
            ]
        }
    ]
});