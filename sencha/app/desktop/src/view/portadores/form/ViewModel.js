Ext.define('AppSamos.view.portadores.form.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.portadoresform',

    formulas: {
        valuePortadoresStatus: function(get) {
            const status = get('model.PORTADORES_STATUS');
            return status == 'T';
        },
        emEdicao: function(get) {
            return !get('readOnly');
        }
    }
});