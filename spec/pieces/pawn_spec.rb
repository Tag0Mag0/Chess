require 'spec_helper'

describe "Chess::Pieces::Pawn" do
  let(:white_pawn) { Chess::Pieces::Pawn.new('White') }
  let(:black_pawn) { Chess::Pieces::Pawn.new('Black') }
  let!(:board) { Chess::Board.new }

  describe "#can_move?(vector, kill = false)" do

    it "white can move down 1" do
      vector = Chess::Vector.new("c4", "c5")
      white_pawn.can_move?(vector).should == true
    end

    it "white can move down 2 on opening move" do
      vector = Chess::Vector.new("f2", "f4")
      white_pawn.can_move?(vector).should == true
    end

    it "white can't move down 2 if they're not in the starting row" do
      vector = Chess::Vector.new("c3", "c5")
      white_pawn.can_move?(vector).should == false
    end

    it "white can't move up" do
      vector = Chess::Vector.new("g4", "g3")
      white_pawn.can_move?(vector).should == false
    end

    it "black can move up 1" do
      vector = Chess::Vector.new("b7", "b6")
      black_pawn.can_move?(vector).should == true
    end

    it "black can move up 2 on opening move" do
      vector = Chess::Vector.new("b7", "b5")
      black_pawn.can_move?(vector).should == true
    end

    it "black can't move up 2 if they're not in the starting row" do
      vector = Chess::Vector.new("h4", "h2")
      black_pawn.can_move?(vector).should == false
    end

    it "black can't move down" do
      vector = Chess::Vector.new("c4", "c5")
      black_pawn.can_move?(vector).should == false
    end

    it "can move straight if they're not making a kill" do
      vector = Chess::Vector.new("c4", "c5")
      white_pawn.can_move?(vector).should == true
    end

    it "cannot move diagonally if they're not making a kill" do
      vector = Chess::Vector.new("c4", "b3")
      black_pawn.can_move?(vector).should == false
    end

    it "can move diagonally if they are making a kill" do
      vector = Chess::Vector.new("c4", "d5")
      white_pawn.can_move?(vector, true).should == true
    end

    it "cannot move straight if they are making a kill" do
      vector = Chess::Vector.new("c5", "c4")
      black_pawn.can_move?(vector, true).should == false
    end

  end
end
