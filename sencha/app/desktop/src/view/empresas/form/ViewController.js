Ext.define('AppSamos.view.empresas.form.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.empresasform',

    init: function(view) {
        Ext.asap(() => view.focus(true));
    },

    toLowerCase: function(txt, e){
        const value = txt.getValue();
        const newValue = (value || '').toLowerCase();
        setTimeout(() => txt.setValue(newValue), 200);
    },

    onIncluirClick: function(btn, e) {
        const modelAntigo  = this.getViewModel().get('model');
        const novaEmpresas = Ext.create('AppSamos.view.empresas.Model');
        this.getView().setMasked({
            xtype: 'loadmask',
            message: 'Aguarde...'
        });
        
        Ext.Ajax.request({
            method: 'GET',
            url: localStorage.getItem('api')  + '/empresasbuscar',
            disableCaching: false,
            headers: {
                Authorization: 'Bearer ' + localStorage.getItem('token')
            },
            params: {
                parametros: 'ULTIMAEMPRESAS|0|0',
                start     : 0,
                limit     : 1
            },
            failure: response => {
                setTimeout(() => {
//                    const dialog = Ext.Msg.alert('Mensagem', 'Não consegui trazer o ultimo código');
                    const dialog = Utils.Msg.alert('Mensagem', 'Não consegui trazer o ultimo código');
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
                this.lookup('cpfcnpj').focus();
                
            }

        });

    },

    onEditarClick: function(btn, e) {
        this.getViewModel().set('readOnly', false);
        this.lookup('cpfcnpj').focus();
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
           
            const txtInscricao = this.lookup('inscricao');
            const txtCpfCnpj   = this.lookup('cpfcnpj');
            const emAlteracao  = !this.getViewModel().get('model').phantom;
            const cpfCnpj      = txtCpfCnpj.getValue();

            if(!cpfCnpj) {
                const dialog = Utils.Msg.alert('Mensagem', 'Preencha o CPF/CNPJ');
//              const dialog = Ext.Msg.alert('Mensagem', 'Preencha o CPF/CNPJ');
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
                    Authorization: 'Bearer ' + localStorage.getItem('token')
                },
                failure: response => {
                    setTimeout(() => {
                        const dialog = Utils.Msg.alert('Mensagem', 'Não consegui checar o CPF/CNPJ');
//                        const dialog = Ext.Msg.alert('Mensagem', 'Não consegui checar o CPF/CNPJ');
                        Ext.defer(dialog.hide, 2000, dialog);
                        this.getView().setMasked(false);
                        txtCpfCnpj.focus(true);
                        resolve(false);
                    }, 1000);
                },
                success: response => {
                    const res = JSON.parse(response.responseText);
                    
                    if(res.status == false) {
                        const dialog = Utils.Msg.alert('Mensagem', res.message);
//                        const dialog = Ext.Msg.alert('Mensagem', res.message);
                        Ext.defer(dialog.hide, 2000, dialog);
                        txtCpfCnpj.focus(true);
                        resolve(false);
                    } else {
                        txtInscricao.focus(true);
                        resolve(true);
                    }

                    this.getView().setMasked(false);
                }
            });
        });
    },

    onValidaInscricao: function(txt, event) {
        return new Ext.Promise((resolve, reject) => {
            if(
                this.getViewModel().get('readOnly') ||
                event && (event.keyCode != 9 && event.keyCode != 13)
            ) { 
                resolve(false);
                return;
            }

            const txtInscricao  = this.lookup('inscricao');
            const inscricao     = txtInscricao.getValue();
            const estado        = this.getViewModel().get('model.CIDADES_ESTADO');

            if(!estado) {
                const dialog = Ext.Msg.alert('Mensagem', 'Preencha o Estado');
                Ext.defer(dialog.hide, 2000, dialog);
                resolve(false);
                return;
            }

            if(!inscricao) {
                const dialog = Utils.Msg.alert('Mensagem','Preencha a Inscricao');
//                const dialog = Ext.Msg.alert('Mensagem', 'Preencha a Inscricao');
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
                url: localStorage.getItem('api')  + `/utilsvalidar/INSCRICAO|${inscricao}|${estado}`,
                disableCaching: false,
                headers: {
                    Authorization: 'Bearer ' + localStorage.getItem('token')
                },
                failure: response => {
                    setTimeout(() => {
                        const dialog = Utils.Msg.alert('Mensagem','Não consegui checar a inscrição');
//                        const dialog = Ext.Msg.alert('Mensagem', 'Não consegui checar a inscrição');
                        Ext.defer(dialog.hide, 2000, dialog);
                        this.getView().setMasked(false);
                        txtInscricao.focus(true);
                        resolve(false);
                    }, 1000);
                },
                success: response => {
                    const res = JSON.parse(response.responseText);
                    
                    if(res.status == false) {
                        const dialog = Utils.Msg.alert('Mensagem',res.message);
//                        const dialog = Ext.Msg.alert('Mensagem', res.message);
                        Ext.defer(dialog.hide, 2000, dialog);
                        txtInscricao.focus(true);
                        resolve(false);
                    } else {
                        this.lookup('municipal').focus(true);
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
                    Authorization: 'Bearer ' + localStorage.getItem('token')
                },
                failure: response => {
                    setTimeout(() => {
                        const dialog = Utils.Msg.alert('Mensagem','Não consegui encontrar o CEP');
//                        const dialog = Ext.Msg.alert('Mensagem', 'Não consegui encontrar o CEP');
                        Ext.defer(dialog.hide, 2000, dialog);
                        this.getView().setMasked(false);
                        txtCep.focus(true);
                        resolve(false);
                    }, 1000);
                },
                success: response => {
                    const res = JSON.parse(response.responseText);
                    if(res.status == false) {
                        const dialog = Utils.Msg.alert('Mensagem',res.message);
//                        const dialog = Ext.Msg.alert('Mensagem', res.message);
                        Ext.defer(dialog.hide, 2000, dialog);
                        txtCep.focus(true);
                        resolve(false);
                    } else {
                        this.getViewModel().get('model').set({
                            'EMPRESAS_ENDERECO'  : res["ENDERECO"],
                            'EMPRESAS_BAIRRO'    : res["BAIRRO"],
                            'CIDADES_NOME'       : res["CIDADE"],
                            'CIDADES_ESTADO'     : res["ESTADO"],
                            'CIDADES_IBGE'       : res["IBGE"],
                            'EMPRESAS_ID_CIDADES': res["CODIGO"]
                        });
                        resolve(true);
                    }
                    this.getView().setMasked(false);
                    this.lookup('endereco').focus(true);
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

        const inscricaoValida = await this.onValidaInscricao();
        if(inscricaoValida == false) { return; }

        Utils.Msg.confirm('Quer realmente gravar ?', btn => {
            if(btn == 'yes') {
                this.getView().setMasked({
                    xtype: 'loadmask',
                    message: 'Aguarde...'
                });

                const proxy = model.getProxy();

                proxy.setUrl(localStorage.getItem('api') + '/empresas');
                proxy.setHeaders({
                    'Authorization' : 'Bearer ' + localStorage.getItem('token')
                });

                model.set({
                    'EMPRESAS_STATUS'         : this.lookup('status').getValue()         ? 'T' : 'F',
                    'EMPRESAS_ANALISACLIENTE' : this.lookup('analisacliente').getValue() ? 'T' : 'F',
                    'EMPRESAS_SIMPLES'        : this.lookup('simples').getValue()        ? 'T' : 'F',
                    'EMPRESAS_CAIXA'          : this.lookup('caixa').getValue()          ? 'T' : 'F',
                    'EMPRESAS_AUTENTICA'      : this.lookup('autentica').getValue()      ? 'T' : 'F'
                });

                if(isNaN(model.get('EMPRESAS_ID'))){
                    model.set('EMPRESAS_ID', '0');
                    model.phantom = true;
                }
                
                model.save({
                    success: (record, operation) => {
                        this.getViewModel().set('readOnly', true);
                        model.set('EMPRESAS_ID', record.get('EMPRESAS_ID'));
                        const dialog = Utils.Msg.alert('Mensagem', 'Gravado com sucesso', () => {
                            this.lookup('alterar').focus();
                        });

                        Ext.defer(dialog.hide, 2000, dialog);

                        const storeEmpresas = this.getView().up('empresaslist').getViewModel().getStore('empresas');

                        storeEmpresas.removeAll();
                        storeEmpresas.add(record);
                    },
                    failure: (record, operation) => {
                        const dialog = Utils.Msg.alert('Mensagem', operation.error.response.responseJson.msg);
//                        const dialog = Ext.Msg.alert('Mensagem', operation.error.response.responseJson.msg);
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
//        Ext.Msg.confirm('Confirmação', 'Quer realmente excluir ?', btn => {
            if(btn == 'yes') {

                this.getView().setMasked({
                    xtype: 'loadmask',
                    message: 'Aguarde...'
                });

                const proxy = model.getProxy();

                proxy.setUrl(localStorage.getItem('api') + '/empresas');
                proxy.setHeaders({
                    'Authorization' : 'Bearer ' + localStorage.getItem('token')
                });

                model.erase({
                    success: (record, operation) => {
                        const storeEmpresas = this.getView().up('empresaslist').getViewModel().getStore('empresas');
                       
                        this.getView().destroy();
                        const dialog = Utils.Msg.alert('Mensagem', 'Empresa excluída com sucesso');
//                        const dialog = Ext.Msg.alert('Mensagem', 'Congregação excluída com sucesso');
                        Ext.defer(dialog.hide, 2000, dialog);
                        storeEmpresas.currentPage = 1;
                        storeEmpresas.load();
                    },
                    failure: (record, operation) => {
                        this.getView().setMasked(false);
                        const dialog = Utils.Msg.alert('Mensagem', 'Erro ao excluir');
//                        const dialog = Ext.Msg.alert('Mensagem', 'Erro ao excluir');
                        Ext.defer(dialog.hide, 2000, dialog);
                    }
                });
            }
        });
    },

    buscarPortadores: function(){
        new Ext.Promise((resolve, reject) => {
            const search = Ext.create({
                xtype: 'portadoressearch',
                resolve: resolve
            });
            search.show();
            //this.getView().add(search);
        })
        .then(registro => {
            this.getViewModel().get('model').set({
                'EMPRESAS_ID_PORTADORES': registro.get('PORTADORES_ID'),
                'PORTADORES_NOME'       : registro.get('PORTADORES_NOME')
            });
        });
    }

});