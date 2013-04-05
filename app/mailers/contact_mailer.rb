# encoding: utf-8

class ContactMailer < ActionMailer::Base
  default from: KvpCms::Application::ADMIN_EMAIL

  def user(contact)
    @contact = contact

    mail to: contact.email, subject: '[高専ベンチャー]お問い合わせを受け付けました'
  end

  def staff(contact)
    @contact = contact

    mail to: KvpCms::Application::ADMIN_EMAIL,
      subject: "【お問い合わせ】#{@contact.name_kanji} 様からお問い合わせがありました"
  end
end
