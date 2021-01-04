Ext.define('AppSamos.view.login.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.login',

    data: {
        unlogged: true,
        dataPermissoes: []
    },

    formulas: {
        logged: function(get) {
            return !get('unlogged');
        }
    },

    stores: {
        permissoes: {
            type: 'store',
            model: 'Ext.data.Model',
            autoLoad: true,
            data: '{dataPermissoes}',
            proxy: {
                type : 'memory'
            }
        }
    }
});