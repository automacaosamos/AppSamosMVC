Ext.define('AppSamos.view.usuarios.form.View', {
    extend: 'Ext.form.Panel',
    xtype: 'usuariosform',

    requires: [
       'AppSamos.view.usuarios.form.ViewController',
       'AppSamos.view.usuarios.form.ViewModel',
       'Ext.field.Spinner'
    ],

    title: 'Usuarios',

    platformConfig: {
        desktop: {
            title: 'Usuarios'
        },

        '!desktop': {
            title: 'Usuarios'
        }
    },

    bodyPadding: '0',

    controller: 'usuariosform',
    viewModel: 'usuariosform',

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
                        value: '{model.USUARIOS_ID}',
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
                        value: '{valueUsuariosStatus}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    label: 'CpfCnpj',
                    reference: 'cpfcnpj',
                    bind: {
                        value: '{model.USUARIOS_CPFCNPJ}',
                        readOnly: '{readOnly}'
                    },
                    listeners: {
                        keydown: 'onValidaCpfCnpj'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    label: 'Identidade',
                    reference: 'rg',
                    bind: {
                        value: '{model.USUARIOS_RG}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    label: 'Login',
                    reference: 'login',
                    bind: {
                        value: '{model.USUARIOS_LOGIN}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    inputType: 'password',                    
                    flex: 2,
                    label: 'Senha',
                    reference: 'senha',
//                    cls: 'text-lowercase',
                    bind: {
                        value: '{model.USUARIOS_SENHA}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype      : 'datefield',
                    dateFormat : 'd/m/Y',
                    label      : 'Cadastro',
                    reference  : 'cadastro',
                    flex       : 1,
                    fieldLabel : 'Cadastro',
                    bind: {
                        value    : '{model.USUARIOS_CADASTRO}',
                        readOnly : '{readOnly}'
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
                    xtype: 'textfield',
                    label: 'Nome',
                    reference: 'nome',
                    flex: 3.6,
                    bind: {
                        value: '{model.USUARIOS_NOME}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2.4,
                    label: 'Email',
                    reference: 'email',
                    bind: {
                        value: '{model.USUARIOS_EMAIL}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype      : 'datefield',
                    dateFormat : 'd/m/Y',
                    label      : 'Nascimento',
                    reference  : 'nascimento',
                    flex       : 2,
                    fieldLabel : 'Nascimento',
                    bind: {
                        value    : '{model.USUARIOS_NASCIMENTO}',
                        readOnly : '{readOnly}'
                    }
                },
                {
                    xtype      : 'datefield',
                    dateFormat : 'd/m/Y',
                    label      : 'Validade',
                    reference  : 'validade',
                    flex       : 2,
                    fieldLabel : 'Validade',
                    bind: {
                        value    : '{model.USUARIOS_VALIDADE}',
                        readOnly : '{readOnly}'
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
                    xtype: 'textfield',
                    label: 'Cep:',
                    flex: 1,
                    reference: 'cep',
                    bind: {
                        value: '{model.USUARIOS_CEP}',
                        readOnly: '{readOnly}'
                    },
                    listeners: {
                        keydown: 'onSearchCeps'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 5,
                    label: 'Endereço',
                    reference: 'endereco',
                    bind: {
                        value: '{model.USUARIOS_ENDERECO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    label: 'Número',
                    bind: {
                        value: '{model.USUARIOS_NUMERO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'combobox',
                    flex: 2,
                    label: 'Privilegiado',
                    queryMode: 'local',
                    displayField: 'field2',
                    valueField: 'field1',
                    bind: {
                        value: '{model.USUARIOS_PRIVILEGIADO}',
                        readOnly: '{readOnly}'
                    },
                    store: [
                        [ '0', 'Sim'],
                        [ '1', 'Não']
                    ]
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
                    xtype: 'textfield',
                    label: 'Bairro',
                    flex: 3,
                    bind: {
                        value: '{model.USUARIOS_BAIRRO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1,
                    label: 'Celular',
                    bind: {
                        value: '{model.USUARIOS_CELULAR}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1,
                    label: 'Telefone',
                    reference: 'telefone',
                    bind: {
                        value: '{model.USUARIOS_TELEFONE}',
                        readOnly: '{readOnly}'
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
                    xtype: 'textfield',
                    flex: 3,
                    label: 'Cidade',
                    bind: {
                        value: '{model.CIDADES_NOME}',
                        readOnly: true
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1,
                    label: 'Estado',
                    bind: {
                        value: '{model.CIDADES_ESTADO}',
                        readOnly: true
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1,
                    label: 'Função',
                    reference: 'funcao',
                    bind: {
                        value: '{model.USUARIOS_FUNCAO}',
                        readOnly: '{readOnly}'
                    }
                }
            ]
        },
        {
            xtype: 'panel',
            layout: 'hbox',
            padding: '0 20 20 20',
            items: [
                {
                    xtype: 'textfield',
                    flex: 2.7,
                    label: 'Empresas',
                    bind: {
                        value: '{model.EMPRESAS_NOME}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'button',
                    iconCls: 'x-fa fa-search',
                    width: 40,
                    margin: '24 15 0 10',
                    height: 30,
                    cls: 'secondary-button',
                    handler: 'buscarEmpresas',
                    bind: {
                        disabled: '{readOnly}'
                    }                            
                },
                {
                    xtype: 'spinnerfield',
                    flex: 1,
                    textAlign: 'right',                    
                    margin: '0 5 5 0',                                  
                    label: 'Tempo',
                    labelTextAlign: 'left',
                    allowDecimals: false,
                    decimals: 0,
                    stepValue: 1,
                    minValue: 1,
                    bind: {
                        value: '{model.USUARIOS_TEMPO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'spinnerfield',
                    flex: 1,
                    textAlign: 'right',                    
                    margin: '0 5 5 0',                                  
                    label: 'Comissão',
                    labelTextAlign: 'left',
                    allowDecimals: true,
                    decimals: 2,
                    stepValue: 0.01,
                    maxValue: 100.00,
                    bind: {
                        value: '{model.USUARIOS_COMISSAO}',
                        readOnly: '{readOnly}'
                    }
                }
            ]
        }
    ]
});