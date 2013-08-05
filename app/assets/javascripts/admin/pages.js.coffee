
# Page Preview
$("#BtnPreview").click () ->
  for instance of CKEDITOR.instances
    CKEDITOR.instances[instance].updateElement()
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

# BlogPreview
$("#BtnBlogPreview").click () ->
  for instance of CKEDITOR.instances
    CKEDITOR.instances[instance].updateElement()
  $.ajax {
    type: "POST",
    url: '/admin/blog_preview',
    data: $("#BlogPostForm").serialize(),
    success: (result) ->
      if result
        w = window.open ''
        w.document.open
        w.document.write result
        w.document.close
      else
        alert('プレビューの読み込みに失敗しました。')
  }

# Page本文HTMLエディタ
if $("pre#body_editor").length != 0
	editor = ace.edit("body_editor")
	editor.setTheme("../ace/theme/twilight")
	editor.getSession().setMode("../ace/mode/html")
	textarea = $('textarea[name="page[body]"]')
	textarea.hide()
	# 編集されたらもとのtextareaに反映する
	editor.getSession().setValue(textarea.val())
	editor.getSession().on 'change', () ->
		textarea.val(editor.getSession().getValue())

# ページ順位スライダー
$("input[name='page[priority]']").change () ->
  $("#page_priority_disp").html($("input[name='page[priority]']").val())

