Ext.define('AppSamos.view.empresas.form.View', {
    extend: 'Ext.form.Panel',
    xtype: 'empresasform',

    requires: [
       'AppSamos.view.empresas.form.ViewController',
       'AppSamos.view.empresas.form.ViewModel',
       'Ext.field.Spinner'
    ],

    title: 'Empresas',

    platformConfig: {
        desktop: {
            title: 'Empresas'
        },

        '!desktop': {
            title: 'Empresas'
        }
    },

    bodyPadding: '0',

    controller: 'empresasform',
    viewModel: 'empresasform',

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
                    reference : 'incluir',
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
                    text: 'Alterar',
                    reference : 'alterar',
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
                    reference : 'excluir',
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
                    reference : 'cancela',
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
                    reference : 'gravar',
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
                        value: '{model.EMPRESAS_ID}',
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
                        value: '{valueEmpresasStatus}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    label: 'CpfCnpj',
                    reference: 'cpfcnpj',
                    bind: {
                        value: '{model.EMPRESAS_CPFCNPJ}',
                        readOnly: '{readOnly}'
                    },
                    listeners: {
                        keydown: 'onValidaCpfCnpj'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    reference: 'inscricao',
                    label: 'Inscrição',
                    bind: {
                        value: '{model.EMPRESAS_INSCRICAO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    label: 'Municipal',
                    reference: 'municipal',
                    bind: {
                        value: '{model.EMPRESAS_MUNICIPAL}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 4,
                    label: 'Email',
                    bind: {
                        value: '{model.EMPRESAS_EMAIL}',
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
                        value    : '{model.EMPRESAS_CADASTRO}',
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
                        value: '{model.EMPRESAS_NOME}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    label: 'Fantasia',
                    flex: 3.25,
                    bind: {
                        value: '{model.EMPRESAS_FANTASIA}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    label: 'Cnae',
                    flex: 1,
                    bind: {
                        value: '{model.EMPRESAS_CNAE}',
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
                        value: '{model.EMPRESAS_CEP}',
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
                        value: '{model.EMPRESAS_ENDERECO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1.1,
                    label: 'Número',
                    bind: {
                        value: '{model.EMPRESAS_NUMERO}',
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
                        value: '{model.EMPRESAS_BAIRRO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    label: 'Página',
                    bind: {
                        value: '{model.PESSOAS_PAGINA}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1.6,
                    label: 'Celular',
                    bind: {
                        value: '{model.EMPRESAS_CELULAR}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1.4,
                    label: 'Telefone',
                    reference: 'telefone',
                    bind: {
                        value: '{model.EMPRESAS_TELEFONE}',
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
                    flex: 2,
                    label: 'Estado',
                    bind: {
                        value: '{model.CIDADES_ESTADO}',
                        readOnly: true
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1.6,
                    label: 'Atrazo',
                    bind: {
                        value: '{model.PESSOAS_ATRAZOCLIENTE}',
                        readOnly: true
                    }
                },
/*                {
                    xtype: 'textfield',
                    flex: 1,
                    label: 'Aliquota',
                    bind: {
                        value: '{model.PESSOAS_ALIQUOTA}',
                        readOnly: true
                    }
                }, */
                {
                    xtype: 'togglefield',
                    labelTextAlign: 'center',
                    bodyAlign: 'center',
                    flex: 1.4,
                    label: 'Devedores',
                    reference: 'analisacliente',
                    bind: {
                        value: '{valueEmpresasAnalisaCliente}',
                        readOnly: '{readOnly}'
                    }
                }
            ]
        },
        {
            xtype: 'panel',
            layout: 'hbox',
            items: [
                {
                    xtype: 'textfield',
                    flex: 3,
                    label: 'Login',
                    cls: 'text-lowercase',
                    bind: {
                        value: '{model.EMPRESAS_LOGIN}',
                        readOnly: '{readOnly}'
                    },
                    listeners: {
                        keyup: 'toLowerCase'
                    }
                },
                {
                    xtype: 'textfield',
                    inputType: 'password',                    
                    flex: 2,
                    label: 'Senha',
                    cls: 'text-lowercase',
                    bind: {
                        value: '{model.EMPRESAS_PASSWORD}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    flex: 1.6,
                    label: 'Servidor email',
                    cls: 'text-lowercase',
                    bind: {
                        value: '{model.EMPRESAS_SMTP}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'togglefield',
                    labelTextAlign: 'center',
                    bodyAlign: 'center',
                    flex: 1.4,
                    label: 'Autentica',
                    reference: 'autentica',
                    bind: {
                        value: '{valueEmpresasAutentica}',
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
                    flex: 3,
                    label: 'Série Certificado',
                    bind: {
                        value: '{model.EMPRESAS_CERTIFICADO}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'textfield',
                    inputType: 'password',
                    flex: 2,
                    label: 'Senha Certificado',
                    bind: {
                        value: '{model.EMPRESAS_SENHA}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'combobox',
                    flex: 1.6,
                    label: 'Ambiente',
                    queryMode: 'local',
                    displayField: 'field2',
                    valueField: 'field1',
                    bind: {
                        value: '{model.EMPRESAS_AMBIENTE}',
                        readOnly: '{readOnly}'
                    },
                    store: [
                        [ 'P', 'Produção'],
                        [ 'H', 'Homologação']
                    ]
                },
                {
                    xtype: 'togglefield',
                    labelTextAlign: 'center',
                    bodyAlign: 'center',
                    flex: 1.4,
                    label: 'Caixa',
                    reference: 'caixa',
                    bind: {
                        value: '{valueEmpresasCaixa}',
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
                    flex: 3,
                    label: 'Portador',
                    bind: {
                        value: '{model.PORTADORES_NOME}',
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
                    handler: 'buscarPortadores',
                    bind: {
                        disabled: '{readOnly}'
                    }                            
                },
                {
                    xtype: 'textfield',
                    flex: 2,
                    label: 'Estados 12%',
                    bind: {
                        value: '{model.EMPRESAS_REGIAO12}',
                        readOnly: '{readOnly}'
                    }
                },
                {
                    xtype: 'combobox',
                    flex: 1.6,
                    label: 'impressão',
                    queryMode: 'local',
                    displayField: 'field2',
                    valueField: 'field1',
                    bind: {
                        value: '{model.EMPRESAS_IMPRESSAO}',
                        readOnly: '{readOnly}'
                    },
                    store: [
                        [ '0', 'Visualizar'],
                        [ '1', 'Matricial'],
                        [ '2', 'Ambos']
                    ]
                },
                {
                    xtype: 'togglefield',
                    labelTextAlign: 'center',
                    bodyAlign: 'center',
                    flex: 1.4,
                    label: ' Simples ',
                    reference: 'simples',
                    bind: {
                        value: '{valueEmpresasSimples}',
                        readOnly: '{readOnly}'
                    }
                }                
            ]
        }
    ]
});