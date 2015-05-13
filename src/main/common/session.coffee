define 'js.mobile.session', ->
  class Session
    constructor: (options) ->
      {@username, @password, @organization} = options

    authOptions: ->
      auth:
        name: @username
        password: @password
        organization: @organization
