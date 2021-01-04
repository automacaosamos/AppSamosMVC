Ext.define('AppSamos.view.permissoes.Model', {    
    extend: 'Ext.data.Model',
    idProperty: 'PERMISSOES_ID',

    proxy: {
        type: 'rest',
        writer: {
            type: 'json',
            writeAllFields: true
        }
    },
    
    fields: [
        'PERMISSOES_ID',
        'PERMISSOES_ID_USUARIOS',
        'PERMISSOES_ID_EMPRESAS',
        'PERMISSOES_ITENS'
    ]
});