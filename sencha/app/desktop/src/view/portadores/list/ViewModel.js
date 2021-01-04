Ext.define('AppSamos.view.portadores.list.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.portadoreslist',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueStatus   : '0',
            valueOrdem    : '0'
        });

        this.setStores({
            portadores: {
                type     : 'store',
                pageSize : 9,
                model    : 'AppSamos.view.portadores.Model',
                proxy    : {
                    type : 'rest',
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