module.exports = (grunt) ->
  properties = grunt.file.readJSON('common_properties.json')

  grunt.loadNpmTasks 'grunt-contrib-coffee'
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
            "build/#{properties.outputs.dashboard.android}"
            "bower_components/jquery/dist/jquery.min.js"
          ]

    requirejs:
      android:
        options:
          mainConfigFile: 'build/config/requirejs_config.js'
          out: "build/#{properties.outputs.dashboard.android}"
          include: ['android/main.js']
          paths:
            'js.mobile.android.callback.implementor': 'android/callback_implementor'
            'js.mobile.android.client': 'android/client'
            'js.mobile.android.logger': 'android/logger'

    watch: all:
      files: ['config/*.coffee', 'src/**/*.coffee', 'spec/**/*.coffee']
      tasks: ['buildDev', 'requirejs:compile']


  grunt.registerTask 'build:move', 'Copy result scripts to specified projects', (platform, dst) =>
    mobileTask = require('./build/config/task/grunt-mobile-move')
    mobileTask.call(@, grunt, platform, dst)

  grunt.registerTask 'buildConfig', 'coffee:config'
  grunt.registerTask 'buildDev', 'coffee:dev'
  grunt.registerTask 'buildTest', 'coffee:test'
  grunt.registerTask 'requirejs:compile', ['requirejs:android']
  grunt.registerTask 'buildR', ['coffee:dev', 'coffee:config', 'requirejs:compile']
  grunt.registerTask 'moveDev', ['buildR']
