Ext.define('appsamos.src.model.usuarios.Model', {
    extend: 'Ext.data.Model',
    idProperty: 'USUARIOS_ID',

    proxy: {
        type: 'rest',
        writer: {
            type: 'json',
            writeAllFields: true
        }
    },

    constructor: function () {
        this.defaultValues = {
            'USUARIOS_ID_EMPRESAS' : 1,
            'USUARIOS_TIPO'        : '1',
            'USUARIOS_TEMPO'       : '2',
            'USUARIOS_STATUS'      : 'T',
            'USUARIOS_PRIVILEGIADO': '1',
        };
        this.callParent(arguments);
    },

    fields: [
        'USUARIOS_ID',
        'USUARIOS_STATUS',
        {
            name: 'USUARIOS_NOME', 
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        'EMPRESAS_NOME', 
        {
            name:'USUARIOS_LOGIN', 
            validators: [
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'USUARIOS_CPFCNPJ',  
            type: 'mask',
            validators: [
                {type: 'presence', max:15},
                {type: 'cpfcnpj'}
            ]
        },
        {
            name: 'USUARIOS_RG', 
            type: 'mask',
            validators: [
                {type: 'presence', max:15}
            ]
        },
        {
            name:'USUARIOS_TIPO'
        },        
        {
            name:'USUARIOS_TEMPO'
        },
        {
            name: 'USUARIOS_TELEFONE',
            type: 'mask',
            validators: [
                {type: 'length', max: 15}
            ]
        },
        {
            name: 'USUARIOS_CELULAR', 
            type: 'mask',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 15}
            ]
        },
        {
            name: 'USUARIOS_VALIDADE',
            type: 'date',
            validators: [
                {type: 'presence'}
            ]
        },
        {
            name: 'USUARIOS_CADASTRO',
            type: 'date',
            validators: [
                {type: 'presence'}
            ]
        },
        {
            name: 'USUARIOS_CEP', 
            type: 'mask',
            validators: [
                {type: 'presence', max:9}
            ]
        },
        'USUARIOS_ID_CIDADES',
        'CIDADES_NOME',
        'CIDADES_IBGE',
        'CIDADES_ESTADO',
        {
            name: 'USUARIOS_ENDERECO', 
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'USUARIOS_BAIRRO', 
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        }, 
        {
            name: 'USUARIOS_EMAIL', 
            validators: [
                {type: 'email'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'USUARIOS_COMISSAO',     
            type: 'float'
        },
        {
            name: 'USUARIOS_PRIVILEGIADO'
        },
        'USUARIOS_ID_EMPRESAS'
    ]
});
