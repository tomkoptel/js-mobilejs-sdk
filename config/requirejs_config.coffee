requirejs.config
  baseUrl: '../../build'
  optimize: 'none'
  logLevel: 0
  paths:
    #  Common components
    'js.mobile.logger': 'main/common/logger'
    'js.mobile.context': 'main/common/context'
    'js.mobile.session': 'main/common/session'
    'js.mobile.scaler': 'main/common/scaler'
    'js.mobile.dom_tree_observer': 'main/common/dom_tree_observer'
    'js.mobile.callback_dispatcher': 'main/common/callback_dispatcher'
    'js.mobile.lifecycle': 'main/common/lifecycle'
    'js.mobile.module': 'main/common/module'

    #  Common Android components
    'js.mobile.android.dashboard.callback': 'android/dashboard/callback'
    'js.mobile.android.logger': 'android/logger'

    # Common Ios components
    'js.mobile.ios.callbacks.WebKitCallback': 'ios/callbacks/WebKitCallback'
    'js.mobile.ios.callbacks.IosCallback': 'ios/callbacks/IosCallback'
    'js.mobile.ios.loggers.logger': 'ios/loggers/logger'
    'js.mobile.ios.loggers.WebKitLogger': 'ios/loggers/WebKitLogger'

    # Amber Dashboard components
    'js.mobile.amber.dashboard': 'main/amber/dashboard/dashboard'
    'js.mobile.amber.dashboard.controller': 'main/amber/dashboard/controller'

    # Amber2 Dashboard components
    'js.mobile.amber2.dashboard': 'main/amber2/dashboard/dashboard'
    'js.mobile.amber2.dashboard.controller': 'main/amber2/dashboard/controller'

    #  Report components
    'js.mobile.report': 'main/report/report'
    'js.mobile.report.controller': 'main/report/controller'

    # Legacy components
    'jquery': '../bower_components/jquery/dist/jquery.min'
  shim:
    'jquery': {'exports': 'jquery'}
