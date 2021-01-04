Ext.define('AppSamos.view.bancos.Model', {    
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
        'BANCOS_STATUS',
        {
            name: 'BANCOS_NOME',
            validators: [
                {type: 'presence'},
                {type: 'length', max: 50}
            ]
        }
    ]
});