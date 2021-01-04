Ext.define('AppSamos.view.bancos.form.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.bancosform',

    formulas: {
        valueBancosStatus: function(get) {
            const status = get('model.BANCOS_STATUS');
            return status == 'T';
        },
        emEdicao: function(get) {
            return !get('readOnly');
        }
    }
});