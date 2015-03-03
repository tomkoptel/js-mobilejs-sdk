module.exports = (grunt) ->
  globalConfig =
    dst:
      android:
        dashboard: 'dashboard-android-mobilejs-sdk.js'
      ios:
        dashboard: 'dashboard-ios-mobilejs-sdk.js'

  frameworkPaths =
    'js.mobile.logger': 'main/logger'
    'js.mobile.context': 'main/context'
    'js.mobile.client': 'main/client'
    'js.mobile.callback.implementor': 'main/callback_implementor'
    'js.mobile.callback.bridge': 'main/callback_bridge'
    'js.mobile.dashboard.wrapper': 'main/dashboard/dashboard_wrapper'
    'js.mobile.dashboard.window': 'main/dashboard/dashboard_window'
    'js.mobile.dashboard.controller': 'main/dashboard/dashboard_controller'
    'js.mobile.view': 'main/view/view'

  androidSpecPaths =
    'js.mobile.android.callback.implementor': 'android/callback_implementor'
    'js.mobile.android.client': 'android/client'
    'js.mobile.android.logger': 'android/logger'

  merge = (dest, objs...) ->
    for obj in objs
      dest[k] = v for k, v of obj
    dest
  androidPaths = merge frameworkPaths, androidSpecPaths
  # grunt.log.write JSON.stringify(androidPaths, null, 2)

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    globalConfig: globalConfig,

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
        src: [ '*.coffee' ]
        dest: 'build/config'
        ext: '.js'

    simplemocha:
      dev:
        src: 'build/spec/main.spec.js'
        options:
          reporter: 'spec'
          slow: 200
          timeout: 1000

    requirejs:
      compile:
        options:
          baseUrl: 'build'
          out: "build/#{globalConfig.dst.android.dashboard}"
          include: ['android/main.js']
          optimize: 'none'
          logLevel: 0
          paths: androidPaths

    watch: all:
      files: ['src/**/*.coffee', 'spec/**/*.coffee']
      tasks: ['buildDev', 'buildTest', 'test']

  grunt.registerTask('test', 'simplemocha:dev')
  grunt.registerTask('buildConfig', 'coffee:config')
  grunt.registerTask('buildDev', 'coffee:dev')
  grunt.registerTask('buildTest', 'coffee:test')
  grunt.registerTask('buildR', ['coffee:dev', 'coffee:config', 'requirejs:compile'])

  grunt.registerTask 'build:move', 'Copy result scripts to specified projects', (platform, dst) ->
    fs = require('fs')
    properties = grunt.file.readJSON('.properties.json')

    copyFunc = (platform, dst) ->
      path = require('path')
      dashboard_src = globalConfig.dst[platform].dashboard
      source = path.resolve(__dirname, "./build/#{dashboard_src}")
      destination = path.resolve(__dirname, dst + dashboard_src)
      grunt.log.write("Source: #{source} \nDestination: #{destination} \n")

      if source?
        if not fs.existsSync(source)
            grunt.log.error 'Boom! Source was: ' + source
            return false
        else
          grunt.log.write("Start copying... \n")
          grunt.file.copy source, destination, {}
          grunt.log.write("Finished copying... \n")

    if not platform?
      if properties.env.platform?
        platform = properties.env.platform
      else
        grunt.log.error 'Platform not detected. Either setup it in .properties.json or call grunt build:move:[ios|android]:/path/to/project/'
        return false

    if not dst?
      grunt.log.write("No 'dst' argument peeking env 'properties.env.project.dst' \n")

      dst = properties.env.project.dst
      if not dst?
        grunt.log.error 'Destination is missing. Either setup it in .properties.json or call grunt build:move:[ios|android]:/path/to/project/'
        return false

    if not fs.existsSync(dst)
        grunt.log.error 'Invalid destination: ' + dst
        return false
    else
      copyFunc(platform, dst)

    return true

  grunt.registerTask 'moveDev', ['coffee', 'build:move']

  return
