Ext.define('AppSamos.view.cidades.Model', {    
    extend: 'Ext.data.Model',
    idProperty: 'CIDADES_ID',

    proxy: {
        type: 'rest',
        writer: {
            type: 'json',
            writeAllFields: true
        }
    },
    
    fields: [
        'CIDADES_ID',
        'CIDADES_STATUS',
        {
            name: 'CIDADES_NOME',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        },
        {
            name: 'CIDADES_ESTADO',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 2}
            ]
        },
        {
            name: 'CIDADES_IBGE',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 8}
            ]
        }

    ]
});