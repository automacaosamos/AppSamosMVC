Ext.define('AppSamos.view.cidades.search.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.cidadessearch',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueOrdem    : '0',
            valueStatus   : '0'
        });

        this.setStores({
            cidades: {
                type: 'store',
                pageSize: 5,
                model: 'AppSamos.view.cidades.Model',
                proxy    : {
                    type : 'ajax',
                    url: localStorage.getItem('api') + '/cidadesbuscar',
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