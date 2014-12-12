#
# * resize-indent
# * https://github.com/gfpacheco/resize-indent
# *
# * Copyright (c) 2014 gfpacheco
# * Licensed under the MIT license.
#

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', 'resize-indent:double', => @double()
    atom.commands.add 'atom-workspace', 'resize-indent:halve', => @halve()

  double: ->
    @resize 2

  halve: ->
    @resize .5

  resize: (factor) ->
    editor = atom.workspace.getActivePaneItem()
    editor.transact ->
      editor.scan /^ +/g, (object) ->
        object.replace Array(Math.round(object.matchText.length * factor) + 1).join(' ')
