Ext.define('AppSamos.Application', {
	extend: 'Ext.app.Application',
	name: 'AppSamos',
	requires: ['AppSamos.*'],

	defaultToken: 'homeview',

	removeSplash: function () {
		Ext.getBody().removeCls('launching')
		var elem = document.getElementById("splash")
		elem.parentNode.removeChild(elem)
	},

	launch: function () {
		Ext.Ajax.request({
            method: 'GET',
            disableCaching: false,
            url: 'config.json',
            success: response => {
				const configObj = JSON.parse(response.responseText);

                localStorage.setItem('api', configObj['api']);
            }
		});

  		this.redirectTo('login');
		
		this.removeSplash();
		Ext.Viewport.add({xtype: 'login'});
	},

	onAppUpdate: function () {
		Ext.Msg.confirm('Application Update', 'Esta aplicação foi atualizada, recarrega ? ',
			function (choice) {
				if (choice === 'yes') {
					window.location.reload();
				}
			}
		);
	}
});
