exports.isBrowser = ->
  if typeof process isnt 'undefined' and process.execPath and process.execPath.indexOf('node') isnt -1
    return false
  true