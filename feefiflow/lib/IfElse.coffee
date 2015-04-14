window.FeeFiFlow or= {}

# if / else
class FeeFiFlow.IfElse extends FeeFiFlow.Object
  
  constructor: ->
    super
    # forms the arguments (Script creates an object for outputs that is returned, Parses inputs from object)
    @true = new FeeFiFlow.Block()
    @false = new FeeFiFlow.Block()
  
  initialize: ->
    @addOutput new FeeFiFlow.Output()
  
  addProperty: (prop) ->
    # Properties are just what the name implies, they do not however represent a connection
    # between edges. (Just values or functions)
    @properties.push prop