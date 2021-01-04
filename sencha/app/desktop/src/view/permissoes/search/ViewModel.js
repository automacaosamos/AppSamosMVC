Ext.define('AppSamos.view.permissoes.search.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.permissoessearch',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueOrdem    : '0',
            valueStatus   : '0'
        });

        this.setStores({
            permissoes: {
                type: 'store',
                pageSize: 5,
                model: 'AppSamos.view.permissoes.Model',
                proxy    : {
                    type : 'ajax',
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