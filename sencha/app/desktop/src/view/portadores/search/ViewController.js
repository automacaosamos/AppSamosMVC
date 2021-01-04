Ext.define('AppSamos.view.portadores.search.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.portadoressearch',

    init: function(view) {
        Ext.asap(() => view.focus(true));
    },
    
    onBuscarClick: function(btn, e) {
        const storeportadores = this.getViewModel().getStore('portadores');
        storeportadores.currentPage = 1;
        storeportadores.load();
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