Ext.define('AppSamos.view.bancos.search.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.bancossearch',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueOrdem    : '0',
            valueStatus   : '0'
        });

        this.setStores({
            bancos: {
                type: 'store',
                pageSize: 5,
                model: 'AppSamos.view.bancos.Model',
                proxy    : {
                    type : 'ajax',
                    url: localStorage.getItem('api') + '/bancosbuscar',
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