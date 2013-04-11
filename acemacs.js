commands = {
  c: function(editor) {
    editor.selection.selectAll()
    editor.insert("")
    editor.focus()
  }
}

commands.c.description = "Cleans the document"

emacsCommand = function(editor) {
  editor.blur(); 
  window.onkeydown = function(e) {
    if(!editor.isFocused() && e.keyCode == 27) editor.focus()
    if(editor.isFocused()) return true
  }
  window.onkeyup = function(e) { 
    if(editor.isFocused()) return true;
    relatedFunc=commands[String.fromCharCode(e.keyCode).toLowerCase()];
    if (relatedFunc) relatedFunc(editor);
    return false;
  };
}

ace.commands.addCommand({name: 'acemacs', bindKey: {win: 'Esc'}, exec: emacsCommand});



