module Chess
  module Pieces
    class Pawn < Chess::Pieces::Base

      def to_s
        'p'
      end

      def can_move?(vector, kill=false)
        if color == "White"
          if vector.start_position.split(//).last == "2" &&
             (vector.dx == 0 && (vector.dy <= -2 && vector.dy < 0))
            true
          elsif vector.dx == 0 && (vector.dy >= -1 && vector.dy < 0) && kill == false
            true
          elsif (vector.dx == -1 || vector.dx == 1) && vector.dy == -1 && kill # diagonal kill
            true
          else
            false
          end
        else # color == 'Black'
          if vector.start_position.split(//).last == "7" &&
             (vector.dx == 0 && (vector.dy <= 2 && vector.dy > 0))
            true
          elsif vector.dx == 0 && (vector.dy <= 1 && vector.dy > 0) && kill
            false
          elsif (vector.dx == -1 || vector.dx == 1) && vector.dy == 1 && kill
            true
          else
            false
          end
        end
      end

    end
  end
end
