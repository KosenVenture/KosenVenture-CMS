# encoding: utf-8

class EntryMailer < ActionMailer::Base
  default from: KvpCms::Application::ADMIN_EMAIL

  def user(entry)
    @entry = entry

    mail to: entry.email, subject: '[高専ベンチャー]エントリーを受け付けました'
  end

  def staff(entry)
    @entry = entry

    name = Time.now.strftime("entry_%y%m%d_%H%M.csv")
    attachments[name] = entry.to_csv.encode('sjis')

    mail to: KvpCms::Application::ADMIN_EMAIL,
      subject: "【エントリー】#{@entry.name_kanji} 様がエントリーしました"
  end
end
