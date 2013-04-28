$("#BtnPreview").click () ->
  $.ajax {
    type: "POST",
    url: '/admin/page_preview',
    data: $("#PageForm").serialize(),
    success: (result) ->
      if result
        w = window.open ''
        w.document.open
        w.document.write result
        w.document.close
      else
        alert('プレビューの読み込みに失敗しました。')
  }

# 本文HTMLエディタ
editor = ace.edit("body_editor")
editor.setTheme("ace/theme/twilight")
editor.getSession().setMode("ace/mode/html")

textarea = $('textarea[name="page[body]"]')
textarea.hide()
# 編集されたらもとのtextareaに反映する
editor.getSession().setValue(textarea.val())
editor.getSession().on 'change', () ->
  textarea.val(editor.getSession().getValue())

# ページ順位スライダー
$("input[name='page[priority]']").change () ->
  $("#page_priority_disp").html($("input[name='page[priority]']").val())

