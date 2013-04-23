class @FileOpen

  constructor: (element) ->
    @element = $(element)
    @configureInput $("input", element)
  
  centerElement: (e, minusLeft=0, minusTop=100) ->
    left = ($(document).width() / 2) - ($(e).width() / 2)
    top = ($(document).height() / 2) - ($(e).height() / 2) - minusTop
    $(e).css left: "#{left}px", top: "#{top}px"
  
  
  #TODO: add a minimum interval for start searching
  # onKeyUp -> clearInterval(searchInterval) and searchInterval=setInterval(searchFiles, interval)
  configureInput: (input) ->
    $(input).on "keydown", (e) =>
      return @close() if e.keyCode == 27 #TODO: KeyCode.Esc
      $.get "/project_files", filter: $(input).val(), (response) =>
        (ul = $("ul", @element)).html("")
        for file in response
          li = $("<li>", text: file)
          li.appendTo ul
  
  show: ->
    @centerElement @element
    @element.show()
    $("input", @element).focus()
    
  close: ->
    $(@element).hide()
