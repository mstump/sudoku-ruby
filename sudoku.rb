board = [
  5, 3, 0,  0, 7, 0,  0, 0, 0,
  0, 0, 0,  1, 9, 5,  0, 0, 0,
  0, 9, 8,  0, 0, 0,  0, 6, 0,

  8, 0, 0,  0, 6, 0,  0, 0, 3,
  4, 0, 0,  8, 0, 3,  0, 0, 1,
  7, 0, 0,  0, 2, 0,  0, 0, 6,

  0, 6, 0,  0, 0, 0,  2, 8, 0,
  0, 0, 0,  4, 1, 9,  0, 0, 5,
  0, 0, 0,  0, 8, 0,  0, 7, 9]

def get_sub_cord(i)
  { 0 => 0,
    1 => 3,
    2 => 6,
    3 => 27,
    4 => 30,
    5 => 33,
    6 => 54,
    7 => 57,
    8 => 60 }[i]
end

def row(board, i)
  return board.slice(i * 9  .. (i + 1) * 9 - 1)
end

def sub_row(board, i)
  return board.slice(i .. i + 2)
end

def get_row(i)
  return i / 9
end

def get_column(i)
  return i % 9
end


def column(board, c)
  output = []
  for i in (c .. board.size).step(9)
    output << board[i]
  end
  return output
end

# puts "#{sub_board(board, 0)}"

def sub_board(board, b)
  start = get_sub_cord(b)
  output = []
  for i in (0 .. 2)
    output.concat(sub_row(board, (i * 9) + start))
  end
  return output
end

def complete?(sub_board)
  all_nums = sub_board.flatten
  return all_nums.sort == [1 .. 9]
end


def foo(board)

  possible = {}
  last_size = -1

  while true
    (0 .. board.size).each do |i|
      if board[i] == 0
        r = row(board, get_row(i))
        c = column(board, get_column(i))
        sub_square_index = get_row(i) / 3 * 3 + get_column(i) / 3
        s = sub_board(board, sub_square_index)
        p = (1 .. 9).to_a - [r, c, s].flatten

        # puts "i #{i}, si #{sub_square_index}, s #{s}"
        # puts "i #{i}, get_row(i), #{get_row(i)}, r #{r}"
        # puts "i #{i}, get_row(i), #{get_row(i)}, p #{p}, possible #{1..9}, s #{s}, r #{r}, c #{c}"

        possible[i] = p
      end
    end

    for k, p in possible
      if p.size == 1
        board[k] = p.first
        possible.delete(k)
      end
    end

    if possible.size == 0
      return board

    elsif possible.size == last_size
      return board
    else
      last_size = possible.size
    end
  end
end


result = foo(board)
for i in (0 .. 8)
  puts "#{row(board, i)}"
end

# puts "#{sub_board(board, 5)}"
#puts "#{row(board, 0)}"
#puts "#{column(board, 4)}"
