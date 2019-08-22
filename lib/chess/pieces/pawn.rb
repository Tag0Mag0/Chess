module Chess
  module Pieces
    class Pawn < Chess::Pieces::Base

      def to_s
        'p'
      end

      def can_move?(vector, kill)
        if color == "White"
          if vector.start_y == 2 && vector.dx == 0 && vector.dy == -2
            true
          elsif vector.dx == 0 && vector.dy == -1 && kill == false
            true
          elsif vector.dx.abs == 1 && vector.dy == -1 && kill # diagonal kill
            true
          else
            false
          end
        else # color == 'Black'
          if vector.start_position[1] == "7" && vector.dx == 0 && vector.dy == 2
            true
          elsif vector.dx == 0 && vector.dy == 1 && kill == false
            true
          elsif vector.dx.abs == 1 && vector.dy == 1 && kill
            true
          else
            false
          end
        end
      end

    end
  end
end
