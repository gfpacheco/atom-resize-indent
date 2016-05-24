#
# * resize-indent
# * https://github.com/gfpacheco/resize-indent
# *
# * Copyright (c) 2014 gfpacheco
# * Licensed under the MIT license.
#

leadingWhiteSpaceRegex = /^ +/g

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', 'resize-indent:double', => @double()
    atom.commands.add 'atom-workspace', 'resize-indent:halve', => @halve()

  double: ->
    @resize 2

  halve: ->
    @resize .5

  resize: (factor) ->
    return unless editor = atom.workspace.getActiveTextEditor()

    resizeInScan = (scan) ->
      scan.replace Array(Math.round(scan.matchText.length * factor) + 1).join(' ')

    editor.transact ->
      ranges = editor.getSelectedBufferRanges()
      if ranges.length == 1 && ranges[0].isEmpty()
        editor.scan leadingWhiteSpaceRegex, resizeInScan
      else
        for range in ranges
          range.start.column = 0
          range.end.column = editor.lineTextForBufferRow(range.end.row).length
          editor.scanInBufferRange leadingWhiteSpaceRegex, range, resizeInScan
