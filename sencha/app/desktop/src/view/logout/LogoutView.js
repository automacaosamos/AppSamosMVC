Ext.define('AppSamos.view.logout.LogoutView',{
	xtype: 'logoutview',
	cls: 'logoutview',
	controller: {type: 'logoutviewcontroller'},
	viewModel: {type: 'logoutviewmodel'},
	requires: [],
	extend: 'Ext.Container',
  scrollable: true,
  html: `<div style="user-select: text !important;">Obrigado por usar o sistema</div>`
});
