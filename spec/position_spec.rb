require 'spec_helper'

describe Chess::Position do
  describe "::new" do

    it "parses out row information" do
      Chess::Position.new("e4").row.should == 4
    end

    it "parses out column information" do
      Chess::Position.new("h6").column.should == "h"
    end

    it "stores numerical x coordinate for the column" do
      Chess::Position.new("a3").x.should == 1
    end

    it "stores numerical y coordinate for the row" do
      Chess::Position.new("d6").y.should == -6
    end

    it "raises an error if the column is too high" do
      lambda{Chess::Position.new("j3")}.should raise_exception(Chess::Position::OutOfBoundsError)
    end

    it "raises an error if the row is too low" do
      lambda{Chess::Position.new("e0")}.should raise_exception(Chess::Position::OutOfBoundsError)
    end

    it "raises an error if the row is too high" do
      lambda{Chess::Position.new("e9")}.should raise_exception(Chess::Position::OutOfBoundsError)
    end


    it "raises an error if the argument is too long" do
      lambda{Chess::Position.new("hello chickens")}.should raise_exception(Chess::Position::BadArgumentError)
    end

    it "raises an error if the argument is too short" do
      lambda{Chess::Position.new("a")}.should raise_exception(Chess::Position::BadArgumentError)
    end
  end

  describe "#to_s gives you back two-character position notation" do
    it "a3" do
      Chess::Position.new("a3").to_s.should == "a3"
    end

    it "f1" do
      Chess::Position.new("f1").to_s.should == "f1"
    end
  end

  describe "::valid?" do
    it "returns false if the string is too long" do
      Chess::Position.valid?("abc").should == false
    end

    it "returns false if the string is too short" do
      Chess::Position.valid?("1").should == false
    end

    it "returns false if the first character is not in the range a-h" do
      Chess::Position.valid?("j2").should == false
    end

    it "returns false if the second character is not in the range 1-8" do
      Chess::Position.valid?("c9").should == false
    end

    it "accepts a4" do
      Chess::Position.valid?("a4").should == true
    end

    it "accepts h7" do
      Chess::Position.valid?("h7").should == true
    end

    it "accepts c1" do
      Chess::Position.valid?("c1").should == true
    end
  end
end
