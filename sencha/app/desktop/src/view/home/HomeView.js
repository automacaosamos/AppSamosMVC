Ext.define('AppSamos.view.home.HomeView',{
	xtype: 'homeview',
	cls: 'homeview',
	controller: {type: 'homeviewcontroller'},
	viewModel: {type: 'homeviewmodel'},
	requires: [],
	extend: 'Ext.Container',
  	scrollable: true,
  	//html: `<div style="user-select: text !important;">Welcome to the Ext JS 7.2 Modern Desktop Template Application!
	//	</div>`,

	html: `<div style="
		background-image: url(resources/desktop/imagens/sencha.png);
		background-repeat: no-repeat;
		background-size: contain;
		background-position: center;
		height:364px;
		margin-top: 100px;
	">
		<img>
	</div>`
});