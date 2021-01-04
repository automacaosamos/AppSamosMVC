Ext.define('AppSamos.view.usuarios.search.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.usuariossearch',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueOrdem    : '0',
            valueStatus   : '0'
        });

        this.setStores({
            usuarios: {
                type: 'store',
                pageSize: 5,
                model: 'AppSamos.view.usuarios.Model',
                proxy    : {
                    type : 'ajax',
                    url: localStorage.getItem('api') + '/usuariosbuscar',
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