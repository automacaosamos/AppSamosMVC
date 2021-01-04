Ext.define('AppSamos.view.bancos.search.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.bancossearch',

    init: function(view) {
        Ext.asap(() => view.focus(true));
    },
    
    onBuscarClick: function(btn, e) {
        const storebancos = this.getViewModel().getStore('bancos');
        storebancos.currentPage = 1;
        storebancos.load();
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