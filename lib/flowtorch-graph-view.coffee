path = require 'path'
fs = require 'fs'
FeeFiFlow = require '../feefiflow'
{CompositeDisposable, View, $, TextEditor} = require 'atom'

window.Flowtorch or= {}
window.Flowtorch.FeeFiFlow or= FeeFiFlow

GraphTabInstance = null

window.Flowtorch.GraphTab =
class Flowtorch.GraphTab extends View
  
  @latest: ->
    GraphTabInstance

  # <button class='btn icon icon-gear inline-block-tight'>Settings</button>
  # flaticon-function, flaticon-implies, .flaticon-character-separatedvalues, .flaticon-equal3
  @content: (params) ->
    @div class: 'flowtorch-graph-tab', =>
      @div class: 'graphtab-create-script-header', =>
        @p '', class: 'text-highlight', outlet: 'pathText'
        @button class: 'btn close octicon-close', outlet: 'hideCodeToggle'
      @tag 'atom-text-editor', class: 'graph-texteditor graphtab-right', outlet: 'editor'
      @div class: 'graph-editor graphtab-left-top graphtab-buttons', =>
        @button 'New Function', class: 'btn icon flaticon-function'
        @button 'New Variable', class: 'btn icon flaticon-implies'
        @button 'New Comparator', class: 'btn icon flaticon-equals3'
        @button 'New Action', class: 'btn icon flaticon-character-separatedvalues'
      @div class: 'graph-editor graphtab-left', =>
        @tag 'iframe', src: 'file://' + path.join(__dirname, '../', 'graph', 'apex-flow-editor', 'editor.html'), frameBorder: 'false', class: 'graphtab-iframe', outlet: 'editorFrame'
      

  initialize: (params) ->
    @params = params
    @path = params.path # script path
    @title = 'Graph: '+@params.name
    
    GraphTabInstance = @
    @pathText.text 'Name: '+params.name+' - Path: '+params.path
    
    @viewSettings('show-code')
    @hideCodeToggle.click =>
      if @_viewHideState == 'hide-code' or @_viewHideState == 'hide-editor'
        @viewSettings('show-code')
      else
        @viewSettings('hide-code')

    # test if this is neccessary / replace w. setImmediate if not
    setTimeout @createOrLoad.bind @, 1000
  
  viewSettings: (state) ->
    
    @_viewHideState = state
    
    @find('.full').removeClass 'full'
    @find('.hidden').removeClass('hidden')
    
    if state == 'hide-code'
      @find('.graph-editor').addClass 'full'
      @find('.graphtab-right').addClass 'hidden'
    else if state == 'hide-editor'
      @find('.hidden').removeClass 'hidden'
      @find('.graph-editor').addClass 'hidden'
      @find('.graphtab-right').addClass 'full'
    else
      @find('.hidden').removeClass 'hidden'
      @find('.full').removeClass 'full'
      

  createOrLoad: ->
    # somewhat annoying work around. can't require text-buffer?
    if not fs.existsSync(@path) then fs.writeFileSync @path, '// hello, script.\n', 'utf-8'
    @model = @editor.element.getModel()
    @model.getBuffer().setText fs.readFileSync(@path).toString('utf-8')
    @model.getBuffer().saveAs @path
    
    console.log 'created / loaded script.'
    
    @window = @editorFrame[0].contentWindow.window
    @graphDocument = @window.document
    
    @graph = new Flowtorch.FeeFiFlow.Graph()
    @graph.addNode('Fix', 'This', { x: 20, y: 20 })
    
    
    @loadInterval = setInterval(@loadCheck.bind @, 30)
  
  loadCheck: ->
    if @graphDocument.readyState == 'complete' and @loadInterval != -1
      if not @window.updateGraph then return
      @loadInterval = -1
      @window.tabView = @
      @window.Flowtorch = Flowtorch
      window.clearInterval @loadInterval
      
      styles = document.querySelector 'atom-styles'
      html = styles.innerHTML
      el = @graphDocument.createElement 'atom-styles'
      el.innerHTML = html
      @graphDocument.head.appendChild el
      
      @window.updateGraph @graph
      
      console.log 'ready 4 graph battle'
      @window.alert 'ready'

  createTab: ->
    tabBarView = atom.workspaceView.find('.pane.active').find('.tab-bar').view()
    tabView = tabBarView.tabForItem @
    $tabView = $ tabView
    @tabView = $tabView
    @setTitle @title

  destroy: ->
    #super
    tabBarView  = atom.workspaceView.find('.pane.active').find('.tab-bar').view()
    tabView     = tabBarView?.tabForItem? @

    if tabView
      $tabView    = $ tabView
      $tabView.remove()

    @tabView = $tabView = null

  getClass:     -> GraphTab
  getViewClass: -> GraphTab
  getView:      -> @
  getUri:      -> 'flowtorch://creator/'+@params?.name
  getURI: ->  @getUri()
  getPath: -> @path
  setPath: ->

  setTitle: (@title) ->
    if @tabView then @tabView.find('.title').text(@title)
  getTitle: -> @title

module.exports = Flowtorch.GraphTab 