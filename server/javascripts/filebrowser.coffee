class @FileBrowser
  constructor: ->
    $.get "/project_files", (response) =>
      for file in response
        link = $("<a>", href: file, text: file).on("click", (e) => @openFile(e, `(this)`))
        li = $("<li>")
        li.append(link)
        li.appendTo("#file-browser ul")

  loadModeForFile: (file) ->
    window.modes ||= []
    test = (what, string) -> if typeof criteria == "string" then criteria == string else criteria.test string
    for lang, criterias of ModeConfig
      for criteria in criterias
        if test(criteria, file)
          window.modes[lang] = require("ace/mode/#{lang}").Mode
          editor.getSession().setMode(new window.modes[lang])
          return

  openFile: (e, obj) ->
    e.preventDefault()
    file = $(obj).attr("href")
    $.get "/file", file: file, (content) =>
      editor.selection.selectAll()
      editor.insert content
      editor.focus()
      window.currentFile = file
      @loadModeForFile(file)
