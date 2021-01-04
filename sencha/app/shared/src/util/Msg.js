//para uso no modern no lugar de Ext.Msg que trava muito
Ext.define('AppSamos.util.Msg', {
    singleton: true,
    alternateClassName: ['Utils.Msg'],
    /**
     * 
     * @param {Object} options 
     * title   {String}
     * message {String}
     * fn      {Function} fn(btnId)
     * buttons {object}   { itemId, text, cls}
     */
    dialog: function (options = {}) {
        const dialog = Ext.create({
            xtype  : 'dialog',
            title  : options.title   || 'Mensagem',
            html   : options.message || 'Mensagem',
            buttons: (options.buttons || []).reduce((obj, btn) => {
                obj[btn.itemId] = {
                    text: btn.text,
                    cls: 'primary-button',
                    handler: () => {
                        dialog.destroy();
                        if(options.fn) {
                            options.fn(btn.itemId);
                        }
                    }
                }
                return obj;
            }, {})
        });
       
        dialog.show();
    
        return dialog;
    },

    /**
     * 
     * @param {String}   message 
     * @param {Function} fn(btnId)
     */

    confirm: function (message = 'Deseja continuar?', fn) {
        const dialog = Ext.create({
            xtype: 'dialog',
            title: 'Confirmação',
            html: message,
            buttons: {
                yes: {
                    text: 'Sim',
                    margin: '0 5 0 0',
                    cls: 'primary-button',
                    handler: () => {
                        dialog.destroy();
                        if(fn){
                            fn('yes');
                        }
                    }
                },
                no: {
                    text: 'Não',
                    margin: '0 5 0 0',
                    cls: 'danger-button',
                    handler: () => {
                        dialog.destroy();
                        if(fn) {
                            fn('no');
                        }
                    }
                }
            }
        });
       
        dialog.show();
    
        return dialog;
    },

    /**
     * 
     * @param {Object} options 
     * title        {String}
     * message      {String}
     * initialValue {String}
     * fn           {Function} fn(btnId)
     * field        {object}   textfield properties
     */
    prompt: function(options = {}) {
        const dialog = Ext.create({
            xtype  : 'dialog',
            title  : options.title || 'Mensagem',
            items: [
                {
                    xtype: 'component',
                    reference: 'message',
                    html: options.mensagem || 'Mensagem',
                    flex: 1
                },
                Object.assign((options.field || {}), {
                    xtype: 'textfield',
                    value: options.initialValue || ''
                })
            ],
            buttons: {
                ok: {
                    text: 'OK',
                    cls: 'primary-button',
                    handler: () => {
                        if(options.fn){
                            options.fn('ok', dialog.down('textfield').getValue());
                        }
                        dialog.destroy();
                    }
                },
                cancelar: {
                    text: 'Cancelar',
                    cls: 'danger-button',
                    handler: () => {
                        if(options.fn){
                            options.fn('cancelar', dialog.down('textfield').getValue());
                        }
                        dialog.destroy();
                    }
                }
            }
        });
        
        dialog.show();

        dialog.down('textfield').focus(true);

        setTimeout(() => {
            if(Ext.os.is.Android){
                dialog.setY(10);
            }
        }, 100);

        return dialog;
    },

    /**
     * 
     * @param {String}   type 
     * @param {String}   message 
     * @param {Function} fn
     */
    alert: function (title = 'Mensagem', message, fn) {
        const dialog = Ext.create({
            xtype  : 'dialog',
            width  : 50,
            title  : title,
            html   : message || title,
            buttons: {
                ok: {
                    text: 'OK',
                    cls: 'primary-button',
                    handler: () => {
                        dialog.destroy();
                        if(fn) {
                            fn();
                        }
                    }
                }
            }
        });
       
        dialog.show();

        return dialog;
    }
});