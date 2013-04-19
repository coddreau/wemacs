$ ->
  getFile = (e) ->
    e.preventDefault()
    console.log $(this).attr("href")

  $.get "/project_files", (response) ->
    for file in response
      link = $("<a>", href: file, text: file).on("click", getFile)
      li = $("<li>")
      li.append(link)
      li.appendTo("#file-browser ul")
