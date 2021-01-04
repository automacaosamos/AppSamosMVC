Ext.define('AppSamos.view.permissoes.list.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.permissoeslist',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueStatus   : '0',
            valueOrdem    : '0'
        });

        this.setStores({
            permissoes: {
                type     : 'store',
                pageSize : 9,
                model    : 'AppSamos.view.permissoes.Model',
                proxy    : {
                    type : 'rest',
                    url: localStorage.getItem('api') + '/permissoesbuscar',
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