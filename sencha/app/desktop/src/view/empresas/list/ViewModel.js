Ext.define('AppSamos.view.empresas.list.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.empresaslist',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueStatus   : '0',
            valueOrdem    : '0'
        });

        this.setStores({
            empresas: {
                type     : 'store',
                pageSize : 9,
                model    : 'AppSamos.view.empresas.Model',
                proxy    : {
                    type : 'rest',
                    url: localStorage.getItem('api') + '/empresasbuscar',
                    disableCaching: false,
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('token')
                    },
                    extraParams: {
                        parametros: '{valueConteudo}|{valueStatus}|{valueOrdem}',
                    },
                    reader: {
                        type: 'json',
                        rootProperty: 'results'
                    }
                }
            }
        });
    }
    
});