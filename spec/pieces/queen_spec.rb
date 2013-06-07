require 'spec_helper'

describe "Chess::Pieces::Queen" do
  let(:queen) { Chess::Pieces::Queen.new('White') }

  describe "#can_move?(vector)" do
    it "can move 3 over and 3 down" do
      vector = Chess::Vector.new("b4", "e7")
      queen.can_move?(vector).should == true
    end
    it "can move 5 over and 0 down" do
      vector = Chess::Vector.new("b3", "g3")
      queen.can_move?(vector).should == true
    end
    it "can move 0 over and 2 up" do
      vector = Chess::Vector.new("e4", "e2")
      queen.can_move?(vector).should == true
    end
    it "cannot move 1 over and 2 up" do
      vector = Chess::Vector.new("c4", "d2")
      queen.can_move?(vector).should == false
    end
  end
end
