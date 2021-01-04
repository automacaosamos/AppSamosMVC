Ext.define('AppSamos.view.usuarios.list.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.usuarioslist',

    constructor: function(){
        this.callParent(arguments);

        this.setData({
            valueConteudo : '',
            valueStatus   : '0',
            valueOrdem    : '0'
        });

        this.setStores({
            usuarios: {
                type     : 'store',
                pageSize : 9,
                model    : 'AppSamos.view.usuarios.Model',
                proxy    : {
                    type : 'rest',
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