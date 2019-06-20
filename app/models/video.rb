# typed: false
# == Schema Information
#
# Table name: videos
#
#  id          :bigint(8)        not null, primary key
#  content_url :string
#  recorded_at :date
#  runtime     :integer
#  slides_url  :string
#  speaker     :string
#  speaker_url :string
#  summary     :text
#  title       :string
#  video_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :integer
#  user_id     :integer
#

class Video < ApplicationRecord
  belongs_to :user
  belongs_to :event

  DATEPICKER_JS = {
    format: 'YYYY-MM-DD',
    showTodayButton: true,
    icons: {
      time: 'fa fa-clock-o',
      date: 'fa fa-calendar',
      up: 'fa fa-arrow-up',
      down: 'fa fa-arrow-down',
      previous: 'fa fa-chevron-left',
      next: 'fa fa-chevron-right',
      today: 'fa fa-calendar-check-o',
      clear: 'fa fa-delete',
      close: 'fa fa-times'
    }
  }

  scope :sorted, -> { order('recorded_at DESC') }

  validates :user_id, presence: true
  validates :recorded_at, presence: true
  validates :runtime, presence: true
  validates :speaker, presence: true
  validates :summary, presence: true, length: { within: 20..1000 }
  validates :title, presence: true, length: { maximum: 50 }

  def to_s
    "#{title}, #{speaker}"
  end

  def nice_created_at
    created_at.strftime('%d %b %Y')
  end

  def nice_recorded_at
    recorded_at.strftime('%d %b %Y')
  end

  def youtube_id
    video_url.scan(/v=([^&]+)/).flatten.first
  end
end
