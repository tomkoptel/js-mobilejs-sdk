module.exports = (grunt, platform, dst) ->

  fs = require('fs')
  globalProperties = grunt.file.readJSON('.properties.json')
  commonProperties = grunt.file.readJSON('common_properties.json')

  copyFunc = (platform, dst) ->
    path = require('path')
    source_dir = path.resolve(__dirname, "../../lib")
    files = fs.readdirSync(source_dir)

    for file in files
      source = path.resolve(__dirname, "../../lib/#{file}")
      destination = path.resolve(__dirname, "../../../#{dst}/#{file}")
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
    if globalProperties.env.platform?
      platform = globalProperties.env.platform
    else
      grunt.log.error 'Platform not detected. Either setup it in .properties.json or call grunt build:move:[ios|android]:/path/to/project/'
      return false

  if not dst?
    grunt.log.write("No 'dst' argument peeking env 'properties.env.project.dst' \n")

    dst = globalProperties.env.project.dst
    if not dst?
      grunt.log.error 'Destination is missing. Either setup it in .properties.json or call grunt build:move:[ios|android]:/path/to/project/'
      return false

  if not fs.existsSync(dst)
      grunt.log.error 'Invalid destination: ' + dst
      return false
  else
    copyFunc(platform, dst)

  return true
