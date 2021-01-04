Ext.define('appsamos.src.model.portadores.Model', {
    extend: 'Ext.data.Model',
    idProperty: 'PORTADORES_ID',

    proxy: {
        type: 'rest',
        writer: {
            type: 'json',
            writeAllFields: true
        }
    },

    constructor: function () {
        this.defaultValues = {
            'PORTADORES_ID_EMPRESAS': 0,            
            'PORTADORES_REMESSA'    : 0,
            'PORTADORES_MORA'       : 0,
            'PORTADORES_MULTA'      : 0
        };
        this.callParent(arguments);
    },

    fields: [
        'PORTADORES_ID',                      
        {
            name: 'PORTADORES_ID_EMPRESAS',   
            validators: [
                {type: 'presence'}
            ]
        },
        'EMPRESAS_NOME',
        {
            name: 'PORTADORES_STATUS',      
            type: 'check',
            defaultValue: 'T'
        },
        {
            name: 'PORTADORES_CPFCNPJ',    
            type: 'mask',
            validators: [
                {type: 'cpfcnpj'},
                {type: 'presence'}
            ]
        },
        {
            name: 'PORTADORES_EMAIL',    
            validators: [
                {type: 'email'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'PORTADORES_CADASTRO',  
            type: 'nodejsdate',
            validators: [
                {type: 'presence'}
            ]
        },
        {
            name: 'PORTADORES_NOME',  
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'PORTADORES_TELEFONE',  
            type: 'mask',
            validators: [
                {type: 'length', max: 15}
            ]
        },
        {
            name: 'PORTADORES_CEP',   
            type: 'mask',
            validators: [
                {type: 'presence'},
            ]
        },
        'CIDADES_NOME',
        'CIDADES_ESTADO',
        'CIDADES_IBGE',
        {
            name: 'PORTADORES_ENDERECO',   
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'PORTADORES_NUMERO',   
            validators: [
                {type: 'length', max: 10},
                {type: 'format', format: 'Número ou "S/NR"', matcher: /^[0-9]*$|S\/NR/}
            ]
        },
        {
            name: 'PORTADORES_BAIRRO', 
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'PORTADORES_ID_BANCOS',  
            validators: [
                {type: 'presence'}
            ]
        },
        'BANCOS_NOME',
        {
            name: 'PORTADORES_AGENCIA',   
            validators: [
                {type: 'length', max: 6}
            ]
        },
        {
            name: 'PORTADORES_CONTA',
            validators: [
                {type: 'length', max: 15}
            ]
        },
        {
            name: 'PORTADORES_CONVENIO',  
            validators: [
                {type: 'length', max: 15}
            ]
        },
        {
            name: 'PORTADORES_CARTEIRA',  
            validators: [
                {type: 'length', max: 2}
            ]
        },
        {
            name: 'PORTADORES_PROTESTO',  
            validators: [
                {type: 'length', max: 2}
            ]
        },
        {
            name: 'PORTADORES_DEVOLUCAO', 
            validators: [
                {type: 'length', max: 2}
            ]
        },
        {
            name: 'PORTADORES_REMESSA',  
            validators: [
                {type: 'presence'},
                {type: 'range', min: 0, max: 9999999}
            ]
        },
        {
            name: 'PORTADORES_MORA',    
            validators: [
                {type: 'presence'},
                {type: 'range', min: 0, max: 100}
            ]
        },
        {
            name: 'PORTADORES_MULTA',        
            validators: [
                {type: 'presence'},
                {type: 'range', min: 0, max: 100}
            ]
        },
        {
            name: 'PORTADORES_NOSSONUMERO',        
            validators: [
                {type: 'presence'}
            ]
        },
        'PORTADORES_ID_CIDADES',     
    ]
});
