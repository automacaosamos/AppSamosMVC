Ext.define('AppSamos.view.cidades.search.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.cidadessearch',

    init: function(view) {
        Ext.asap(() => view.focus(true));
    },
    
    onBuscarClick: function(btn, e) {
        const storecidades = this.getViewModel().getStore('cidades');
        storecidades.currentPage = 1;
        storecidades.load();
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