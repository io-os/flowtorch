GraphTabView = require './flowtorch-graph-view'

Flowtorch = Flowtorch || {}
module.exports =
class Flowtorch.View
  constructor: (serializeState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('flowtorch')

    @tab = new GraphTab({ parent: @, path: '/Users/gray/edge/package.json', name: 'package.json' })
    @tab.createTab()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
