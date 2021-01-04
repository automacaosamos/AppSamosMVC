Ext.define('AppSamos.view.cidades.list.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.cidadeslist',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueStatus   : '0',
            valueOrdem    : '0'
        });

        this.setStores({
            cidades: {
                type     : 'store',
                pageSize : 9,
                model    : 'AppSamos.view.cidades.Model',
                proxy    : {
                    type : 'rest',
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