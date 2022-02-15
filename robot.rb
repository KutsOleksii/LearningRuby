# defining a class for table, where robot should works
class Table
  attr_accessor :size_x, :size_y

  def initialize(table_length = 5, table_width = 6)
    @size_x = table_width
    @size_y = table_length
  end

  def in_range?(check_x, check_y)
    (0...size_x).include?(check_x) && (0...size_y).include?(check_y)
  end
end

# defining a class for robot
class Robot
  # class constants
  LEFT = false
  RIGHT = true

  attr_accessor :x, :y, :f, :on_table

  def initialize
    @on_table = false
  end

  def report
    puts "#{@x},#{@y},#{@f.to_s.upcase}" if @on_table
  end

  def rotate(clockwise = true)
    return nil unless @on_table

    direction = %i[east south west north]

    index = direction.index(@f)
    direction.rotate!(clockwise ? 1 : -1)
    @f = direction[index]

    # just get next/previous value of direction from array or hash
  end

  def move(table)
    return nil unless @on_table

    shift = { east: [1, 0], west: [-1, 0], north: [0, 1], south: [0, -1] }

    if table.in_range?(@x + shift[@f][0], @y + shift[@f][1])
      @x += shift[@f][0]
      @y += shift[@f][1]
    end
  end

  def place(set_f, table, set_x = -1, set_y = -1)
    if table.in_range?(set_x, set_y)
      @x = set_x
      @y = set_y
      @f = set_f
      @on_table = true
    end
  end

  def get_a_command(cmd, table)
    # read from file or std-in
    arr = cmd.gsub(' ', ',').split(',')
    case arr[0]
    when 'LEFT', 'RIGHT'
      rotate(eval(arr[0]))
    when 'REPORT'
      report
    when 'MOVE'
      move(table)
    when 'PLACE'
      place(":#{arr[3].downcase}".to_sym, table, arr[1].to_i, arr[2].to_i)
    end
  end
end

t = Table.new(3, 3)
r = Robot.new
r.place(:east, t, 1, 2)

puts

File.new('robot.cmd').each do |line|
  command = line.chomp.upcase
  r.get_a_command(command, t)
end
