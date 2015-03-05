(function() {
  var Android, root;
  Android = (function() {
    function Android() {}

    Android.onMaximize = function(title) {};

    Android.onMinimize = function() {};

    Android.onWrapperLoaded = function() {};

    Android.onDashletsLoaded = function() {};

    return Android;

  })();
  root = typeof window !== "undefined" && window !== null ? window : exports;
  return root.Android = Android;
}).call(this);
