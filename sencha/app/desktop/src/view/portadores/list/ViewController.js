Ext.define('AppSamos.view.portadores.list.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.portadoreslist',

    init: function(view) {//chamada por padrão quando a view é instanciada
        Ext.asap(() => view.focus(true));
    },

    onBuscarClick: function(btn, e) {
        const storeportadores = this.getViewModel().getStore('portadores');
        storeportadores.currentPage = 1;
        storeportadores.load();
    },

    onChildDblTap: function(grid, line) {
        const form = Ext.create({
            xtype: 'portadoresform'
        });

        form.show();

        form.getViewModel().set({
            'model': line.record,
            'modelOriginal': Object.assign({}, line.record.data),
            'readOnly': true
        });

        this.getView().add(form);
    },

    onIncluirClick: function(btn, e) {
        const form = Ext.create({
            xtype: 'portadoresform'
        });

        form.show();
        this.getView().add(form);

        const novaPortadores = Ext.create('AppSamos.view.portadores.Model');

        form.setMasked({
            xtype: 'loadmask',
            message: 'Aguarde...'
        });
        
        Ext.Ajax.request({
            method: 'GET',
            url: localStorage.getItem('api')  + '/portadoresbuscar',
            disableCaching: false,
            params: {
                parametros: 'ULTIMAPORTADORES|0|0',
                start     : 0,
                limit     : 1
            },
            failure: response => {
                setTimeout(() => {
                    const dialog = Ext.Msg.alert('Mensagem', 'Não consegui trazer o ultimo código');
                    Ext.defer(dialog.hide, 2000, dialog);
                    form.setMasked(false);
                }, 1000);
            },
            success: response => {
                const objList = JSON.parse(response.responseText);
                
                novaPortadores.set(objList.results[0]);

                form.getViewModel().set({
                    'model'        : novaPortadores,
                    'modelOriginal': {},
                    'readOnly'     : false
                });

                form.setMasked(false);
            }
        });
    },

    onSairClick: function(btn, e){
        this.getViewModel().getStore('portadores').removeAll();
        this.redirectTo('homeview');
    },

    onKeyDownPesquisar: function(txt, event) {
        if(event.keyCode == 13) {
            this.onBuscarClick();
        }
    }
    
});