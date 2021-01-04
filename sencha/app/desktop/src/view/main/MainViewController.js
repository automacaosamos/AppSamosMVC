Ext.define('AppSamos.view.main.MainViewController', {
	extend: 'Ext.app.ViewController',
	alias: 'controller.mainviewcontroller',

	routes: { 
		':xtype': {action: 'mainRoute'}
	},

	initViewModel: function(vm){
		setTimeout(() => {
			vm.getStore('menu').on({
				load: 'onMenuDataLoad',
				single: true,
				scope: this
			});
		}, 1000);
	},

	onMenuDataLoad: function(store){
		this.mainRoute(Ext.util.History.getHash());
	},

	mainRoute:function(xtype) {
		var navview = this.lookup('navview'),
			menuview = navview.lookup('menuview'),
			centerview = this.lookup('centerview'),
			exists = Ext.ClassManager.getByAlias('widget.' + xtype),
			node, vm;

		if (exists === undefined) {
			console.log(xtype + ' does not exist');
			return;
		}
		if(!menuview.getStore()) {
			console.log('Store not yet avalable from viewModel binding');
			return;
		}

		node = menuview.getStore().findNode('xtype', xtype);

		if (node == null) {
			console.log('unmatchedRoute: ' + xtype);
			return;
		}
		if (!centerview.getComponent(xtype)) {
			centerview.add({ xtype: xtype,  itemId: xtype, heading: node.get('text') });
		}

		centerview.setActiveItem(xtype);
		menuview.setSelection(node);
		vm = this.getViewModel(); 
		vm.set('LOGIN_NOME', sessionStorage.getItem('LOGIN_NOME'));
		vm.set('LOGIN_FANTASIA', sessionStorage.getItem('LOGIN_FANTASIA'));
	},

	onMenuViewSelectionChange: function (tree, node) {
		if (node == null) { return }

		var vm = this.getViewModel();

		if (node.get('xtype') != undefined) {
			this.redirectTo( node.get('xtype') );
		}
	},

	onBottomViewlogout: function () {
		localStorage.setItem("LoggedIn", false);
		this.getView().destroy();
		Ext.Viewport.add([{ xtype: 'loginview'}]);
	}

});
