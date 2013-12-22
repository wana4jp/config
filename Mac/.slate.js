// ---------
// functions
// ---------
var util = {
	eachAppWindow: function(f) {
		slate.eachApp(function(app) {
			app.eachWindow(f);
		});
	},
	clamp: function(rect, bounds) {
		if (rect.x < bounds.x)
			rect.x = bounds.x;
		if (rect.y < bounds.y)
			rect.y = bounds.y;
		if (rect.x + rect.width > bounds.x + bounds.width)
			rect.width = bounds.x + bounds.width - rect.x;
		if (rect.y + rect.height > bounds.y + bounds.height)
			rect.height = bounds.y + bounds.height - rect.y;
	},
	key: function(k, mod) {
		return k + ':alt' + (mod ? ',' + mod : '');
	},
	focusWindow: function(f) {
		var hit = false;
		slate.eachApp(function(app) {
		if (hit) return;
			app.eachWindow(function(win) {
				if (hit) return;
				if (f(win)) {
					win.focus();
					hit = true;
				}
			});
		});
	},
	nextScreen: function(screen) {
		return slate.screenForRef(String( (screen.id()+1)%slate.screenCount() ));
	}
};



// --------
// bindings
// --------
slate.bind(util.key('space'), slate.operation('focus', { direction: 'behind' }));

slate.bind(util.key('9'), function(win) {
	if (!win) return;
	var next = util.nextScreen(win.screen());
	win.move(next.visibleRect());
});

slate.bind(util.key('down'), slate.operation('chain', {
	operations: _.map(['top-right', 'bottom-right', 'bottom-left', 'top-left'], function(d) {
		return slate.operation('corner', {
			direction: d,
			width: 'screenSizeX/2',
			height: 'screenSizeY/2'
		});
	})
}));

slate.bind(util.key('up'), function(win) {
	if (!win) return;
	var bounds = win.screen().visibleRect();
	win.doOperation('move', bounds);
});

slate.bind(util.key('left'), slate.operation('push', {
	direction: 'left',
	style: 'bar-resize:screenSizeX/2'
}));

slate.bind(util.key('right'), slate.operation('push', {
	direction: 'right',
	style: 'bar-resize:screenSizeX/2'
}));

