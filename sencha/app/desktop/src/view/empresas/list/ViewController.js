Ext.define('AppSamos.view.empresas.list.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.empresaslist',

    init: function(view) {//chamada por padrão quando a view é instanciada
        Ext.asap(() => view.focus(true));
    },

    onBuscarClick: function(btn, e) {
        const storeempresas = this.getViewModel().getStore('empresas');
        storeempresas.currentPage = 1;
        storeempresas.load();
    },

    onChildDblTap: function(grid, line) {
        const form = Ext.create({
            xtype: 'empresasform'
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
            xtype: 'empresasform'
        });

        form.show();
        this.getView().add(form);

        const novaEmpresas = Ext.create('AppSamos.view.empresas.Model');

        form.setMasked({
            xtype: 'loadmask',
            message: 'Aguarde...'
        });
        
        Ext.Ajax.request({
            method: 'GET',
            url: localStorage.getItem('api')  + '/empresasbuscar',
            disableCaching: false,
            headers: {
                'Authorization': 'Bearer ' + localStorage.getItem('token')
            },
            params: {
                parametros: 'ULTIMAEMPRESA|0|0',
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
                
                novaEmpresas.set(objList.results[0]);

                form.getViewModel().set({
                    'model'        : novaEmpresas,
                    'modelOriginal': {},
                    'readOnly'     : false
                });

                form.setMasked(false);
            }
        });
    },

    onSairClick: function(btn, e){
        this.getViewModel().getStore('empresas').removeAll();
        this.redirectTo('homeview');
        this.getView().destroy();
    },

    onKeyDownPesquisar: function(txt, event) {
        if(event.keyCode == 13) {
            this.onBuscarClick();
        }
    }
    
});