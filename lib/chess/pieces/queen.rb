module Chess
  module Pieces
    class Queen < Chess::Pieces::Base

      def to_s
        'Q'
      end

      def can_move?(vector, kill=false)
        if (vector.dx.abs == vector.dy.abs) ||
           (vector.dx == 0 && vector.dy.abs > 0) ||
           (vector.dy == 0 && vector.dx.abs > 0)
          true
        else
          false
        end
      end

    end
  end
end
