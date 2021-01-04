Ext.define('appsamos.src.model.bancos.Model', {
    extend: 'Ext.data.Model',
    idProperty: 'BANCOS_ID',

    proxy: {
        type: 'rest',
        writer: {
            type: 'json',
            writeAllFields: true
        }
    },

    fields: [
        'BANCOS_ID',
        {
            name: 'BANCOS_STATUS',
            type: 'check',
            defaultValue: 'T'
        },
        {
            name: 'BANCOS_NOME',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        }
    ]
});
