FlowtorchView = require './flowtorch-view'
{CompositeDisposable} = require 'atom'

module.exports = Flowtorch =
  flowtorchView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @flowtorchView = new FlowtorchView(state.flowtorchViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @flowtorchView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'flowtorch:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @flowtorchView.destroy()

  serialize: ->
    flowtorchViewState: @flowtorchView.serialize()

  toggle: ->
    console.log 'Flowtorch was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
