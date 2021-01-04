Ext.define('AppSamos.view.main.MainViewModel', {
	extend: 'Ext.app.ViewModel',
	alias: 'viewmodel.mainviewmodel',
	data: {
		name: 'Sencha/DMVC',
		navCollapsed:       false,
		navview_max_width:    200,
		navview_min_width:     44,
		topview_height:        75,
		bottomview_height:     50,
		headerview_height:     50,
		footerview_height:     50,
		detailCollapsed:     true,
		detailview_width:      10,
		detailview_max_width: 200,
		detailview_min_width:   0,
		dataMenu:               {}
	},
	formulas: {
		navview_width: function(get) {
			return get('navCollapsed') ? get('navview_min_width') : get('navview_max_width');
		},
		detailview_width: function(get) {
			return get('detailCollapsed') ? get('detailview_min_width') : get('detailview_max_width');
		}
	},
	stores: {
		menu: {
			type: "tree",
			autoLoad: true,
			data: '{dataMenu}',
			proxy: {
				type: 'memory'
			}
		}
	}
});
