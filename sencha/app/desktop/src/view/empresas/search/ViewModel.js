Ext.define('AppSamos.view.empresas.search.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.empresassearch',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueOrdem    : '0',
            valueStatus   : '0'
        });

        this.setStores({
            empresas: {
                type: 'store',
                pageSize: 5,
                model: 'AppSamos.view.empresas.Model',
                proxy    : {
                    type : 'ajax',
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