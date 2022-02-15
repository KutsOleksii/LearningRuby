results = []
puts

File.new('soccer').each do |line|
  arr = line.split(', ')
  name = arr.map {|a| a.split[0..-2].join(' ')}
  score = arr.map {|a| a.split[-1]}
  if score[0] == score[1]
    score = [1, 1]
  elsif score[0] > score [1]
    score = [3, 0]
  else
    score = [0, 3]
  end

  results << [score[0], name[0]]
  results << [score[1], name[1]]
end

#===================================
# summarize ranking table
results.each do |team|
  sum = 0
  results.each {|v| sum += v[0] if team[1] == v[1]}
  results.delete_if {|v| team[1] == v[1]}
  results.unshift([-sum, team[1]])
end
#===================================
# sort ranking table
results.sort!

#===================================
# output ranking table
results.each_index {|i| puts "#{i+1}. #{results[i][1]}, #{-results[i][0]}"}
#===================================

# Осталось сделать обёртку ООП и CLI
