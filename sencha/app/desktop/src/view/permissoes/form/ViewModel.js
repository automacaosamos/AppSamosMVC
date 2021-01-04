Ext.define('AppSamos.view.permissoes.form.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.permissoesform',

    formulas: {
        emEdicao: function(get) {
            return !get('readOnly');
        }
    }
});