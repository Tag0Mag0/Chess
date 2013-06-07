require 'spec_helper'

describe "Chess::Pieces::King" do
  let(:king) { Chess::Pieces::King.new('Black') }

  describe "#can_move?(vector)" do
    it "can move 1 up and 1 over" do
      vector = Chess::Vector.new("a3", "b2")
      king.can_move?(vector).should == true
    end

    it "can move 1 down and 0 over" do
      vector = Chess::Vector.new("e3", "e4")
      king.can_move?(vector).should == true
    end

    it "can move 0 down and 1 over" do
      vector = Chess::Vector.new("g5", "f5")
      king.can_move?(vector).should == true
    end

    it "cannot move 2 over" do
      vector = Chess::Vector.new("h1", "e1")
      king.can_move?(vector).should == false
    end

    it "cannot move 5 down" do
      vector = Chess::Vector.new("d2", "d7")
      king.can_move?(vector).should == false
    end
  end

end
