# encoding: utf-8

class ContactsController < ApplicationController
  layout 'kvp'

  # GET /contact
  def show
    @page_title = 'お問い合わせ'
    @page_description = "高専ベンチャーへのお問い合わせはこちらから"

    @contact = Contact.new
  end

  # POST /contact
  def create
    @page_title = 'お問い合わせ'
    @page_description = "高専ベンチャーへのお問い合わせはこちらから"
    @contact = Contact.new(contact_params)

    if @contact.valid?
      ContactMailer.staff(@contact).deliver
      ContactMailer.user(@contact).deliver

      redirect_to root_url, notice: 'お問い合わせ内容を送信しました。'
    else
      render :show
    end
  rescue
    render :show, notice: '【エラー】正しく送信できませんでした。もう一度送信をお願いいたします。'
  end

  private

  def contact_params
    params.require(:contact).permit(:name_kanji, :name_kana, :email, :affiliation, :body)
  end
end
