Ext.define('AppSamos.view.bancos.list.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.bancoslist',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueStatus   : '0',
            valueOrdem    : '0'
        });

        this.setStores({
            bancos: {
                type     : 'store',
                pageSize : 9,
                model    : 'AppSamos.view.bancos.Model',
                proxy    : {
                    type : 'rest',
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