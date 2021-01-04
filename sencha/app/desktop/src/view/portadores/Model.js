Ext.define('AppSamos.view.portadores.Model', {    
    extend: 'Ext.data.Model',
    idProperty: 'PORTADORES_ID',

    proxy: {
        type: 'rest',
        writer: {
            type: 'json',
            writeAllFields: true
        }
    },

    fields: [
        'PORTADORES_ID',
        'PORTADORES_STATUS',
        'PORTADORES_CPFCNPJ',
        {
            name: 'PORTADORES_EMAIL',
            validators: [
                {type: 'presence'},                
                {type: 'email'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'PORTADORES_CADASTRO',
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
            validators: [
                {type: 'presence', alternative: 'PORTADORES_CELULAR'}
            ]
        },
        {
            name: 'PORTADORES_CEP',
            validators: [
                {type: 'presence'}
            ]
        },
        'PORTADORES_ID_CIDADES',   
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
                {type: 'presence'},
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
        'PORTADORES_ID_BANCOS',
        'BANCOS_NOME',
        'PORTADORES_ID_EMPRESAS',
        'EMPRESAS_NOME',
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
        'PORTADORES_REMESSA',
        'PORTADORES_NOSSONUMERO',
        'PORTADORES_MORA',
        'PORTADORES_MULTA'
    ]
});
