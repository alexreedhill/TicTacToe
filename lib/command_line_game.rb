require_relative '../lib/command_line_interface'

class CommandLineGame

  def initialize(ai, cli, ttt)
    @ai = ai
    @cli = cli
    @ttt = ttt
  end

  def run
    @cli.output_message('GREETING')
    input = @cli.accept_input
    start_game(input)
  end
  
  def start_game(input)
    unless input == 'n' || input == 'no'
      get_game_options
      human_move
    else
      @cli.output_message('FAREWELL')
      abort
    end
  end

  def get_game_options
    params = {:interface => 'command line'}
    params[:ai] = get_ai_type
    params[:board_height] = get_board_height
    params[:first_player_name] = get_first_player_name
    params[:human_value] = get_human_value
    @game_state = @ttt.configure_game_type(params)
    first_turn(params)
  end

  def get_ai_type
    @cli.output_message('AI_TYPE')
    input = @cli.accept_input
    if input == 1
     'non-minimax'
    else
     'minimax'
    end 
  end

  def get_board_height
    @cli.output_message('BOARD_HEIGHT')
    @cli.accept_input.to_i
  end

  def get_first_player_name
    @cli.output_message("FIRST_PLAYER_NAME")
    input = @cli.accept_input
    if input == "0"
      'ai'
    else
      'human'
    end
  end

  def get_human_value
    @cli.output_message("HUMAN_VALUE")
    @cli.accept_input.upcase
  end

  def first_turn(params)
    if params[:first_player_name] == 'ai' 
      ai_move
    else
      human_move
    end
  end

  def human_move
    @cli.draw_board(@game_state) 
    @cli.output_message("NEXT_MOVE")
    user_input = @cli.accept_input.to_i
    if @game_state.cell_empty?(user_input)
      @game_state = @game_state.initialize_next_game_state(user_input)  
      ai_move
    else
      @cli.output_message("INVALID_MOVE")
      human_move
    end
  end

  def ai_move
    next_move = @ai.next_move(@game_state)
    @game_state = next_move unless next_move.nil?
    if @game_state.final_state?
      game_over
      return
    else
      @game_state.switch_current_player
      human_move
    end
  end

  def game_over      
    winning_cell_results = @game_state.get_winning_cells
    if winning_cell_results
      puts "#{@cli.draw_board(@game_state)} Game over, you lose!"
    elsif @game_state.draw?(winning_cell_results)
      puts "#{@cli.draw_board(@game_state)} The game ended in a draw"
    end
  end
end
