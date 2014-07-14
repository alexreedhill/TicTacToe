class CommandLineInterface
    GREETING = "Welcome to ttt-rb, are you ready to play?"
    FAREWELL = "Ok, thanks for playing!"
    NEXT_MOVE = "Enter an integer to select which cell you would like to fill next (zero based)"
    INVALID_MOVE = "That cell is already filled. Please select a different cell (zero based)"
    PLAY_AGAIN = "Would you like to play again?"
    LOSS = " Game over, you lose!"
    DRAW = " The game ended in a draw"
    AI_TYPE = "Choose an ai type. Type 0 for minimax, 1 for non-minimax"
    BOARD_HEIGHT = "Choose a board size. Type 3 for 3x3, 4 for 4x4"
    FIRST_PLAYER_NAME = "Choose who goes first. Type 0 for AI first, 1 for human first"
    HUMAN_VALUE = "Choose your character. Type X or O"
    CHANGE_GAME_OPTIONS = "Would you like to change your game options?"

  def output_message(message_name)
    puts self.class.const_get(message_name)
  end

  def accept_input
    gets.chomp.downcase
  end

  def get_ai_type
    output_message('AI_TYPE')
    input = accept_input
    if input == 1
     'non-minimax'
    else
     'minimax'
    end
  end

  def get_board_height
    output_message('BOARD_HEIGHT')
    height = accept_input.to_i
    unless height.between?(3, 4)
      height = 3
    end
    height
  end

  def get_first_player_name
    output_message("FIRST_PLAYER_NAME")
    input = accept_input
    if input == "0"
      'ai'
    else
      'human'
    end
  end

  def get_human_value
    output_message("HUMAN_VALUE")
    input = accept_input.upcase
    unless input == 'X' || input == 'O'
      input = 'X'
    end
    input
  end

  def human_move_prompt(board)
    draw_board(board)
    output_message("NEXT_MOVE")
    input = accept_input.to_i
  end

  def draw_board(board)
    string_board = ""
    array_of_cell_values = board.convert_cells_to_array
    array_of_cell_values.each_with_index do |value, index|
      insert_values(value, string_board, index)
      separate_values(string_board, index, board)
    end
    puts string_board
  end

  def insert_values(value, string_board, index)
    value = ' ' if value.nil?
    string_board << value
  end

  def separate_values(string_board, index, board)
    if (index + 1) % board.height != 0
     string_board << "|"
    else
      string_board << "\n"
    end
  end

  def player_loss_response(board)
    puts "#{draw_board(board)} #{LOSS}"
  end

  def draw_response(board)
    puts "#{draw_board(board)} #{DRAW}"
  end

  def play_again_prompt
    output_message("PLAY_AGAIN")
    accept_input
  end

  def change_options_prompt
    output_message("CHANGE_GAME_OPTIONS")
    accept_input
  end

end
