Ext.define('appsamos.src.model.empresas.Model', {
    extend: 'Ext.data.Model',
    idProperty: 'EMPRESAS_ID',

    proxy: {
        type: 'rest',
        writer: {
            type: 'json',
            writeAllFields: true
        }
    },

    fields: [
        'EMPRESAS_ID',
        {
            name: 'EMPRESAS_STATUS',
            type: 'check',
            defaultValue: 'T'
        },
        {
            name: 'EMPRESAS_CPFCNPJ',
            type: 'mask',
            validators: [
                {type: 'presence'},
                {type: 'cpfcnpj'}
            ]
        },
        'EMPRESAS_INSCRICAO',
        {
            name: 'EMPRESAS_MUNICIPAL',
            validators: [
                {type: 'length', max: 15, allowBlank: true}
            ]
        },
        {
            name: 'EMPRESAS_EMAIL',
            validators: [
                {type: 'presence'},                
                {type: 'email'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'EMPRESAS_CADASTRO',
            type: 'nodejsdate',
            validators: [
                {type: 'presence'}
            ]
        },
        {
            name: 'EMPRESAS_NOME',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'EMPRESAS_TELEFONE',
            type: 'mask',
            validators: [
                {type: 'presence', alternative: 'EMPRESAS_CELULAR'}
            ]
        },
        {
            name: 'EMPRESAS_CELULAR',
            type: 'mask',
            validators: [
                {type: 'presence', alternative: 'EMPRESAS_TELEFONE'}
            ]
        },
        {
            name: 'EMPRESAS_FANTASIA',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'EMPRESAS_REGIAO12',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 20}
            ]
        },
        {
            name: 'EMPRESAS_CNAE',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'EMPRESAS_PAGINA',
            validators: [
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'EMPRESAS_CEP',
            type: 'mask',
            validators: [
                {type: 'presence'}
            ]
        },
        'CIDADES_NOME',
        'CIDADES_ESTADO',
        'CIDADES_IBGE',
        {
            name: 'EMPRESAS_ENDERECO',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'EMPRESAS_NUMERO',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 10},
                {type: 'format', format: 'Número ou "S/NR"', matcher: /^[0-9]*$|S\/NR/}
            ]
        },
        {
            name: 'EMPRESAS_BAIRRO',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        'EMPRESAS_ID_CIDADES',   
        'EMPRESAS_ID_PORTADORES',
        'PORTADORES_NOME',
        {
            name: 'EMPRESAS_LOGIN',
            validators: [
                {type: 'presence'},
                {type: 'email'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'EMPRESAS_PASSWORD',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 15}
            ]
        },
        {
            name: 'EMPRESAS_SMTP',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'EMPRESAS_AUTENTICA',
            type: 'check',
            defaultValue: 'T'
        },
        {
            name: 'EMPRESAS_CAIXA',
            type: 'check',
            defaultValue: 'F'
        },
        {
            name: 'EMPRESAS_CERTIFICADO',
            validators: [
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'EMPRESAS_SENHA',
            validators: [
                {type: 'length', max: 15}
            ]
        },
        {
            name: 'EMPRESAS_AMBIENTE',
            validators: [
                {type: 'presence'}
            ]
        },
        {
            name: 'EMPRESAS_IMPRESSAO',
            validators: [
                {type: 'presence'}
            ]
        },
        {
            name: 'EMPRESAS_SIMPLES',
            type: 'check',
            defaultValue: 'T'
        },
        {
            name: 'EMPRESAS_ALIQUOTA'
        },
        {
            name: 'EMPRESAS_ANALISACLIENTE',
            type: 'check',
            defaultValue: 'T'
        },
        {
            name: 'EMPRESAS_ATRASOCLIENTE',
            validators: [
                {type: 'presence'}
            ]
        }
    ]
});
