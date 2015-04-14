{CompositeDisposable, View} = require 'atom'
path = require 'path'


class PromptSaveView extends View

  @content: (params) ->
    @div class: 'prompt-save-view', =>
      @tag 'atom-text-editor', mini: true, 'placeholder-text': 'Name:', outlet: 'editor'
      @button class: 'btn', click: 'cancelClicked', "Cancel"
      @button class: 'btn padLeft', click: 'createClicked', "Create " +params.type

  initialize: (params) ->
    @callback = params.callback || (o) => console.log 'Callback: '+o
    @cancel = params.cancel || => $(@).remove()

  cancelClicked: -> @cancel()
  createClicked: ->
    $(@).parent().remove()
    @callback(@editor.element.getModel().getText())

window.Flowtorch or= {}
window.Flowtorch.PromptSaveView = PromptSaveView
module.exports = window.Flowtorch.PromptSaveView