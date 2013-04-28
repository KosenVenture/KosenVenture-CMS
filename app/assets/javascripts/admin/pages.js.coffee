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

$("input[name='page[priority]']").change () ->
  $("#page_priority_disp").html($("input[name='page[priority]']").val())