SourcefetchTutorialView = require './sourcefetch-tutorial-view'
{CompositeDisposable} = require 'atom'

module.exports = SourcefetchTutorial =
  sourcefetchTutorialView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @sourcefetchTutorialView = new SourcefetchTutorialView(state.sourcefetchTutorialViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @sourcefetchTutorialView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'sourcefetch-tutorial:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @sourcefetchTutorialView.destroy()

  serialize: ->
    sourcefetchTutorialViewState: @sourcefetchTutorialView.serialize()

  toggle: ->
    console.log 'SourcefetchTutorial was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
