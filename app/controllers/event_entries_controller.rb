class EventEntriesController < ApplicationController

  # POST /event_entries
  def create
    @entry = EventEntry.new(entry_params)

    if @entry.valid?
      EntryMailer.staff(@entry).deliver
      EntryMailer.user(@entry).deliver
    end
  rescue
    render 'raise'
  end

  private

  def entry_params
    params.require(:event_entry).permit(:name_kanji, :name_kana, :email, :sexial,
    :birth_year, :birth_month, :birth_day,
    :nct, :grade, :major,
    :twitter, :github, :facebook,
    :appeal, :myproduct,
    { question1: [] },
    :mail_ok)
  end
end
