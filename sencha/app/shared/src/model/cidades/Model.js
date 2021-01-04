Ext.define('appsamos.src.model.cidades.Model', {
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
        'CIDADES_NOME',
        'CIDADES_ESTADO',
        'CIDADES_IBGE'
    ]
});
