module.exports = (grunt) ->
  path = require("path")
  properties = grunt.file.readJSON('common_properties.json')

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-karma'
  initConfigs =
    pkg: grunt.file.readJSON('package.json')

    coffee:
      compileJoined:
        options: join: true
      dev:
        expand: true
        cwd: 'src'
        src: [ '**/*.coffee' ]
        dest: 'build'
        ext: '.js'
      config:
        expand: true
        cwd: 'config'
        src: [ '**/*.coffee' ]
        dest: 'build/config'
        ext: '.js'

    karma:
      unit:
        options:
          frameworks: ['jasmine', 'requirejs']
          singleRun: true
          browsers: ['PhantomJS']
          files: [
            {
              'pattern': 'test/spec/*.js'
              'included': false
            }
            {
              'pattern': 'build/main/*.js'
              'included': true
            }
            {
              'pattern': 'build/android/*.js'
              'included': true
            }
            "test/test.config.js"
          ]
          exclude: [
            'build/**/*main.js'
            'test/stub/*'
          ]
      android_dashboard_script:
        options:
          frameworks: ['jasmine', 'requirejs']
          singleRun: true
          browsers: ['PhantomJS']
          files: [
            'test/stub/android.js'
            'bower_components/jquery/dist/jquery.min.js'
            "build/#{properties.outputs.dashboard.android}"
            "test/android.config.js"
          ]

    requirejs:

      ios_amber_dashboard_script:
        options:
          mainConfigFile: 'build/config/requirejs_config.js'
          out: "build/lib/#{properties.outputs.dashboard.ios_amber}"
          include: ['ios/amber/dashboard/main.js']
          paths:
            'js.mobile.amber.ios.dashboard.client': 'ios/amber/dashboard/client'
            'js.mobile.ios.viewport.dashboard.amber' : 'ios/viewport/amber/viewport'

      ios_amber2_dashboard_script:
        options:
          mainConfigFile: 'build/config/requirejs_config.js'
          out: "build/lib/#{properties.outputs.dashboard.ios_amber2}"
          include: ['ios/amber2/dashboard/main.js']
          paths:
            'js.mobile.amber2.ios.dashboard.client': 'ios/amber2/dashboard/client'

      ios_report_script:
        options:
          mainConfigFile: 'build/config/requirejs_config.js'
          out: "build/lib/#{properties.outputs.report.ios}"
          include: ['ios/report/main.js']
          paths:
            'js.mobile.ios.report.client': 'ios/report/client'
            'js.mobile.ios.report.callback': 'ios/report/callback'

      android_amber2_dashboard_script:
        options:
          mainConfigFile: 'build/config/requirejs_config.js'
          out: "build/lib/#{properties.outputs.dashboard.android_amber2}"
          include: ['android/amber2/dashboard/main.js']
          paths:
            'js.mobile.amber2.android.dashboard.client': 'android/amber2/dashboard/client'

      android_amber_dashboard_script:
        options:
          mainConfigFile: 'build/config/requirejs_config.js'
          out: "build/lib/#{properties.outputs.dashboard.android_amber}"
          include: ['android/amber/dashboard/main.js']
          paths:
            'js.mobile.amber.android.dashboard.client': 'android/amber/dashboard/client'
            'js.mobile.android.viewport.dashboard.amber' : 'android/viewport/amber/viewport'

      android_report_script:
        options:
          mainConfigFile: 'build/config/requirejs_config.js'
          out: "build/lib/#{properties.outputs.report.android}"
          include: ['android/report/main.js']
          paths:
            'js.mobile.android.report.client': 'android/report/client'
            'js.mobile.android.report.callback': 'android/report/callback'

    watch:
      android:
        files: ['config/*.coffee', 'src/**/*.coffee', 'spec/**/*.coffee']
        tasks: ['build:android:debug', 'build:move']
      ios:
        files: ['config/*.coffee', 'src/**/*.coffee', 'spec/**/*.coffee']
        tasks: ['build:ios:debug', 'build:move']


  creatDebugConfig = (name) ->
    debugName = "#{name}_debug"
    debugConfig = JSON.parse(JSON.stringify(initConfigs['requirejs'][name]))

    defaultPath = debugConfig['options']['include'][0]
    basename = path.basename defaultPath
    debugPath = defaultPath.replace(basename, "debug_#{basename}")

    debugConfig['options']['include'] = [debugPath]
    initConfigs['requirejs'][debugName] = debugConfig

  creatDebugConfig 'ios_amber2_dashboard_script'
  creatDebugConfig 'ios_amber_dashboard_script'
  creatDebugConfig 'ios_report_script'

  creatDebugConfig 'android_amber2_dashboard_script'
  creatDebugConfig 'android_amber_dashboard_script'
  creatDebugConfig 'android_report_script'

  grunt.initConfig initConfigs

  grunt.registerTask 'build:move', 'Copy result scripts to specified projects', (platform, dst) =>
    mobileTask = require('./build/config/task/grunt-mobile-move')
    mobileTask.call(@, grunt, platform, dst)

  grunt.registerTask 'requirejs:compile:android:release', [
    'requirejs:android_report_script',
    'requirejs:android_amber_dashboard_script',
    'requirejs:android_amber2_dashboard_script',
  ]
  grunt.registerTask 'requirejs:compile:android:debug', [
    'requirejs:android_report_script_debug',
    'requirejs:android_amber_dashboard_script_debug',
    'requirejs:android_amber2_dashboard_script_debug',
  ]
  grunt.registerTask 'requirejs:compile:ios:release', [
    'requirejs:ios_report_script',
    'requirejs:ios_amber_dashboard_script',
    'requirejs:ios_amber2_dashboard_script',
  ]
  grunt.registerTask 'requirejs:compile:ios:debug', [
    'requirejs:ios_report_script_debug',
    'requirejs:ios_amber_dashboard_script_debug',
    'requirejs:ios_amber2_dashboard_script_debug',
  ]
  grunt.registerTask 'coffee:all', ['coffee:dev', 'coffee:config']

  grunt.registerTask 'build:android:release', ['coffee:all', 'requirejs:compile:android:release']
  grunt.registerTask 'build:android:debug', ['coffee:all', 'requirejs:compile:android:debug']

  grunt.registerTask 'build:ios:release', ['coffee:all', 'requirejs:compile:ios:release']
  grunt.registerTask 'build:ios:debug', ['coffee:all', 'requirejs:compile:ios:debug']

  grunt.registerTask 'release:android', ['build:android:release', 'build:move']
  grunt.registerTask 'release:ios', ['build:ios:release', 'build:move']
