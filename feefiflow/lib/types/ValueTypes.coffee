{$} = require 'atom'

typeSystem = require '../TypeSystem'

window.FeeFiFlow or= {}
window.FeeFiFlow.Properties or= {}
class FeeFiFlow.Properties.String extends FeeFiFlow.Property
  
  constructor: (@name, @value, @edge) ->
    super @name, @value, 'string', @edge
    @type = 'string'
  
  showProvidedEditor: ->
    @editor = document.createElement 'input'
    @editor.style.position = 'fixed'
    @editor.style.top = '500px'
    @editor.style.width = '100px'
    @editor.style.height = '25px'
    @editor.style.left = '600px'
    $(@editor).val @value
    document.body.appendChild @editor
    $(@editor).change (e) =>
      @value = $(e.target).val()
      $(e.target).remove()
      
class FeeFiFlow.Properties.Number extends FeeFiFlow.Property
  
  constructor: (@name, @value, @edge) ->
    super @name, @value, 'number', @edge
  
  showProvidedEditor: ->
    @editor = document.createElement 'input'
    @editor.style.position = 'fixed'
    @editor.style.top = '500px'
    @editor.style.width = '100px'
    @editor.style.height = '25px'
    @editor.style.left = '600px'
    $(@editor).val @value
    document.body.appendChild @editor
    $(@editor).change (e) =>
      @value = parseFloat $(e.target).val()
      $(e.target).remove()
      
class FeeFiFlow.Properties.Integer extends FeeFiFlow.Property
  
  constructor: (@name, @value, @edge) ->
    super @name, @value, 'number', @edge
  
  showProvidedEditor: ->
    @editor = document.createElement 'input'
    @editor.style.position = 'fixed'
    @editor.style.top = '500px'
    @editor.style.width = '100px'
    @editor.style.height = '25px'
    @editor.style.left = '600px'
    $(@editor).val @value
    document.body.appendChild @editor
    $(@editor).change (e) =>
      @value = parseInt $(e.target).val()
      $(e.target).remove()


typeSystem.addType 'string', FeeFiFlow.Properties.String
typeSystem.addType 'integer', FeeFiFlow.Properties.Integer
typeSystem.addType 'number', FeeFiFlow.Properties.Number