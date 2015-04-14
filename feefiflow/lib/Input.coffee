window.FeeFiFlow or= {}
class FeeFiFlow.Input extends FeeFiFlow.Property
  
  # edge = the edge currently linked to this input.
  # output = the output (parent?) this input is currently linked to.
  constructor: (@edge = null, @output = null) ->
  
  # should be another object's output.
  setOutput: (value) ->
    @output = value
  getOutput: ->
    @output