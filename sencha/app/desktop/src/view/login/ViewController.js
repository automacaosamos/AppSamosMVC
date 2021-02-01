Ext.define('AppSamos.view.login.ViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.login',
    
    init: function(view) {//chamada por padrão quando a view é instanciada
        Ext.asap(() => view.focus(true));
/*
        Ext.Ajax.request({
            method: 'GET',
            disableCaching: false,
            url: 'config.json',
            success: response => {
                configs.setConfig(JSON.parse(response.responseText));
            }
        });
*/        
    },

    sairApplicacao: function() {
        try {
            //Ext.ComponentQuery.query('mainview')[0].destroy();
        } catch(e){}
    },

    onLoginClick: function(btn, e){
        const txtUsuario = this.lookup('usuario');
        const txtSenha   = this.lookup('senha');

        const usuario  = txtUsuario.getValue();
        const senha    = txtSenha.getValue();
        const ipacesso = '127.0.0.1';

        if(!usuario){
            alert('Preencha o nome de usuário');
            txtUsuario.focus(true);
        } else if (!senha){
            alert('Preencha a senha');
            txtSenha.focus(true);
        } else {
            Ext.Viewport.setMasked({
                xtype: 'loadmask',
                message: 'Aguarde...'
            });

            Ext.Ajax.request({
                method: 'GET',
                url: localStorage.getItem('api').replace('/api', '') + `/login`,
                headers: {
                    Authorization: 'Basic ' + btoa(usuario + ':' + senha)
                },
                disableCaching: false,
                failure: response => {
                    Ext.Viewport.setMasked(false);

                    const dialog = Ext.Msg.alert('Mensagem', 'Usuário/Senha inválidos');

                    setTimeout(() => {
                        dialog.hide();
                        Ext.asap(() => this.getView().focus(true));
                    }, 1200);
                },
                success: response => {
                    const res = JSON.parse(response.responseText);
                    const token = res.token;
                    localStorage.setItem('token', token);
                    
                    Ext.Ajax.request({
                        method: 'POST',
                        url: localStorage.getItem('api') + `/utilslogin`,
                        headers: {
                            Authorization: 'Bearer ' + localStorage.getItem('token')
                        },
                        jsonData: {
                            usuario: usuario,
                            senha  : senha,
                            ipacesso : ipacesso
                        },
                        disableCaching: false,
                        failure: response => {
                            Ext.Viewport.setMasked(false);
        
                            const dialog = Ext.Msg.alert('Mensagem', 'Usuário/Senha inválidos');
        
                            setTimeout(() => {
                                dialog.hide();
                                Ext.asap(() => this.getView().focus(true));
                            }, 1200);
                        },
                        success: response => {
                            Ext.Viewport.setMasked(false);
        
                            const objList = JSON.parse(response.responseText);
        
                            if(objList.status == false) {
                                Ext.Viewport.setMasked(false);
        
                                const dialog = Ext.Msg.alert('Mensagem', objList.message);
        
                                setTimeout(() => {
                                    dialog.hide();
                                    Ext.asap(() => this.getView().focus(true));
                                }, 1200);
                            } else {
                                const {
                                    LOGIN_ID,
                                    LOGIN_VALIDADE,
                                    LOGIN_NOME,        
                                    LOGIN_PRIVILEGIADO,
                                    LOGIN_ID_EMPRESAS,
                                    LOGIN_TEMPO,
                                    LOGIN_FANTASIA,
                                    LOGIN_ID_LOGS,
                                    LOGIN_EMPRESAS
                                } = objList;
            
                                sessionStorage.setItem('LOGIN_ID',           LOGIN_ID);
                                sessionStorage.setItem('LOGIN_VALIDADE',     LOGIN_VALIDADE);
                                sessionStorage.setItem('LOGIN_NOME',         LOGIN_NOME);
                                sessionStorage.setItem('LOGIN_PRIVILEGIADO', LOGIN_PRIVILEGIADO);
                                sessionStorage.setItem('LOGIN_ID_EMPRESAS',  LOGIN_ID_EMPRESAS);
                                sessionStorage.setItem('LOGIN_FANTASIA',     LOGIN_FANTASIA);
                                sessionStorage.setItem('LOGIN_TEMPO',        LOGIN_TEMPO);
                                sessionStorage.setItem('LOGIN_ID_LOGS',      LOGIN_ID_LOGS);
                                sessionStorage.setItem('LOGIN_EMPRESAS',     LOGIN_EMPRESAS);
            
                                this.getViewModel().set({
                                    'unlogged'      : false,
                                    'dataPermissoes': LOGIN_EMPRESAS
                                });

                                const listempresas = this.lookup('listempresas');

                                const empresaPadrao = LOGIN_EMPRESAS.filter(permissao => {
                                    return permissao['PERMISSOES_ID_EMPRESAS'] == LOGIN_ID_EMPRESAS;
                                });

                                listempresas.setSelection(new Ext.data.Model(empresaPadrao[0]) || 0);
                            }
                        }
                    });
                }
            });
        }
    },

    onEntrarClick: function() {
        const listempresas = this.lookup('listempresas');
        const empresaSelecionada = listempresas.getSelection();

        sessionStorage.setItem('LOGIN_ID_EMPRESAS', empresaSelecionada.get('PERMISSOES_ID_EMPRESAS'));
        sessionStorage.setItem('LOGIN_FANTASIA',    empresaSelecionada.get('EMPRESAS_FANTASIA'));
                                
        this.getView().destroy();

        let mainview = Ext.ComponentQuery.query('mainview')[0];

        if(!mainview) {
            mainview = Ext.Viewport.add({
                xtype: 'mainview'
            });
        } else {
            Ext.ComponentQuery.query('centerview')[0].removeAll();
        }
        
        this.redirectTo('homeview');

        const permissoes = JSON.parse(empresaSelecionada.get('PERMISSOES_ITENS'));
        
        mainview.getViewModel().set({
            'dataMenu'       : permissoes,
            'LOGIN_NOME'     : sessionStorage.getItem('LOGIN_NOME'),
            'LOGIN_FANTASIA' : empresaSelecionada.get('EMPRESAS_FANTASIA')
        });

        Ext.asap(() => {
            const menustore = mainview.getViewModel().getStore('menu');
            menustore.setRootNode(permissoes);
        });
    },

    onSairClick: function(btn, e){
        Utils.Msg.confirm('Deseja realmente sair ?', btn => {
            if(btn == 'yes') {
                location.href = 'https://jw.org';
            }
        });
    },

    onKeyDownUsuario: function(txt, event) {
        if(event.keyCode == 13){
            this.lookup('senha').focus(true);
        }
    },

    onKeyDownSenha: function(txt, event) {
        if(event.keyCode == 13){
            this.onLoginClick();
        }
    }
});