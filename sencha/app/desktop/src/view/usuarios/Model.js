Ext.define('AppSamos.view.usuarios.Model', {    
    extend: 'Ext.data.Model',
    idProperty: 'USUARIOS_ID',

    proxy: {
        type: 'rest',
        writer: {
            type: 'json',
            writeAllFields: true
        }
    },

    fields: [
        'USUARIOS_ID',
        'USUARIOS_STATUS',
        'USUARIOS_CPFCNPJ',
        'USUARIOS_TIPO',
        {
            name: 'USUARIOS_RG',
            validators: [
                {type: 'length', max: 15, allowBlank: true}
            ]
        },
        {
            name: 'USUARIOS_NASCIMENTO',
            validators: [
                {type: 'presence'}
            ]
        },
        {
            name: 'USUARIOS_CADASTRO',
            validators: [
                {type: 'presence'}
            ]
        },
        {
            name: 'USUARIOS_VALIDADE',
            validators: [
                {type: 'presence'}
            ]
        },
        {
            name: 'USUARIOS_NOME',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'USUARIOS_CEP',
            validators: [
                {type: 'length', max: 8},
                {type: 'presence'}
            ]
        },
        'USUARIOS_ID_CIDADES',   
        'CIDADES_NOME',
        'CIDADES_ESTADO',
        'CIDADES_IBGE',
        {
            name: 'USUARIOS_ENDERECO',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'USUARIOS_NUMERO',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 10},
                {type: 'format', format: 'Número ou "S/NR"', matcher: /^[0-9]*$|S\/NR/}
            ]
        },
        {
            name: 'USUARIOS_BAIRRO',
            validators: [
//                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'USUARIOS_TELEFONE',
            validators: [
                {type: 'length', max: 15}
//                {type: 'presence', alternative: 'USUARIOS_CELULAR'}
            ]
        },
        {
            name: 'USUARIOS_CELULAR',
            validators: [
                {type: 'length', max: 15}
//                {type: 'presence', alternative: 'USUARIOS_TELEFONE'}
            ]
        },
        {
            name: 'USUARIOS_EMAIL',
            validators: [
//                {type: 'presence'},                
                {type: 'email'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'USUARIOS_LOGIN',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'USUARIOS_SENHA',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 20}
            ]
        },
        {
            name: 'USUARIOS_FUNCAO',
            validators: [
                {type: 'length', max: 50}
            ]
        },
        'USUARIOS_COMISSAO',
        'USUARIOS_PRIVILEGIADO',
        'USUARIOS_ID_EMPRESAS',
        'EMPRESAS_NOME',
        'USUARIOS_NOVASENHA',
        'USUARIOS_TEMPO'
    ]
});