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
    attr_accessor :start_position, :end_position
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
    end

    def dy
      start_y = @start_position.split(//).last.to_i
      end_y = @end_position.split(//).last.to_i
      start_y - end_y
    end

    def dx
      start_x_char = @start_position.split(//).first
      start_x_int = character_to_integer(start_x_char)
      end_x_char = @end_position.split(//).first
      end_x_int = character_to_integer(end_x_char)
      end_x_int - start_x_int
    end

    def character_to_integer(character)
      CHAR_TO_INTEGER_HASH.each_key do |key|
        if key == character
          return CHAR_TO_INTEGER_HASH[character]
        end
      end
    end

    def adjacent?
      if dx <= 1 && dy <= 1 && dx >= -1 && dy >= -1 && (dx != 0 || dy != 0)
        true
      else
        false
      end
    end

    def adjacent_position
      if dx == 0 && dy > 0
        @start_position.split(//).first + (@start_position.split(//).last.to_i - 1).to_s
      elsif dx == 0 && dy < 0
        @start_position.split(//).first + (@start_position.split(//).last.to_i + 1).to_s
      elsif dx > 0 && dy == 0
        start_x_char = @start_position.split(//).first
        adjacent_x = character_to_integer(start_x_char) + 1
        CHAR_TO_INTEGER_HASH.key(adjacent_x) + @start_position.split(//).last
      elsif dx < 0 && dy == 0
        start_x_char = @start_position.split(//).first
        adjacent_x = character_to_integer(start_x_char) - 1
        CHAR_TO_INTEGER_HASH.key(adjacent_x) + @start_position.split(//).last
      else
        start_x_char = @start_position.split(//).first
        if dx > 0
          new_x = character_to_integer(start_x_char) + 1
          adjacent_x = CHAR_TO_INTEGER_HASH.key(new_x)
        else
          new_x = character_to_integer(start_x_char) - 1
          adjacent_x = CHAR_TO_INTEGER_HASH.key(new_x)
        end
        if dy > 0
          adjacent_y = (@start_position.split(//).last.to_i - 1).to_s
        else
          adjacent_y = (@start_position.split(//).last.to_i + 1).to_s
        end
        adjacent_x + adjacent_y
      end
    end

    def to_a
      if adjacent_position == @end_position
        return [@end_position]
      else
        [adjacent_position] + Chess::Vector.new(adjacent_position, @end_position).to_a
      end
    end
  end
end
