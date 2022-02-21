def is_interesting(number, awesome_phrases)
  return 2 if is_great(number, awesome_phrases)
  return 1 if is_great(number + 1, awesome_phrases) or
              is_great(number + 2, awesome_phrases)
  return 0
end

def is_great(number, awesome_phrases)
  return (number.to_s.size >= 3 and (
          awesome_phrases.include?(number) or
          "1234567890".include?(number.to_s) or
          "9876543210".include?(number.to_s) or
          number.to_s == number.to_s.reverse or
          number.to_s =~ /^(\d)(\1*|0*)$/ ))
end
