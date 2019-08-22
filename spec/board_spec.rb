require 'spec_helper'

# A new chess piece that we made up for testing out the movement rules.
# Octopi are very quick.  They can move anywhere.
class Chess::Pieces::Octopus < Chess::Pieces::Base
  def to_s; 'o'; end
  def can_move?(vector, kill = false)
    true
  end
end

describe Chess::Board do
  # HI
  let(:board) { Chess::Board.new }

  it "can generate a string representation of a new board" do
    str = Chess::Board.new.to_s
    str.gsub!(/\e\[\d*m/, '') # take out color codes
    str.should include(<<-'board'.strip)
    a b c d e f g h
 1  R N B K Q B N R
 2  p p p p p p p p
 3  . . . . . . . .
 4  . . . . . . . .
 5  . . . . . . . .
 6  . . . . . . . .
 7  p p p p p p p p
 8  R N B K Q B N R
board
  end

  describe "#move" do
    let(:white_octopus) { Chess::Pieces::Octopus.new("White") }
    let(:white_pawn) { Chess::Pieces::Pawn.new("White") }
    let(:black_octopus) { Chess::Pieces::Octopus.new("Black") }

    it "complains if you try to move a position without any pieces on it" do
      board.move("c6", "c7").should == false
    end

    it "complains if you try to move a piece onto itself" do
      board.set_piece("c6", white_octopus)
      board.move("c6", "c6").should == false
    end

    it "complains if you can't jump and you try to move through a piece" do
      board.set_piece("c6", white_octopus)
      board.set_piece("d6", white_pawn)
      board.move("c6", "e6").should == false
    end

    it "lets you capture an enemy piece" do
      board.set_piece("c6", white_octopus)
      board.set_piece("d6", black_octopus)
      board.move("c6", "d6").should == true
    end

    it "removes enemy pieces from the board when you land on them" do
      board.set_piece("c6", white_octopus)
      board.set_piece("d6", black_octopus)
      board.move("c6", "d6")
      board.get_piece("d6").should == white_octopus
    end

    it "doesn't let you play a piece if it's not your turn" do
      board.set_piece("c6", white_octopus)
      board.set_piece("f6", black_octopus)
      board.move("f6", "e6").should == false  # black tries to take the first turn
      board.move("c6", "b5").should == true  # white moves successfully
      board.move("b5", "b6").should == false  # white tries to take a second turn
    end

    it "doesn't let you land on your own pieces" do
      board.set_piece("c6", white_octopus)
      board.set_piece("d5", white_pawn)
      board.move("c6", "d5").should == false
    end

    it "removes the piece from the old position" do
      pawn = Chess::Pieces::Pawn.new('White')
      board.set_piece("a3", pawn)
      board.move("a3", "a4")
      board.get_piece("a3").should == nil
    end
  end

  describe "#get_piece" do
    it "returns the piece at the coordinates indicated" do
      piece = board.get_piece("a2")  # white pawn
      piece.color.should == "White"
      piece.to_s.should == 'p'
    end

    it "returns nil if there's nothing there" do
      board.get_piece("e4").should == nil
    end

    it "is idempotent" do
      pawn = board.get_piece("a2")
      pawn.should == board.get_piece("a2")
    end
  end

  describe "#set_piece" do
    let(:pawn) { board.get_piece("a2") }
    it "puts the piece in the new position" do
      board.get_piece("a3").should == nil
      board.set_piece("a3", pawn)
      board.get_piece("a3").should == pawn
    end

  end

  describe "#remove piece" do
    it "removes a piece from a specific location" do
      board = Chess::Board.new
      pawn = board.get_piece("a2")
      pawn.class.should == Chess::Pieces::Pawn
      board.remove_piece("a2")
      board.get_piece("a2").should == nil
    end
  end

  describe "turns" do
    it "knows it's White's turn when the game starts" do
      board.turn.should == "White"
    end

    it "knows it's Black's turn after White makes a move" do
      board.move("a2", "a3")  # moving a pawn one space
      board.turn.should == "Black"
    end

    it "knows it's still White's turn after attempting an invalid move" do
      board.move("a2", "e6")  # trying to move a pawn way across the board
      board.turn.should == "White"
    end

  end

end
