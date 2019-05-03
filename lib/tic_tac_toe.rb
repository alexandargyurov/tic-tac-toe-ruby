WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  if index > 8 || index < 0
    false
  else

    if board[index] == 'X' || board[index] == 'O'
      false
    else
      true
    end

  end
end

def move(board, index, token)
  if valid_move?(board, index) == true
    board[index] = token
    board
  end
end

def input_to_index(input)
  input.to_i
end

def turn(board, play)
  index = input_to_index(play)
  if valid_move?(board, index)

    move(board, index, current_player(board))
    display_board(board)

    if won?(board)
      winner(board) == "X" || winner(board) == "O"
      puts "Congratulations #{winner(board)}!"
      @winner = winner(board)
    elsif draw?(board)
      @draw = true
    end

    board
  else
    puts 'error'
  end
end

def turn_count(board)
  counter = 0
  board.each do |x|
    if x == "X" || x == "O"
      counter+=1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end


def won?(board)
  if (board.all? { |value| value == ' ' }) == true  # if board is empty
    return false
  end


  if (WIN_COMBINATIONS.each do |combination|
    if (board[combination[0]] == 'X') && (board[combination[1]] == 'X') && (board[combination[2]] == 'X')
      return combination
    end

    if (board[combination[0]] == 'O') && (board[combination[1]] == 'O') && (board[combination[2]] == 'O')
      return combination
    end
  end) != false
    return false # draw
  end

end

def full?(board)
  if (board.all? { |value| value != '_' }) == true
    true
  end
end


def draw?(board)
  if full?(board) == true && won?(board) == false
    true
  else
    false
  end
end

def over?(board)
  if won?(board)
    return true
  end

  if draw?(board)
    return true
  end

  if won?(board) == false && draw?(board) == false
    return false
  end
end

def winner(board)
  combo = won?(board)

  if combo
    combo.each do |x|
      if board[x] == 'X'
        return 'X'
      end

      if board[x] == 'O'
        return 'O'
      end
    end
  end
end

