module HashModifiers
  class ::Hash
    def compact_blanks
      self.select{|x,v|  !v.blank? && !v.nil?}
    end
  end
end