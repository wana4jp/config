// -----------
// definitions
// -----------
var superKey = ':alt,cmd,shift,ctrl';


// ---------
// functions
// ---------
var util = {
  eachAppWindow: function(f) {
    S.eachApp(function(app) {
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
    return k + superKey + (mod ? ',' + mod : '');
  },
  focusWindow: function(f) {
    var hit = false;
    S.eachApp(function(app) {
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
    return S.screenForRef(String( (screen.id()+1)%S.screenCount() ));
  }
};



// --------
// bindings
// --------
S.bind(util.key('space'), S.operation('focus', {
  direction: 'behind'
}));

S.bind(util.key('9'), function(win) {
  if (!win) return;
  var next = util.nextScreen(win.screen());
  win.move(next.visibleRect());
});

S.bind(util.key('j'), S.operation('chain', {
  operations: _.map(['top-right', 'bottom-right', 'bottom-left', 'top-left'], function(d) {
    return S.operation('corner', {
      direction: d,
      width: 'screenSizeX/2',
      height: 'screenSizeY/2'
    });
  })
}));

S.bind(util.key('k'), function(win) {
  if (!win) return;
  var bounds = win.screen().visibleRect();
  win.doOperation('move', bounds);
});

S.bind(util.key('l'), S.operation('push', {
  direction: 'left',
  style: 'bar-resize:screenSizeX/2'
}));

S.bind(util.key('h'), S.operation('push', {
  direction: 'right',
  style: 'bar-resize:screenSizeX/2'
}));

S.bind(util.key('h'), S.operation('focus', { direction: 'left' }));
S.bind(util.key('j'), S.operation('focus', { direction: 'down' }));
S.bind(util.key('k'), S.operation('focus', { direction: 'up' }));
S.bind(util.key('l'), S.operation('focus', { direction: 'right' }));
