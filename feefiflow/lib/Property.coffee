window.FeeFiFlow or= {}
class FeeFiFlow.Property
  
  # edge = the edge currently linked to this input.
  # input = the input (parent?) this input is currently linked to.
  constructor: (@name = "Property", @value = "default-value", @type = "string", @edge = null) ->
  
  # should be another object's input.
  getName: ->
    @name
  setName: (name) ->
    @name = name
  
  setEdge: (value) ->
    @edge = value
  getEdge: ->
    @edge
  
  setValue: (value) ->
    @value = value
  getValue: ->
    @value
  
  getType: ->
    @type
  setType: (@type) ->
    @type