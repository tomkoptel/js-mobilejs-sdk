requirejs.config
  baseUrl: '../../build'
  optimize: 'none'
  logLevel: 0
  paths:
    'js.mobile.logger': 'main/logger'
    'js.mobile.context': 'main/context'
    'js.mobile.client': 'main/client'
    'js.mobile.callback.implementor': 'main/callback_implementor'
    'js.mobile.dashboard.wrapper': 'main/dashboard/dashboard_wrapper'
    'js.mobile.dashboard.window': 'main/dashboard/dashboard_window'
    'js.mobile.dashboard.controller': 'main/dashboard/dashboard_controller'
    'js.mobile.view': 'main/view/view'
    'fastclick': '../bower_components/fastclick/lib/fastclick'
  shim:
    'fastclick': {'exports': 'fastclick'}
