module Chess
  module Pieces
    class Knight < Chess::Pieces::Base

      def to_s
        'N'
      end

      def can_jump?
        true
      end

      def can_move?(vector, kill=false)
        if (vector.dx.abs == 2 && vector.dy.abs == 1) || (vector.dx.abs == 1 && vector.dy.abs == 2)
          true
        else
          false
        end
      end

    end
  end
end
