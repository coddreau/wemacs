$ ->
  getFile = (e) ->
    e.preventDefault()
    $.get "/file", file: $(this).attr("href"), (content) ->
      editor.selection.selectAll()
      editor.insert content
    
  $.get "/project_files", (response) ->
    for file in response
      link = $("<a>", href: file, text: file).on("click", getFile)
      li = $("<li>")
      li.append(link)
      li.appendTo("#file-browser ul")
