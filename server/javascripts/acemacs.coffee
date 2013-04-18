commands =
  c: (editor) ->
    editor.selection.selectAll()
    editor.insert("")
    editor.focus()

commands.c.description = "Clears the document"

emacsCommand = (editor) ->
  editor.blur()
  window.onkeydown = (e) ->
    editor.focus() if (!editor.isFocused() && e.keyCode == 27) 
    return true if editor.isFocused()
  window.onkeyup = (e) ->
    return true if editor.isFocused()
    relatedFunc = commands[String.fromCharCode(e.keyCode).toLowerCase()]
    relatedFunc?(editor)
    return false

editor.commands.addCommand(name: 'acemacs', bindKey: {win: 'Esc'}, exec: emacsCommand)
