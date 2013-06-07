module Chess
  module Pieces
    class Base
      attr_accessor :row, :col, :color

      def initialize(color)
        @color = color
      end

      def to_s
        "x"
      end

      def can_move?(vector, kill=false)
        raise "#{self.class} has not implemented the can_move? method."
      end

      def can_jump?
        false
      end

    end
  end
end
