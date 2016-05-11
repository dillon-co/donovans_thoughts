# == Schema Information
#
# Table name: content_summaries
#
#  id               :integer          not null, primary key
#  original_content :text
#  summary          :text
#  search_query_id  :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class ContentSummaryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
