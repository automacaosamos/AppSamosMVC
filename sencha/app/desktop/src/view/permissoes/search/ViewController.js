Ext.define('AppSamos.view.permissoes.search.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.permissoessearch',

    init: function(view) {
        Ext.asap(() => view.focus(true));
    },
    
    onBuscarClick: function(btn, e) {
        const storepermissoes = this.getViewModel().getStore('permissoes');
        storepermissoes.currentPage = 1;
        storepermissoes.load();
    },

    onChildDblTap: function(grid, line) {
        this.getView().resolve(line.record);
        this.getView().destroy();
    },

    onKeyDownPesquisar: function(txt, event) {
        if(event.keyCode == 13) {
            this.onBuscarClick();
        }
    }
});