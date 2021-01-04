Ext.define('AppSamos.view.cidades.form.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.cidadesform',

    formulas: {
        valueCidadesStatus: function(get) {
            const status = get('model.CIDADES_STATUS');
            return status == 'T';
        },
        emEdicao: function(get) {
            return !get('readOnly');
        }
    }
});