# == Schema Information
#
# Table name: scrapped_links
#
#  id              :integer          not null, primary key
#  link_name       :string
#  google_link     :text
#  scrapped_link   :text
#  search_query_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class ScrappedLinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
