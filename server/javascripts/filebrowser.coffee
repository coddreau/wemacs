$ ->
  openFile = (e) ->
    e.preventDefault()
    file = $(this).attr("href")
    $.get "/file", file: file, (content) ->
      editor.selection.selectAll()
      editor.insert content
      editor.focus()
      window.currentFile = file
    
  $.get "/project_files", (response) ->
    for file in response
      link = $("<a>", href: file, text: file).on("click", openFile)
      li = $("<li>")
      li.append(link)
      li.appendTo("#file-browser ul")
