window.FeeFiFlow or= {}
class FeeFiFlow.TypeSystem
  
  constructor: () ->
    if window.feeFiFlow then return
    if not window.feeFiFlow then window.feeFiFlow = {}
    window.feeFiFlow.typeSystem = @
  
  addType: (name, constructor) ->
    @[name] = constructor
  
  getType: (name) ->
    return @[name]

typeSystem = new FeeFiFlow.TypeSystem()
module.exports = typeSystem