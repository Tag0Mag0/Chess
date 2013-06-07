### This class is responsible for modeling movement between
#   two coordinates on a chess board.
#
#   Internally, it will translate pairs of coordinates
#   like "b3", "c4" into numerical coordinates, so that
#   we can calculate the change in the x plane and the
#   change in the y plane.
#
#   Required methods:
#
#   dx -> Integer
#   The change in the X coordinate plane that this move involves.
#
#   dy -> Integer
#   The change in the Y coordinate plane that this move involves.
#
#   to_a -> Array of coordinate strings: for example ["e4", "e5", "e6"]
#   This represents the path between the starting and ending coordinates.
#   For example
#
#       Vector.new("c1", "c4").to_a  # => ["c2", "c3"]
#
#
#
module Chess
  class Vector
    attr_reader :start_position, :end_position, :dx, :dy, :start_y
    CHAR_TO_INTEGER_HASH = {
      "a" => 1,
      "b" => 2,
      "c" => 3,
      "d" => 4,
      "e" => 5,
      "f" => 6,
      "g" => 7,
      "h" => 8
    }

    def initialize(start_position, end_position)
      @start_position = start_position
      @end_position = end_position
      @start_x = CHAR_TO_INTEGER_HASH[@start_position[0]]
      @start_y = @start_position[1].to_i
      @end_x = CHAR_TO_INTEGER_HASH[@end_position[0]]
      @end_y = @end_position[1].to_i
      @dx = @end_x - @start_x
      @dy = @start_y - @end_y
    end

    def adjacent?
      if dx <= 1 && dy <= 1 && dx >= -1 && dy >= -1 && (dx != 0 || dy != 0)
        true
      else
        false
      end
    end

    def adjacent_position
      CHAR_TO_INTEGER_HASH.key(adjacent_x) + adjacent_y.to_s
    end

    def adjacent_x
      return @start_x if dx == 0
      return @start_x + 1 if dx > 0
      return @start_x - 1 if dx < 0
    end

    def adjacent_y
      return @start_y if dy == 0
      return @start_y - 1 if dy > 0
      return @start_y + 1 if dy < 0
    end

    def to_a
      @vector_array ||= if adjacent_position == @end_position
                          [@end_position]
                        else
                          [adjacent_position] + Chess::Vector.new(adjacent_position, @end_position).to_a
                        end
    end
  end
end
