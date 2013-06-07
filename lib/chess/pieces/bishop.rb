module Chess
  module Pieces
    class Bishop < Chess::Pieces::Base

      def to_s
        'B'
      end

      def can_move?(vector, kill=false)
        if vector.dx.abs == vector.dy.abs
          true
        else
          false
        end
      end

    end
  end
end
