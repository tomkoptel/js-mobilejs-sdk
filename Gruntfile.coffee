module.exports = (grunt) ->
  globalConfig =
    dst:
      android:
        dashboard: 'dashboard-android-mobilejs-sdk.js'
      ios:
        dashboard: 'dashboard-ios-mobilejs-sdk.js'

  framework = [
    'src/main/scope.coffee'
    'src/main/callback_implementor.coffee'
    'src/main/callback_bridge.coffee'
    'src/main/client.coffee'
    'src/main/logger.coffee'
    'src/main/context.coffee'
    'src/main/view/view.coffee'
    'src/main/dashboard/dashboard_window.coffee'
    'src/main/dashboard/dashboard_wrapper.coffee'
    'src/main/dashboard/dashboard_controller.coffee'
  ]
  androidSpecificDep = [
    'src/android/callback_implementor.coffee'
    'src/android/client.coffee'
    'src/android/logger.coffee'
    'src/android/main.coffee'
  ]
  androidDep = framework.concat androidSpecificDep

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    globalConfig: globalConfig,
    coffee:
      compileJoined:
        options: join: true
      dev:
        files:
          'build/<%= globalConfig.dst.android.dashboard %>': androidDep
          'build/<%= globalConfig.dst.ios.dashboard %>': []
          'build/chore.js': [
            'src/main/scope.coffee'
            'src/main/logger.coffee'
            'src/main/blah.coffee'
          ]
      test:
        files:
          'build/spec/main.spec.js' : 'spec/*.spec.coffee'
    simplemocha:
      dev:
        src: 'build/spec/main.spec.js'
        options:
          reporter: 'spec'
          slow: 200
          timeout: 1000
    watch: all:
      files: ['src/**/*.coffee', 'spec/**/*.coffee']
      tasks: ['buildDev', 'buildTest', 'test']

  grunt.registerTask('test', 'simplemocha:dev')
  grunt.registerTask('buildDev', 'coffee:dev')
  grunt.registerTask('buildTest', 'coffee:test')

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
