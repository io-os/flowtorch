window.FeeFiFlow or= {}
class FeeFiFlow.Object
  
  constructor: ->
    @inputs = {}
    @outputs = {}
    @properties = []
  
  addProperty: (prop) ->
    # Properties are just what the name implies, they do not however represent a connection
    # between edges. (Just values or functions)
    @properties.push prop
  
  addInput: (input) ->
    # Inputs are a specific class that each represent the value of an argument.
    @inputs.push input
  
  addOutput: (output) ->
    @outputs.push output