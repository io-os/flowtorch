path = require 'path'
fs = require 'fs'
FeeFiFlow = require '../feefiflow'
{CompositeDisposable, View, $, TextEditor} = require 'atom'

window.Flowtorch or= {}
window.Flowtorch.FeeFiFlow or= FeeFiFlow

window.Flowtorch.PropertySegment =
class Flowtorch.PropertySegment extends View
  
  @content: ->
    @div class: 'inspect-property', =>
      @div class: 'property-name', outlet: 'name',
      @div class: 'property-value', outlet: 'value'
      
  initialize: (params) ->
    # initialize
    @params = params
    @obj = params.obj
    
    @name.text params.name
    @createValue()
  
  createValue: ->
    # todo
    value = null
    if typeof(obj.value) == 'object'
      value = JSON.stringify(obj.value)
      @value.text value
    
    if value == null
      return
  
  updateValue: ->
    # todo

Flowtorch.inspector = null

# Property Inspector - Visual Popover
window.Flowtorch.PropertyInspector =
class Flowtorch.PropertyInspector extends View
  
  @content: ->
    @div class: 'flowtorch-property-inspector', =>
      @div class: 'flowtorch-inspector-body', =>
        @div class: 'inspect-header', outlet: 'header',
        @div class: 'inspect-body', outlet: 'body'
  
  # get or create the inspector
  @createInspector: (params) ->
    if Flowtorch.inspector == null
      Flowtorch.inspector = new Flowtorch.PropertyInspector(params)
      $('atom-workspace').append Flowtorch.inspector.view
      console.log Flowtorch.inspector.view
    else
      Flowtorch.inspector.setParams params
      Flowtorch.inspector.show()
      
    Flowtorch.inspector
  
  initialize: (params) ->
    # bla..
    if params then @setParams params
  
  setParams: (params) ->
    @title = params.title
    @object = params.object
    @properties = @object.properties or {}
    
    @header.text @title
    @showProperties()
  
  createProp: (name, obj) ->
    obj = { name: name, obj: obj }
    if name is 'widgetType' then return

    obj.view = new Flowtorch.PropertySegment(obj)
    @props.push obj
    obj.view # i think this needs to be called
    @body.append obj.view

  showProperties: (obj) ->
    console.log 'showProperties -- flowtorch'
    console.dir(obj)
    
    @properties.html ''
    @props = []
    if not obj.properties then return

    for prop in obj.properties
      @createProp(prop, obj)

module.exports = Flowtorch.PropertyInspector