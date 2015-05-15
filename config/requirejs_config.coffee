requirejs.config
  baseUrl: '../../build'
  optimize: 'none'
  logLevel: 0
  paths:
    #  Common components
    'js.mobile.session': 'main/common/session'
    'js.mobile.dom_tree_observer': 'main/common/dom_tree_observer'
    'js.mobile.callback_dispatcher': 'main/common/callback_dispatcher'
    'js.mobile.lifecycle': 'main/common/lifecycle'
    'js.mobile.module': 'main/common/module'
    'js.mobile.debug_log': 'main/common/debug_log'
    'js.mobile.release_log': 'main/common/release_log'
    
    'js.mobile.scale.calculator': 'main/common/scale_calculator'
    'js.mobile.scale.manager': 'main/common/scale_manager'
    'js.mobile.scale.style.dashboard': 'main/common/scale_style_dashboard'
    'js.mobile.scale.style.report': 'main/common/scale_style_report'

    #  Common Android components
    'js.mobile.android.dashboard.callback': 'android/dashboard/callback'

    # Amber Dashboard components
    'js.mobile.amber.dashboard': 'main/dashboard/amber/dashboard'
    'js.mobile.amber.dashboard.controller': 'main/dashboard/amber/controller'

    # Amber2 Dashboard components
    'js.mobile.amber2.dashboard': 'main/dashboard/amber2/dashboard'
    'js.mobile.amber2.dashboard.controller': 'main/dashboard/amber2/controller'

    #  Report components
    'js.mobile.report': 'main/report/report'
    'js.mobile.report.controller': 'main/report/controller'

    # Legacy components
    'jquery': '../bower_components/jquery/dist/jquery.min'
  shim:
    'jquery': {'exports': 'jquery'}
