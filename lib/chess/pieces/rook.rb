module Chess
  module Pieces
    class Rook < Chess::Pieces::Base

      def to_s
        'R'
      end

      def can_move?(vector, kill=false)
        if (vector.dx == 0 && vector.dy.abs > 0) ||
           (vector.dy == 0 && vector.dx.abs > 0)
          true
        else
          false
        end
      end

    end
  end
end
