module Chess
  module Pieces
    class King < Chess::Pieces::Base

      def to_s
        'K'
      end

      def can_move?(vector, kill=false)
        if vector.dx.abs <= 1 && vector.dy.abs <= 1
          true
        else
          false
        end
      end

    end
  end
end
