define 'js.mobile.module', ->
  moduleKeywords = ['extended', 'included']

  class Module
    @extend: (obj) ->
      for key, value of obj when key not in moduleKeywords
        @[key] = value

      obj.extended?.apply(@)
      @

    @include: (obj) ->
      for key, value of obj when key not in moduleKeywords
        # Assign properties to the prototype
        @::[key] = value

      obj.included?.apply(@)
      @
