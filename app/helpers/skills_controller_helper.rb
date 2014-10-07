module SkillsControllerHelper
  def shorten_text(text)
    sentences = text.split(".").map{|sentence| sentence + "."}
    final_text = sentences.inject('') do |sum_of_words,next_word|
      sum_of_words.split('').count + next_word.split('').count <= 230 ? sum_of_words += next_word : sum_of_words +".."
    end
  end
end
