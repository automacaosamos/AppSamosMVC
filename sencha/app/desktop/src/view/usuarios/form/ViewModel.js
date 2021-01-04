Ext.define('AppSamos.view.usuarios.form.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.usuariosform',

    formulas: {
        valueUsuariosStatus: function(get) {
            const status = get('model.USUARIOS_STATUS');
            return status == 'T';
        },

        valueUsuariosSimples: function(get) {
            const status = get('model.USUARIOS_SIMPLES');
            return status == 'T';
        },

        valueUsuariosAutentica: function(get) {
            const status = get('model.USUARIOS_AUTENTICA');
            return status == 'T';
        },

        valueUsuariosCaixa: function(get) {
            const status = get('model.USUARIOS_CAIXA');
            return status == 'T';
        },

        valueUsuariosAnalisaCliente: function(get) {
            const status = get('model.USUARIOS_ANALISACLIENTE');
            return status == 'T';
        },

        emEdicao: function(get) {
            return !get('readOnly');
        }
    }
});