@editor = ace.edit('code')
@editor.setShowPrintMargin(false)
@editor.setDisplayIndentGuides(false)

commands =
  c: (editor) ->
    editor.selection.selectAll()
    editor.insert("")
    editor.focus()
  o: (editor) ->
    window.keyboardInUse = true
    window.fileOpen ||= new FileOpen("#file-open")
    fileOpen.show()

commands.c.description = "Clears the document"

saveCurrentDocument = (editor) ->
  $.post '/save', file: window.currentFile, content: editor.getSession().getDocument().getValue()

emacsCommand = (editor) ->
  editor.blur()
  window.onkeydown = (e) ->
    return if window.keyboardInUse
    editor.focus() if (!editor.isFocused() && e.keyCode == 27) 
    return true if editor.isFocused()
  window.onkeyup = (e) ->
    return true if window.keyboardInUse or editor.isFocused()
    relatedFunc = commands[String.fromCharCode(e.keyCode).toLowerCase()]
    relatedFunc?(editor)
    return false

@editor.commands.addCommand(name: 'acemacs', bindKey: {win: 'Esc'}, exec: emacsCommand)
@editor.commands.addCommand(name: 'save', bindKey: {win: 'Ctrl-S'}, exec: saveCurrentDocument)
