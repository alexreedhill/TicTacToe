require_relative '../ttt.rb'
require_relative '../lib/ai.rb'
require 'spec_helper.rb'

describe 'Ai Service' do
  let(:ai) { Ai.new }
  let(:cells) { Cell.parse_json(Cell::DEFAULT_JSON_CELLS) }

  it 'responds to first move if in middle' do
    cells[4].value = 'X'
    new_cells = ai.check_win('1', cells)
    new_cells[0].value.should == 'O'
  end

  it 'responds to first move if edge' do
    cells[7].value = 'X'
    new_cells = ai.check_win('1', cells)
    new_cells[4].value.should == 'O'
  end

  it 'responds to first move if not in middle' do
    cells[0].value = 'X'
    new_cells = ai.check_win('1', cells)
    new_cells[4].value.should == 'O'
  end

  it 'finds row danger' do
    cells[0].value = 'X'
    cells[1].value = 'X'
    dangerous_cell = ai.check_potential_wins(cells,[cells[0], cells[1]] )
    dangerous_cell.should == cells[2]
  end

  it 'finds column danger' do
    cells[0].value = 'X'
    cells[3].value = 'X'
    dangerous_cell = ai.check_potential_wins(cells,[cells[0], cells[3]] )
    dangerous_cell.should == cells[6]
  end

  it 'finds right_x danger' do
    cells[4].value = 'X'
    cells[2].value = 'X'
    dangerous_cell = ai.check_potential_wins(cells,[cells[2], cells[4]] )
    dangerous_cell.should == cells[6]
  end

  it 'responds to second move if first and last corner taken' do
    cells[0].value = 'X'
    cells[8].value = 'X'
    cells[4].value = 'O'
    new_cells = ai.check_win('2', cells)
    new_cells[5].value.should == 'O'
  end

  it 'responds to second move if middle and corner taken' do
    cells[4].value = 'X'
    cells[8].value = 'X'
    cells[0].value = 'O'
    new_cells = ai.check_win('2', cells)
    new_cells[6].value.should == 'O'
  end

  it 'responds to second move if first two edges taken' do
    cells[1].value = 'X'
    cells[5].value = 'X'
    cells[0].value = 'O'
    new_cells = ai.check_win('2', cells)
    new_cells[2].value.should == 'O'
  end

  it 'responds to second move if last two edges taken' do
    cells[7].value = 'X'
    cells[5].value = 'X'
    cells[0].value = '0'
    new_cells = ai.check_win('2', cells)
    new_cells[8].value.should == 'O'
  end

  it 'responds to second move if 2 Xs in same row' do
    cells[6].value = 'X'
    cells[8].value = 'X'
    cells[4].value = 'O'
    new_cells = ai.check_win('2', cells)
    new_cells[7].value.should == 'O'
  end

  it 'responds to second move if 2 Xs in same column' do
    cells[2].value = 'X'
    cells[8].value = 'X'
    cells[4].value = 'O'
    new_cells = ai.check_win('2', cells)
    new_cells[5].value.should == 'O'
  end

  it 'responds to second move if 2 Xs associated diagonally' do
    cells[4].value = 'X'
    cells[6].value = 'X'
    cells[0].value = 'O'
    new_cells = ai.check_win('2', cells)
    new_cells[2].value.should == 'O'
  end

  it 'responds to second move in top corner and opposite edge optimally by blocking' do
    cells[0].value = 'X'
    cells[7].value = 'X'
    cells[4].value = 'O'
    new_cells = ai.check_win('2', cells)
    new_cells[8].value.should == 'O'
  end

  it 'responds to second move in bottom corner and opposite edge optimally by blocking' do
    cells[8].value = 'X'
    cells[1].value = 'X'
    cells[4].value = 'O'
    new_cells = ai.check_win('2', cells)
    new_cells[2].value.should == 'O'
  end

  it 'responds to third move if 2 Xs in the same row' do
    cells[0].value = 'X'
    cells[3].value = 'X'
    cells[1].value = 'X'
    cells[4].value = 'O'
    cells[6].value = 'O'
    new_cells = ai.check_win('3', cells)
    new_cells[2].value.should == 'O'
  end

  it 'wins with third move if 3 Xs in top corner' do
    cells[0].value = 'X'
    cells[3].value = 'X'
    cells[1].value = 'X'
    cells[4].value = 'O'
    cells[6].value = 'O'
    new_cells = ai.check_win('3', cells)
    new_cells[2].value.should == 'O'
  end

  it 'responds to edge third move optimally if right_x opening for win' do
    cells[1].value = 'X'
    cells[2].value = 'X'
    cells[5].value = 'X'
    cells[0].value = 'O'
    cells[4].value = 'O'
    new_cells = ai.check_win('3', cells)
    new_cells[8].value.should == 'O'
  end

  it 'responds to fourth move by moving adjacent' do
    cells[0].value = 'X'
    cells[8].value = 'X'
    cells[3].value = 'X'
    cells[2].value = 'X'
    cells[4].value = 'O'
    cells[5].value = 'O'
    cells[6].value = 'O'
    new_cells = ai.check_win('4', cells)
    new_cells[1].value.should == 'O'
  end

  it 'responds to right_x danger on fourth move' do
    cells[4].value = 'X'
    cells[3].value = 'X'
    cells[1].value = 'X'
    cells[2].value = 'X'
    cells[0].value = 'O'
    cells[5].value = 'O'
    cells[1].value = 'O'
    new_cells = ai.check_win('4', cells)
    new_cells[6].value.should == 'O'
  end


end
