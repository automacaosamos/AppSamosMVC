Ext.define('AppSamos.view.empresas.search.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.empresassearch',

    init: function(view) {
        Ext.asap(() => view.focus(true));
    },
    
    onBuscarClick: function(btn, e) {
        const storeempresas = this.getViewModel().getStore('empresas');
        storeempresas.currentPage = 1;
        storeempresas.load();
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