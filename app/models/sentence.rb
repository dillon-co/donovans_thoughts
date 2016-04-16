require 'gingerice'
require 'rginger'

class Sentence < ActiveRecord::Base

  def generated_sentence
    parser = RGinger::Parser.new
    output = parser.rephrase input
    output['alternatives']
  end  
end
