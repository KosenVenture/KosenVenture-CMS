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
end