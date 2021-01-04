Ext.define('AppSamos.view.main.header.HeaderView', {
    extend: 'Ext.Toolbar',
    xtype: 'headerview',
    cls: 'headerview',
    viewModel: {},
    items: [
        { 
            xtype: 'container',
            cls: 'headerviewtext',
            bind: { html: '{LOGIN_NOME}' }
        },
        '->',
        {
            xtype: 'container',
            cls: 'headerviewtext',
            bind: { html: '{LOGIN_FANTASIA}' }
        }
    ]
});
