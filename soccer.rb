# convert score to ranking points
def ranking(score)
  if score[0] == score[1]
    [1, 1]
  elsif score[0] > score [1]
    [3, 0]
  else
    [0, 3]
  end
end

# read lines from stdin
def read_results
  results = []
  while (line = gets) # Капец! А шо, так можно было!!!
    arr = line.split(', ')
    name = arr.map { |a| a.split[0..-2].join(' ') }
    score = arr.map { |a| a.split[-1] }
    points = ranking(score)
    points.each_index { |i| results << [points[i], name[i]] }
  end
  results
end

# summarize and sort ranking table
def make_ranking_table(results)
  return until results
  results.each do |team|
    sum = 0
    results.each { |v| sum += v[0] if team[1] == v[1] }
    results.delete_if { |v| team[1] == v[1] }
    results.unshift([-sum, team[1]]) # make negative and swap to proper sorting order
  end
  results.sort!
end

# output ranking table to stdout
def print_ranking_table(results)
  return until results
  results.each_index { |i| puts "#{i + 1}. #{results[i][1]}, #{-results[i][0]} pt#{'s' if results[i][0] != -1}" }
end

print_ranking_table(make_ranking_table(read_results))

# 1. если нет параметров pipe or redirect, запросить имя файла
# 2. анализ pipe or redirect or file_name
