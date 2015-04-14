window.FeeFiFlow or= {}
class FeeFiFlow.Output extends FeeFiFlow.Property
  
  # should be another object's input.
  setInput: (value) ->
    @input = value
  getInput: ->
    @input