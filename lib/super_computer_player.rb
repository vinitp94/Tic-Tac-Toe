require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    root = TicTacToeNode.new(game.board, mark)
    all_children = root.children
    winning = all_children.find { |child| child.winning_node?(mark) }
    return winning.prev_move_pos if winning

    opp_mark = mark == :x ? :o : :x

    to_block = all_children.find? { |child| child.winning_node?(opp_mark) }
    to_block

    # to_block = []
    # all_children.each do |child|
    #   to_block = child.children.select do |opp_child|
    #     opp_child.winning_node?(opp_mark)
    #   end
    # end
    #
    # all_children.delete_if do |child|
    #   to_block.include?(child)
    # end
    #
    # all_children.sample.prev_move_pos

    # not_losing = root.children.find { |child| !child.losing_node?(mark) }
    # not_losing.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
