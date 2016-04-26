# == Schema Information
#
# Table name: sentences
#
#  id         :integer          not null, primary key
#  input      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'gingerice'
require 'rginger'
require 'ots'
class Sentence < ActiveRecord::Base

  def generate_sentence(i)
    puts "again"
    parser = RGinger::Parser.new
    output = parser.rephrase i
    output_not_working = true
    if output_not_working
      5.times do
        if output['alternatives'] = []
          i = i.split(' ').shuffle.shuffle.join(' ')
          output = parser.rephrase i 
          puts output
        else  
          output['alternatives']
          output_not_working = false
        end
      end  
    end 
    return output['alternatives']   
  end  


  def summarize_paragraph
    article = OTS.parse(paragraph)
    sentences = article.summarize(percent: 5)
    sentences.each do |sentence|
      generate_sentence(sentence[:sentence])
    end  
  end

  def get_needed_words
    new_sentences = []
    summarize_paragraph.each do |sentence|
      parsed_sentence = OTS.parse(sentence[:sentence])
      topics_and_keywords = generate_topics_and_keywords(parsed_sentence)
      topics_array = topics_and_keywords[:topics]
      extras_array = ["that", "this", "it", 'the', "then", "will be", 'was', 'is']
      keyword_array = topics_and_keywords[:keywords]
      while new_sentences == []
        mashed_words_string = mashed_words(topics_array, keyword_array)
        topics_array << extras_array.sample
        extras_array.each { |word| topics_array.delete(word) }
        generate_sentence(mashed_words_string).each {|s| new_sentences << s}
      end  
    end  
  end

  def generate_topic_and_keyword_array(topics, keywords)
    keywords.each { |k| topics.delete(k) }
    topics << keywords.sample
    topics
  end  

  def mashed_words(topics, keywords)
    generate_topic_and_keyword_array(topics, keywords).join(' ')
  end  

  def generate_topics_and_keywords(sentence)
    all_topics = sentence.topics
    all_keywords = sentence.keywords
    all_topics.each { |topic| all_keywords.delete(topic)}
    {topics: all_topics, keywords: all_keywords}
  end  

  def paragraph
    "The New York Times (sometimes abbreviated to NYT) is an American daily newspaper, founded and continuously published in New York City since September 18, 1851, by the New York Times Company. The New York Times has won 117 Pulitzer Prizes, more than any other news organization.[5][6][7]

The paper's print version has the second-largest circulation, behind The Wall Street Journal, and the largest circulation among the metropolitan newspapers in the United States. The New York Times is ranked 39th in the world by circulation. Following industry trends, its weekday circulation has fallen to fewer than one million daily since 1990.[8]

Nicknamed for years as 'The Gray Lady',[9] The New York Times has long been regarded within the industry as a national 'newspaper of record'.[10] The New York Times is owned by The New York Times Company. Arthur Ochs Sulzberger, Jr., the Publisher and the Chairman of the Board, is a member of the Ochs-Sulzberger family that has controlled the paper since 1896.[11] The New York Times international version, formerly the International Herald Tribune, is now called the International New York Times.

The paper's motto, 'All the News That's Fit to Print', appears in the upper left-hand corner of the front page. Since the mid-1970s, The New York Times has greatly expanded its lay-out and organization, adding special weekly sections on various topics supplementing the regular news, editorials, sports, and features. In recent times, The New York Times has been organized into the following sections: News, Editorials/Opinions-Columns/Op-Ed, New York (metropolitan), Business, Sports of The Times, Arts, Science, Styles, Home, Travel, and other features.

On Sunday, The New York Times is supplemented by the Sunday Review (formerly the Week in Review), The New York Times Book Review, The New York Times Magazine and T: The New York Times Style Magazine. The New York Times stayed with the broadsheet full page set-up (as some others have changed into a tabloid lay-out) and an eight-column format for several years, after most papers switched to six, and was one of the last newspapers to adopt color photography, especially on the front page. The New York Times was founded as the New-York Daily Times on September 18, 1851, by journalist and politician Henry Jarvis Raymond (1820–69), then a Whig Party member and later second chairman of the newly organized Republican Party National Committee, and former banker George Jones. Sold for a penny (equivalent to 28 cents today), the inaugural edition attempted to address various speculations on its purpose and positions that preceded its release:[12]

The newspaper shortened its name to The New-York Times in 1857. It dropped the hyphen in the city name in the 1890s.[13] On April 21, 1861, The New York Times departed from its original Monday–Saturday publishing schedule and joined other major dailies in adding a Sunday edition to offer daily coverage of the Civil War. One of the earliest public controversies it was involved with was the Mortara Affair, the subject of twenty editorials it published alone.The main office of The New York Times was attacked during the New York Draft Riots sparked by the beginning of military conscription for the Northern Union Army now instituted in the midst of the Civil War on July 13, 1863. At 'Newspaper Row', across from City Hall, Henry Raymond, owner and editor of The New York Times, averted the rioters with 'Gatling' (early machine, rapid-firing) guns, one of which he manned himself. The mob now diverted, instead attacked the headquarters of abolitionist publisher Horace Greeley's New York Tribune until forced to flee by the Brooklyn City Police, who had crossed the East River to help the Manhattan authorities."
  end  

end

