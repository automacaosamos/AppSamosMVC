Ext.define('AppSamos.view.portadores.form.View', {
    extend: 'Ext.form.Panel',
    xtype: 'portadoresform',

    requires: [
       'AppSamos.view.portadores.form.ViewController',
       'AppSamos.view.portadores.form.ViewModel',
       'Ext.field.Spinner'
    ],

    title: 'Portadores',

    platformConfig: {
        desktop: {
            title: 'Portadores'
        },

        '!desktop': {
            title: 'Portadores'
        }
    },

    bodyPadding: '0',

    controller: 'portadoresform',
    viewModel: 'portadoresform',

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
                        value: '{model.PORTADORES_ID}',
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
                        value: '{valuePortadoresStatus}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    label: 'CpfCnpj',
                    reference: 'cpfcnpj',
                    bind: {
                        value: '{model.PORTADORES_CPFCNPJ}',
                        readOnly: '{readOnly}'
                    },
                    listeners: {
                        keydown: 'onValidaCpfCnpj'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 4,
                    label: 'Email',
                    reference: 'email',
                    bind: {
                        value: '{model.PORTADORES_EMAIL}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1.4,
                    label: 'Telefone',
                    reference: 'telefone',
                    bind: {
                        value: '{model.PORTADORES_TELEFONE}',
                        readOnly: '{readOnly}'
                    }
                },                
                {
                    xtype      : 'datefield',
                    dateFormat : 'd/m/Y',
                    label      : 'Cadastro',
                    flex       : 1.8,
                    fieldLabel : 'Cadastro',
                    readOnly   : true,
                    fieldLabel : 'Cadastro',
                    bind: {
                        value    : '{model.PORTADORES_CADASTRO}',
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
                    flex: 3.3,
                    bind: {
                        value: '{model.PORTADORES_NOME}',
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
                    label: 'Cep:',
                    flex: 1,
                    reference: 'cep',
                    bind: {
                        value: '{model.PORTADORES_CEP}',
                        readOnly: '{readOnly}'
                    },
                    listeners: {
                        keydown: 'onSearchCeps'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 6,
                    label: 'Endereço',
                    reference: 'endereco',
                    bind: {
                        value: '{model.PORTADORES_ENDERECO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1.1,
                    label: 'Número',
                    bind: {
                        value: '{model.PORTADORES_NUMERO}',
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
                    label: 'Bairro',
                    flex: 3,
                    bind: {
                        value: '{model.PORTADORES_BAIRRO}',
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
                    flex: 2.95,
                    label: 'Cidade',
                    bind: {
                        value: '{model.CIDADES_NOME}',
                        readOnly: true
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2.05,
                    label: 'Estado',
                    bind: {
                        value: '{model.CIDADES_ESTADO}',
                        readOnly: true
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
                    flex: 3,
                    label: 'Banco',
                    bind: {
                        value: '{model.BANCOS_NOME}',
                        readOnly: true
                    }
                },
                {
                    xtype: 'button',
                    iconCls: 'x-fa fa-search',
                    width: 40,
                    margin: '24 15 0 10',
                    height: 30,
                    cls: 'secondary-button',
                    handler: 'buscarBancos',
                    bind: {
                        disabled: '{readOnly}'
                    }                            
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    label: 'Empresas',
                    bind: {
                        value: '{model.EMPRESAS_NOME}',
                        readOnly: true
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
                    flex: 1,
                    label: 'Agência',
                    bind: {
                        value: '{model.PORTADORES_AGENCIA}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1,
                    label: 'Conta',
                    bind: {
                        value: '{model.PORTADORES_CONTA}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1,
                    label: 'Convênio',
                    bind: {
                        value: '{model.PORTADORES_CONVENIO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1,
                    label: 'Carteira',
                    bind: {
                        value: '{model.PORTADORES_CARTEIRA}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1,
                    label: 'Protesto',
                    bind: {
                        value: '{model.PORTADORES_PROTESTO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1,
                    label: 'Devolução',
                    bind: {
                        value: '{model.PORTADORES_DEVOLUCAO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'numberfield',
                    flex: 1,
                    label: 'Remessa',
                    bind: {
                        value: '{model.PORTADORES_REMESSA}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'numberfield',
                    flex: 1,
                    label: 'N. Número',
                    bind: {
                        value: '{model.PORTADORES_NOSSONUMERO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'spinnerfield',
                    flex: 1,
                    textAlign: 'right',                    
                    margin: '0 5 5 0',                                  
                    label: 'Mora',
                    labelTextAlign: 'center',
                    allowDecimals: true,
                    decimals: 2,
                    stepValue: 0.01,
                    minValue: 0.01,
                    bind: {
                        value: '{model.PORTADORES_MORA}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'spinnerfield',
                    flex: 1,
                    textAlign: 'right',      
                    margin: '0 5 5 0',                                  
                    label: 'Multa',
                    labelTextAlign: 'center',                    
                    allowDecimals: true,
                    decimals: 2,
                    stepValue: 0.01,
                    minValue: 0.01,
                    bind: {
                        value: '{model.PORTADORES_MULTA}',
                        readOnly: '{readOnly}'
                    }
                }                                                
            ]
        }
    ]
});