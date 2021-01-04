Ext.define('AppSamos.view.usuarios.search.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.usuariossearch',

    init: function(view) {
        Ext.asap(() => view.focus(true));
    },
    
    onBuscarClick: function(btn, e) {
        const storeusuarios = this.getViewModel().getStore('usuarios');
        storeUsuarios.currentPage = 1;
        storeUsuarios.load();
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