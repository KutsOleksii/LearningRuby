# Task #1
# Вывести в консоль, 30 раз "<3 ruby", каждый в новой строке, 10ый, 20ый, и 25ый вывод вывести просто "ruby".
class Task1
  def do_a_task
    30.times { |v| p [10, 20, 25].include?(v) ? "<3" : "ruby" }
    # (1..30).each do |i|
    #   case i
    #   when 10, 20, 25
    #     print "<3 "
    #   end
    #   puts "ruby"
    # end
  end
end

# Task #2
# Нарисовать в консоле круг, диаметр\радиус которого задается с консоли.
class Task2
  def do_a_task
    print "Введите диаметр круга: "
    d = gets.to_i
    (d + 1).times do |i|
      (d + 1).times do |j|
        # Не уверен, что эта строка отформатирована правильно
        if ((i - d / 2) ** 2 + (j - d / 2) ** 2) <= (d * d / 4)
          print '#'
        else
          print ' '
        end
      end
      puts
    end
  end
end

# Task #3
# Вывести в консоль матрицу с еденицами по диагонали. Размер задается с консоли.
class Task3
  def do_a_task
    print "Введите размер матрицы: "
    d = gets.to_i
    d.times { |i| puts "#{'0' * i}1#{'0' * (d - i - 1)}" }
  end
end

# Task #4
# Написать рекурсивный метод для поиска значения ключа key9 в хеше:
class Task4
  def do_a_task
    hash = { key1: {}, key2: {}, key3: { key4: 'str', key5: 'str2', key6: { key7: { key8: 1, key9: [2]} } }}
    puts hash[:key3]

    # 1. Берём очередное значение хеша (each)
    # 2. Если ключ совпадает - возвращаем результат
    # 3. Если хеш - реккурсия
    # 4. Если закончились элементы - возвращаем "не найден" (почему-то не работает)

    def rec_search(search_key, hash)
      hash.each do |key, value|
        if key == search_key
          puts "I find it! The value for #{search_key} is #{value}"
        elsif value.is_a?(Hash)
         rec_search(search_key, value)
        end
      end
    end

    rec_search(:key9, hash)
  end
end

# Task #5
# Написать метод, который принимает строку и приводит её в CamelCase, ruby_case_underscore и css-case.
class Task5
  def do_a_task
    str = 'i love ruby'

    def formatize(str, arg)
      case arg
      when :camel
        (str.split.each(&:capitalize!)).join
      when :underscore
        str.split.join('_')
      when :css
        str.split.join('-')
      else
        "4"
      end
    end

    puts formatize(str, :camel)
    puts formatize(str, :underscore)
    puts formatize(str, :css)
  end
end

# Task #6
# Написать метод, который принимает многомерный массив и тип данных, возвращает массив этих типов.
class Task6
  def do_a_task
    array = [
             [1, 2, 3, 4, '1'],
             ['2', '5', '10'],
             [111, 222, 333, 444],
             ['i', 'love', 'ruby'],
             { key: 'value' },
             [[['text', 100_000]]],
             [1..15, :lexus]
    ]
    puts array.to_s

    # 1. используем метод flatten
    # 2. Если ключ совпадает - возвращаем результат
    # 3. Если хеш - реккурсия
    # 4. Если закончились элементы - возвращаем "не найден"

    def get_all(arr, type, deep = nil)
      # a = []
      # deep = 0 if type == Array
      # arr.flatten(deep).each do |element|
      #    a << element if element.is_a?(type)
      # end
      # a # Пишут, что return лучше избегать, но просто 'a' выглядит странно
      deep = 0 if type == Array
      arr.flatten(deep).select { |v| v.is_a?(type) }
    end

    # puts "\nget_all(array, Integer)"
    # puts get_all(array, Integer).to_s
    # puts "\nget_all(array, String)"
    # puts get_all(array, String).to_s
    # puts "\nget_all(array, Hash)"
    # puts get_all(array, Hash).to_s
    # puts "\nget_all(array, Range)"
    # puts get_all(array, Range).to_s
    # puts "\nget_all(array, Array)"
    # puts get_all(array, Array).to_s
    # puts "\nget_all(array, Symbol)"
    # puts get_all(array, Symbol).to_s
    [Integer, String, Hash, Range, Array, Symbol].each do |klass|
      puts "\nget_all(array, #{klass})"
      puts get_all(array, klass).to_s
    end
  end
end

# Task #7
# Предыдущие таски обьеденить собрать классами, и обьеденить в одном. То-есть,
# будет одна точка входа программы с основным классом, котоый должен будет вызывать
# все другие. Каждый таск запускается с помощью консоли. Ввели в консоли 1 -
# запускается и выполняется первый таск.

class BeginnerTask
  def do_a_task(n)
    # task = eval "Task#{n}.new"
    task = Object.const_get("Task#{n}").new
    puts "Выполняю задание ##{n}"
    task.do_a_task
  end
end

b_t = BeginnerTask.new
while true do
  print "Введите номер задачи от 1 до 6 (0 - выход): "
  n = gets.to_i
  case n
  when 1..6
    b_t.do_a_task(n)
  when 0
    break
  else
    puts "Некорректная команда"
  end
end
