Ext.define('AppSamos.view.portadores.search.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.portadoressearch',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueOrdem    : '0',
            valueStatus   : '0'
        });

        this.setStores({
            portadores: {
                type: 'store',
                pageSize: 5,
                model: 'AppSamos.view.portadores.Model',
                proxy    : {
                    type : 'ajax',
                    url: localStorage.getItem('api') + '/portadoresbuscar',
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