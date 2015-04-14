window.FeeFiFlow or= {}
class FeeFiFlow.Edge
  
  constructor: ->
    @start = no
    @end = no
  
  isValid: ->
    # return yes if this edge should connect
    # between the two specified points.
    yes
  
  getInput: ->
    @start
  getOutput: ->
    @end
    
FeeFiFlow.Edge.create = (start, end) ->
  edge = new FeeFiFlow.Edge()
  edge.start = start
  edge.end = end
  edge