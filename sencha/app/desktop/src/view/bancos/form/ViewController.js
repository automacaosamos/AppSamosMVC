Ext.define('AppSamos.view.bancos.form.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.bancosform',

    init: function(view) {
        Ext.asap(() => view.focus());
    },

    toLowerCase: function(txt, e){
        const value = txt.getValue();
        const newValue = (value || '').toLowerCase();

        setTimeout(() => txt.setValue(newValue), 200);
    },

    onIncluirClick: function(btn, e) {
        const modelAntigo  = this.getViewModel().get('model');
        const novaEmpresas = Ext.create('AppSamos.view.bancos.Model');

        this.getView().setMasked({
            xtype: 'loadmask',
            message: 'Aguarde...'
        });
        
        Ext.Ajax.request({
            method: 'GET',
            url: localStorage.getItem('api')  + '/bancosbuscar',
            disableCaching: false,
            params: {
                parametros: 'ULTIMABANCOS|0|0',
                start     : 0,
                limit     : 1
            },
            failure: response => {
                setTimeout(() => {
                    const dialog = Ext.Msg.alert('Mensagem', 'Não consegui trazer o ultimo código');
                    Ext.defer(dialog.hide, 2000, dialog);
                    this.getView().setMasked(false);
                }, 1000);
            },
            success: response => {
                const objList = JSON.parse(response.responseText);
                
                novaEmpresas.set(objList.results[0]);

                this.getView().getViewModel().set({
                    'model'         : novaEmpresas,
                    'modelOriginal' : Object.assign({}, modelAntigo.data),
                    'readOnly'      : false
                });

                this.getView().setMasked(false);
            }
        });
    },

    onEditarClick: function(btn, e) {
        this.getViewModel().set('readOnly', false);
    },

    onCancelaClick: function(btn, e) {
        const viewModel = this.getViewModel();
        const model = viewModel.get('model');
        const modelOriginal = viewModel.get('modelOriginal');

        if(Object.keys(modelOriginal).length > 0) {
            model.set(modelOriginal);
            viewModel.set('readOnly', true);
        } else {
            this.getView().destroy();
        }
    },

    onGravarClick: async function(btn, e) {
        const model = this.getViewModel().get('model');
        const valido = this.validarModel(model);
        
        if(valido === false) { return; }
        Utils.Msg.confirm('Quer realmente gravar ?', btn => {
            if(btn == 'yes') {
                this.getView().setMasked({
                    xtype: 'loadmask',
                    message: 'Aguarde...'
                });

                const proxy = model.getProxy();

                proxy.setUrl(localStorage.getItem('api') + '/bancos');
                proxy.setHeaders({
                    'Authorization' : 'Bearer ' + localStorage.getItem('token')
                });

                model.set({
                    'BANCOS_STATUS'         : this.lookup('status').getValue()         ? 'T' : 'F'
                });

                if(isNaN(model.get('BANCOS_ID'))){
                    model.set('BANCOS_ID', '0');
                    model.phantom = true;
                }
                
                model.save({
                    success: (record, operation) => {
                        this.getViewModel().set('readOnly', true);
                        model.set('BANCOS_ID', record.get('BANCOS_ID'));

                        const dialog = Ext.Msg.alert('Mensagem', 'Gravado com sucesso');
                        Ext.defer(dialog.hide, 2000, dialog);

                        const storeEmpresas = this.getView().up('bancoslist').getViewModel().getStore('bancos');

                        storeEmpresas.removeAll();
                        storeEmpresas.add(record);
                    },
                    failure: (record, operation) => {
                        const dialog = Ext.Msg.alert('Mensagem', operation.error.response.responseJson.msg);
                        Ext.defer(dialog.hide, 2000, dialog);
                    },
                    callback: (record, operation, success) => {
                        this.getView().setMasked(false);
                    }
                });
            }
        });
    },

    validarModel: function(model) {
        const validacao = model.getValidation(true);
        const fields = this.getView().query('field');

        if (validacao.dirty) {
            for (let i in validacao.data) {
                if (validacao.data[i] != true) {
                    for (let j in fields) {
                        console.log(fields[j]);
                        if ((fields[j].$bindings && fields[j].$bindings.value ? fields[j].$bindings.value.stub.name : fields[j].name) == i) {
                            const fieldName = fields[j].getLabel();
                            
                            if (fields[j].isVisible(true)) {
                                Ext.Msg.show({
                                    title: 'Validação',
                                    message: (fieldName ? fieldName + ': ' : '') + validacao.data[i],
                                    buttons: Ext.MessageBox.OK,
                                    fn: btn => {
                                        if(btn == 'ok') {
                                            Ext.asap(() => fields[j].focus(true));
                                        }
                                    }
                                })

                                return false;
                            }
                        }
                    }
                }
            }
        }
    },

    onExcluirClick: function(btn, e) {
        const model = this.getViewModel().get('model');
        Utils.Msg.confirm('Quer realmente excluir ?', btn => {
            if(btn == 'yes') {

                this.getView().setMasked({
                    xtype: 'loadmask',
                    message: 'Aguarde...'
                });

                const proxy = model.getProxy();

                proxy.setUrl(localStorage.getItem('api') + '/bancos');
                proxy.setHeaders({
                    'Authorization' : 'Bearer ' + localStorage.getItem('token')
                });

                model.erase({
                    success: (record, operation) => {
                        const storeEmpresas = this.getView().up('bancoslist').getViewModel().getStore('bancos');
                       
                        this.getView().destroy();
                        const dialog = Ext.Msg.alert('Mensagem', 'Bancos excluída com sucesso');
                        Ext.defer(dialog.hide, 2000, dialog);
                        storeEmpresas.currentPage = 1;
                        storeEmpresas.load();
                    },
                    failure: (record, operation) => {
                        this.getView().setMasked(false);
                        const dialog = Ext.Msg.alert('Mensagem', 'Erro ao excluir');
                        Ext.defer(dialog.hide, 2000, dialog);
                    }
                });
            }
        });
    }
});