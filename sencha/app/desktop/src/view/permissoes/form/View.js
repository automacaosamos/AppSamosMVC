Ext.define('AppSamos.view.permissoes.form.View', {
    extend: 'Ext.form.Panel',
    xtype: 'permissoesform',

    requires: [
       'AppSamos.view.permissoes.form.ViewController',
       'AppSamos.view.permissoes.form.ViewModel',
       'Ext.field.Spinner'
    ],

    title: 'Permissoes',

    platformConfig: {
        desktop: {
            title: 'Permissoes'
        },

        '!desktop': {
            title: 'Permissoes'
        }
    },

    bodyPadding: '0',

    controller: 'permissoesform',
    viewModel: 'permissoesform',

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
                        value: '{model.PEMISSOES_ID}',
                        readOnly: true
                    }
                },
                {
                    xtype: 'numberfield',
                    label: 'Usuário',
                    textAlign: 'right',
                    triggers: null,
                    minValue: 0,
                    maxValue: 99999,
                    flex: 1,
                    bind: {
                        value: '{model.PEMISSOES_ID_USUARIOS}',
                        readOnly: true
                    }
                },
                {
                    xtype: 'numberfield',
                    label: 'Empresa',
                    textAlign: 'right',
                    triggers: null,
                    minValue: 0,
                    maxValue: 99999,
                    flex: 1,
                    bind: {
                        value: '{model.PEMISSOES_ID_EMPRESAS}',
                        readOnly: true
                    }
                },
                {
                    xtype: 'textfield',
                    label: 'Permissões',
                    reference : 'permissoes',
                    flex: 3.3,
                    bind: {
                        value: '{model.PEMISSOES_ITENS}',
                        readOnly: '{readOnly}'
                    }
                }
            ]
        }
    ]
});