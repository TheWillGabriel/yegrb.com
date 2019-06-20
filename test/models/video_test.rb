# typed: strong
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

require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
