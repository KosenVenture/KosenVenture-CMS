class EventEntriesController < ApplicationController

  # POST /event_entries
  def create
    @entry = EventEntry.new(entry_params)
  end

  private

  def entry_params
    params.require(:event_entry).permit(:name_kanji, :name_kana, :email, :sexial, :birthday,
    :nct, :grade, :major,
    :twitter, :github, :facebook,
    :appeal, :myproduct,
    { question1: [] },
    :mail_ok)
  end
end
