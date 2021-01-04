Ext.define('AppSamos.view.usuarios.form.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.usuariosform',

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
        const novaUsuarios = Ext.create('AppSamos.view.usuarios.Model');

        this.getView().setMasked({
            xtype: 'loadmask',
            message: 'Aguarde...'
        });
        
        Ext.Ajax.request({
            method: 'GET',
            url: localStorage.getItem('api')  + '/usuariosbuscar',
            disableCaching: false,
            params: {
                parametros: 'ULTIMOUSUARIOS|0|0',
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
                novaUsuarios.set(objList.results[0]);
                this.getView().getViewModel().set({
                    'model'         : novaUsuarios,
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

    onValidaCpfCnpj: function(txt, event) {
        return new Ext.Promise((resolve, reject) => {
            if(
                this.getViewModel().get('readOnly') ||
                event && (event.keyCode != 9 && event.keyCode != 13)
            ) { 
                resolve(false);
                return;
            }
            const txtCpfCnpj  = this.lookup('cpfcnpj');
            const emAlteracao = !this.getViewModel().get('model').phantom;
            const cpfCnpj     = txtCpfCnpj.getValue();

            if(!cpfCnpj) {
                const dialog = Ext.Msg.alert('Mensagem', 'Preencha o CPF/CNPJ');
                Ext.defer(dialog.hide, 2000, dialog);
                resolve(false);
                return;
            }

            this.getView().setMasked({
                xtype: 'loadmask',
                message: 'Aguarde...'
            });
            
            Ext.Ajax.request({
                method: 'GET',
                url: localStorage.getItem('api')  + `/utilsvalidar/CPFCNPJ|${cpfCnpj}|${emAlteracao ? 'F' : 'T'}|EMPRESAS`,
                disableCaching: false,
                headers: {
                    'Authorization' : 'Bearer ' + localStorage.getItem('token')
                },
                failure: response => {
                    setTimeout(() => {
                        const dialog = Ext.Msg.alert('Mensagem', 'Não consegui checar o CPF/CNPJ');
                        Ext.defer(dialog.hide, 2000, dialog);
                        this.getView().setMasked(false);
                        txtCpfCnpj.focus(true);
                        resolve(false);
                    }, 1000);
                },
                success: response => {
                    const res = JSON.parse(response.responseText);
                    if(res.status == false) {
                        const dialog = Ext.Msg.alert('Mensagem', res.message);
                        Ext.defer(dialog.hide, 2000, dialog);
                        txtCpfCnpj.focus(true);
                        resolve(false);
                    } else {
                        this.lookup('rg').focus(true);
                        resolve(true);
                    }

                    this.getView().setMasked(false);
                }
            });
        });
    },

    
    onSearchCeps: function(txt, event) {
        return new Ext.Promise((resolve, reject) => {
            if(
                this.getViewModel().get('readOnly')
            ) { return; }

            if(event && (event.keyCode != 9 && event.keyCode != 13)) {
                return;
            }
            const txtCep = this.lookup('cep');
            const cep    = txtCep.getValue();
            this.getView().setMasked({
                xtype: 'loadmask',
                message: 'Aguarde...'
            });
            Ext.Ajax.request({
                method: 'GET',
                url: localStorage.getItem('api')  + `/utilsbuscarcep/${cep}`,
                disableCaching: false,
                headers: {
                    'Authorization' : 'Bearer ' + localStorage.getItem('token')
                },
                failure: response => {
                    setTimeout(() => {
                        const dialog = Ext.Msg.alert('Mensagem', 'Não consegui encontrar o CEP');
                        Ext.defer(dialog.hide, 2000, dialog);
                        this.getView().setMasked(false);
                        txtCep.focus(true);
                        resolve(false);
                    }, 1000);
                },
                success: response => {
                    const res = JSON.parse(response.responseText);
                    
                    if(res.status == false) {
                        const dialog = Ext.Msg.alert('Mensagem', res.message);
                        Ext.defer(dialog.hide, 2000, dialog);
                        txtCep.focus(true);
                        resolve(false);
                    } else {
                        this.getViewModel().get('model').set({
                            'USUARIOS_ENDERECO'  : res["ENDERECO"],
                            'USUARIOS_BAIRRO'    : res["BAIRRO"],
                            'CIDADES_NOME'       : res["CIDADE"],
                            'CIDADES_ESTADO'     : res["ESTADO"],
                            'CIDADES_IBGE'       : res["IBGE"],
                            'USUARIOS_ID_CIDADES': res["CODIGO"]
                        });
                        this.lookup('endereco').focus(true);
                        resolve(true);
                    }
                    this.getView().setMasked(false);
                }
            });
        });
    },

    onGravarClick: async function(btn, e) {
        const model = this.getViewModel().get('model');
        const valido = this.validarModel(model);
        
        if(valido === false) { return; }

        const cpfCnpjValido = await this.onValidaCpfCnpj();
        if(cpfCnpjValido == false) { return; }

        Ext.Msg.confirm('Confirmação', 'Quer realmente gravar ?', btn => {
            if(btn == 'yes') {
                this.getView().setMasked({
                    xtype: 'loadmask',
                    message: 'Aguarde...'
                });

                const proxy = model.getProxy();

                proxy.setUrl(localStorage.getItem('api') + '/usuarios');
                proxy.setHeaders({
                    'Authorization' : 'Bearer ' + localStorage.getItem('token')
                });

                model.set({
                    'USUARIOS_STATUS'         : this.lookup('status').getValue()         ? 'T' : 'F'
                });

                if(isNaN(model.get('USUARIOS_ID'))){
                    model.set('USUARIOS_ID', '0');
                    model.phantom = true;
                }
                
                model.save({
                    success: (record, operation) => {
                        this.getViewModel().set('readOnly', true);
                        model.set('USUARIOS_ID', record.get('USUARIOS_ID'));
                        const dialog = Ext.Msg.alert('Mensagem', 'Gravado com sucesso');
                        Ext.defer(dialog.hide, 2000, dialog);
                        const storeUsuarios = this.getView().up('usuarioslist').getViewModel().getStore('usuarios');
                        storeUsuarios.removeAll();
                        storeUsuarios.add(record);
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

        Ext.Msg.confirm('Confirmação', 'Quer realmente excluir ?', btn => {
            if(btn == 'yes') {

                this.getView().setMasked({
                    xtype: 'loadmask',
                    message: 'Aguarde...'
                });

                const proxy = model.getProxy();

                proxy.setUrl(localStorage.getItem('api') + '/usuarios');
                proxy.setHeaders({
                    'Authorization' : 'Bearer ' + localStorage.getItem('token')
                });

                model.erase({
                    success: (record, operation) => {
                        const storeUsuarios = this.getView().up('usuarioslist').getViewModel().getStore('usuarios');
                        this.getView().destroy();
                        const dialog = Ext.Msg.alert('Mensagem', 'Usuários excluído com sucesso');
                        Ext.defer(dialog.hide, 2000, dialog);
                        storeUsuarios.currentPage = 1;
                        storeUsuarios.load();
                    },
                    failure: (record, operation) => {
                        this.getView().setMasked(false);
                        const dialog = Ext.Msg.alert('Mensagem', 'Erro ao excluir');
                        Ext.defer(dialog.hide, 2000, dialog);
                    }
                });
            }
        });
    },
    buscarEmpresas: function(){
        new Ext.Promise((resolve, reject) => {
            const search = Ext.create({
                xtype: 'empresassearch',
                resolve: resolve
            });
            search.show();
            //this.getView().add(search);
        })
        .then(registro => {
            this.getViewModel().get('model').set({
                'USUARIOS_ID_EMPRESAS': registro.get('EMPRESAS_ID'),
                'EMPRESAS_NOME'       : registro.get('EMPRESAS_NOME')
            });
        });
    }
});