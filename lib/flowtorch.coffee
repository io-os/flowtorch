FlowtorchView = require './flowtorch-view'
PromptSaveView = require './flowtorch-prompt'
GraphTabView = require './flowtorch-graph-view'
PropertyInspector = require './property-inspector'

{Compiler} = require '../compiler'
{CompositeDisposable} = require 'atom'

path = require 'path'
window.edge = require 'edge'

window.Flowtorch or= {}
window.Flowtorch.graphs or= {}
window.Flowtorch.graphs.path = path.join(path.dirname(__dirname), '../../flowtorch')

module.exports =
  flowtorchView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable
    
    @state = state or {}

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'flowtorch:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'flowtorch:create-graph': => @newscript()

  createPrompt: (type, next) ->
    callback = (text) ->
      next(text)

    promptEl = new PromptSaveView(callback: callback, type: type)
    modal = atom.workspace.addModalPanel item: promptEl, visible: true

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @flowtorchView.destroy()

  serialize: ->
    #flowtorchViewState: @flowtorchView.serialize()

  toggle: ->
    console.log 'Flowtorch was toggled!'
    @newscript()
    
  newscript: ->
    console.log 'Run: New script'
    @createPrompt 'Graph', (name) =>
      name = name.replace(/[^a-z0-9]/gi, '').toLowerCase()
      if name.indexOf(".") != -1 then name = name.split('.')[0]
      apath = path.join Flowtorch.graphs.path, name+'.js'
      data = { name, apath }
      atom.workspace.activePane.activateItem(@tabview = new GraphTabView({ parent: @, path: apath, name: name, state: @state }))