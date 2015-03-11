module.exports = (grunt) ->
  properties = grunt.file.readJSON('common_properties.json')

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.initConfig
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
      android_dashboard_script:
        options:
          mainConfigFile: 'build/config/requirejs_config.js'
          out: "build/lib/#{properties.outputs.dashboard.android}"
          include: ['android/dashboard/main.js']
          paths:
            'js.mobile.android.dashboard.callback.implementor': 'android/dashboard/callback_implementor'
            'js.mobile.android.dashboard.client': 'android/dashboard/client'
            'js.mobile.android.logger': 'android/logger'

      legacy_dashboard_script:
          options:
            mainConfigFile: 'build/config/requirejs_config.js'
            out: "build/lib/#{properties.outputs.dashboard.legacy}"
            include: ['main/fastclick/main.js']

      android_report_script:
        options:
          mainConfigFile: 'build/config/requirejs_config.js'
          out: "build/lib/#{properties.outputs.report.android}"
          include: ['android/report/main.js']
          paths:
            'js.mobile.android.report.callback.implementor': 'android/report/callback_implementor'
            'js.mobile.android.report.client': 'android/report/client'
            'js.mobile.android.logger': 'android/logger'


    watch: all:
      files: ['config/*.coffee', 'src/**/*.coffee', 'spec/**/*.coffee']
      tasks: ['buildR', 'build:move']


  grunt.registerTask 'build:move', 'Copy result scripts to specified projects', (platform, dst) =>
    mobileTask = require('./build/config/task/grunt-mobile-move')
    mobileTask.call(@, grunt, platform, dst)

  grunt.registerTask 'buildConfig', 'coffee:config'
  grunt.registerTask 'buildDev', 'coffee:dev'
  grunt.registerTask 'buildTest', 'coffee:test'
  grunt.registerTask 'requirejs:compile', [
    'requirejs:android_report_script',
    'requirejs:android_dashboard_script',
    'requirejs:legacy_dashboard_script',
  ]
  grunt.registerTask 'buildR', ['coffee:dev', 'coffee:config', 'requirejs:compile']
  grunt.registerTask 'moveDev', ['buildR']
