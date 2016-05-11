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

require 'rginger'
require 'ots'
class ContentSummary < ActiveRecord::Base
  belongs_to :search_query
  after_create :create_summary

  def create_summary
    all_articles = OTS.parse(original_content)
    self.summary = all_articles.summarize(sentences: 6)
  end  
end
