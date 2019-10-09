class Game 
  attr_accessor :board, :player_1, :player_2
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]
  
  def initialize(player_1 = "X", player_2 = "O", board = Board.new)
    player_1.is_a?(Player) ? @player_1 = player_1 : @player_1 = Players::Human.new(player_1)
    
    player_2.is_a?(Player) ? @player_2 = player_2 : @player_2 = Players::Human.new(player_2)
    @board = board 
  end 
  
  def current_player 
    @board.turn_count.even? ? @player_1 : @player_2
  end 
  
  def won?
    WIN_COMBINATIONS.detect {|array| array.all? {|position| @board.cells[position] == "X"} || array.all? {|position| @board.cells[position] == "O"}} 
  end 
  
  def draw?
    !won? && @board.full?
  end 
  
  def over?
    draw? || won? 
  end 
  
  def winner 
    if won? 
      if WIN_COMBINATIONS.any? {|array| array.all? {|index| @board.cells[index] == "X"}}
        "X"
      else 
        "O"
      end 
    end 
  end 
  
  def turn 
    player = current_player
    index = player.move(@board).to_i 
    
    if @board.valid_move?(index) && !@board.taken?(index)
      @board.update(index, player)
      @board.display 
    else 
      turn 
    end 
  end 
  
  def play 
    turn until over? 
    
    if won? 
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end 
  end 

end 