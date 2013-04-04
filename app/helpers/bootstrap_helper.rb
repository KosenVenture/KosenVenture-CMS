module BootstrapHelper
  def alert_tag(msg, klass)
    content_tag :div, class: "alert#{klass ? ' ' + klass : ''}" do
      tag :button,
        type: 'button',
        class: 'close',
        data: { dismiss: 'alert' }
      msg
    end
  end


  def icon_tag(klass)
    content_tag :i, '', class: klass
  end

  def white_icon_tag(klass)
    content_tag :i, '', class: "icon-white #{klass}"
  end

  def icon_link_to(body, url, i_class, html_opts={})
    html_opts[:href] = url
    content_tag :a, html_opts do
      icon_tag(i_class) + body
    end
  end
end