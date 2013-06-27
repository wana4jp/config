// 参考 https://gist.github.com/tcptr/f77ca0b20f946b64f9fb

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
	// altキーを起点にする
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

// hjkl .. その方向へフォーカス移動
slate.bind(util.key('h'), slate.operation('focus', { direction: 'left' }));
slate.bind(util.key('j'), slate.operation('focus', { direction: 'down' }));
slate.bind(util.key('k'), slate.operation('focus', { direction: 'up' }));
slate.bind(util.key('l'), slate.operation('focus', { direction: 'right' }));

// tab .. 下に隠れているウィンドウをフォーカス
slate.bind(util.key('tab'), slate.operation('focus', { direction: 'behind' }));

// o .. スクリーン間でフォーカスを移動
slate.bind(util.key('o'), function(win) {
	var next = util.nextScreen(slate.screen());
	util.focusWindow(function(win) {
		return win.screen().id() == next.id() &&
		VirtualDesktop.isCurrent(win);
	});
});

// o+shift .. 別のスクリーンへ飛ばす
slate.bind(util.key('space'), function(win) {
	if (!win) return;
	var next = util.nextScreen(win.screen());

	win.move(next.visibleRect());
});

// j+shift .. 4隅に飛ばす
/*
var corners = slate.bind(util.key('j', 'shift'), slate.operation('chain', {
	operations: _.map(['top-right', 'bottom-right', 'bottom-left', 'top-left'], function(d) {
		return slate.operation('corner', {
			direction: d,
			width: 'screenSizeX/2',
			height: 'screenSizeY/2'
		});
	})
}));
*/

// k+shift .. 左右に飛ばす
/*
slate.bind(util.key('k', 'shift'), slate.operation('chain', {
	operations: _.map(['left', 'right'], function(d) {
		return slate.operation('push', {
		direction: d,
		style: 'bar-resize:screenSizeX/2'
		});
	})
}));
*/

// ↑ .. 全画面で最大化
slate.bind(util.key('up'), function(win) {
	if (!win) return;
	var bounds = win.screen().visibleRect();
	win.doOperation('move', bounds);
});


// ---- 追加した設定 ----

//  ←.. 左へ最大化
slate.bind(util.key('left'), slate.operation('push', {
	direction: 'left',
	style: 'bar-resize:screenSizeX/2'
}));

// → .. 右へ最大化
slate.bind(util.key('right'), slate.operation('push', {
	direction: 'right',
	style: 'bar-resize:screenSizeX/2'
}));

