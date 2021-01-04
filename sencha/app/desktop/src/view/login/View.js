Ext.define('AppSamos.view.login.View', {
    extend: 'Ext.Panel',
    xtype: 'login',

    requires: [
        'AppSamos.view.login.ViewController',
        'AppSamos.view.login.ViewModel',
        'AppSamos.view.main.MainView'
    ],

    layout: {
        type: 'vbox',
        align: 'center',
        pack: 'center'
    },

    controller: 'login',
    viewModel: 'login',

    cls: 'login-panel',

    listeners: {
        show: 'sairApplicacao'
    },

    defaultFocus: 'textfield',//componente que receberá foco

    items: [
        {
            xtype: 'panel',
            cls: 'login-box',
            title: 'Login',
            width: '80%',
            maxWidth: 300,
            bodyPadding: '10 20',
            border: true,
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'textfield',
                    label: 'Usuário',
                    reference: 'usuario',
                    labelInPlaceholder: false,
                    labelAlign: 'top',
                    triggers: null,
                    listeners: {
                        keydown: 'onKeyDownUsuario'
                    }                
                },
                {
                    xtype: 'textfield',
                    label: 'Senha',
                    inputType: 'password',
                    margin: '0 0 20 0',
                    reference: 'senha',
                    labelInPlaceholder: false,
                    labelAlign: 'top',
                    triggers: null,
                    listeners: {
                        keydown: 'onKeyDownSenha'
                    }      
                },
                {
                    xtype: 'list',
                    reference: 'listempresas',
                    itemTpl: '{EMPRESAS_FANTASIA}',
                    deselectable: false,
                    height: 130,
                    minHeight: 50,
                    bind: {
                        store: '{permissoes}',
                        hidden: '{unlogged}'
                    }
                },     
                {
                    xtype: 'panel',
                    layout: 'hbox',
                    margin: '10 0 0 0',
                    defaults: {
                        flex: 1
                    },
                    items: [
                        {
                            xtype: 'button',
                            text: 'Entrar',
                            iconCls: 'x-fa fa-user',
                            cls: 'secondary-button',
                            margin: '0 10 15 0',
                            handler: 'onEntrarClick',
                            bind: {
                                hidden: '{unlogged}'
                            }
                        },
                        {
                            xtype: 'button',
                            text: 'Login',
                            iconCls: 'x-fa fa-user',
                            cls: 'secondary-button',
                            margin: '0 10 15 0',
                            handler: 'onLoginClick',
                            bind: {
                                hidden: '{logged}'
                            }
                        },
                        {
                            xtype: 'button',
                            text: 'Sair',
                            iconCls: 'x-fa fa-door-open',
                            cls: 'secondary-button',
                            margin: '0 0 15 0',
                            handler: 'onSairClick'
                        }
                    ]
                }
            ]
        }
    ]
});