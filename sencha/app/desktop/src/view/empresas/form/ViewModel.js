Ext.define('AppSamos.view.empresas.form.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.empresasform',

    formulas: {
        valueEmpresasStatus: function(get) {
            const status = get('model.EMPRESAS_STATUS');
            return status == 'T';
        },

        valueEmpresasSimples: function(get) {
            const status = get('model.EMPRESAS_SIMPLES');
            return status == 'T';
        },

        valueEmpresasAutentica: function(get) {
            const status = get('model.EMPRESAS_AUTENTICA');
            return status == 'T';
        },

        valueEmpresasCaixa: function(get) {
            const status = get('model.EMPRESAS_CAIXA');
            return status == 'T';
        },

        valueEmpresasAnalisaCliente: function(get) {
            const status = get('model.EMPRESAS_ANALISACLIENTE');
            return status == 'T';
        },

        emEdicao: function(get) {
            return !get('readOnly');
        }
    }
});