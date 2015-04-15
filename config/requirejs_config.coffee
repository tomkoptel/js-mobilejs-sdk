requirejs.config
  baseUrl: '../../build'
  optimize: 'none'
  logLevel: 0
  paths:
    #  Common components
    'js.mobile.logger': 'main/logger'
    'js.mobile.context': 'main/context'
    'js.mobile.session': 'main/session'
    'js.mobile.scaler': 'main/scaler'

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
    'js.mobile.amber.dashboard.view': 'main/amber/dashboard/view'
    'js.mobile.amber.dashboard.window': 'main/amber/dashboard/window'

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
