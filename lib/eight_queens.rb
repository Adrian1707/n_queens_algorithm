class EightQueens
  attr_accessor :board, :size
  def initialize(size)
    @size = size
    @board = Array.new(size) { Array.new(size, 0) }
  end

  def solve(row_number = 0)
    board.map do |row|
      row.map.with_index do |_, column_index|
        if queen_is_placed?(row_number, column_index)
          remove_queen(row_number, column_index)
          next
        end
        place_queen(row_number, column_index)
      end

      solve(row_number - 1) if queen_cannot_be_placed?(row_number)
      return board if all_queens_are_placed?

      row_number += 1
    end
  end

  def queen_cannot_be_placed?(row_number)
    board[row_number].sum == 0
  end

  def all_queens_are_placed?
    board.flatten.sum == size
  end

  def place_queen(row_number, column_index)
    if queen_can_be_placed?(row_number, column_index)
      board[row_number][column_index] = 1
    end
  end

  def remove_queen(row_number, column_index)
    board[row_number][column_index] = 0
  end

  def queen_is_placed?(row_number, column_index)
    board[row_number][column_index] == 1
  end

  def queen_can_be_placed?(row_index, column_index)
    [
      valid_row?(row_index),
      valid_column?(column_index),
      valid_diagonal?(row_index, column_index)
    ].all? { |result| result == true }
  end

  def valid_row?(row_index)
    board[row_index].sum == 0
  end

  def valid_column?(column_index)
    board.transpose[column_index].sum == 0
  end

  def valid_diagonal?(row_index, column_index)
    check_diagonals?(row_index, column_index)
  end

  def check_diagonals?(row_index, column_index)
    [
      check_diagonals_up_left(row_index, column_index),
      check_diagonals_up_right(row_index, column_index),
      check_diagonals_down_left(row_index, column_index),
      check_diagonals_down_right(row_index, column_index)
    ].all? {|sum| sum == 0}
  end

  def check_diagonals_up_left(row_index, column_index)
    return 0 if row_index < 0 || column_index < 0

    cell = board[row_index][column_index]
    cell + check_diagonals_up_left(row_index - 1, column_index - 1)
  end

  def check_diagonals_up_right(row_index, column_index)
    return 0 if row_index < 0 || column_index > size - 1

    cell = board[row_index][column_index]
    cell + check_diagonals_up_right(row_index - 1, column_index + 1)
  end

  def check_diagonals_down_left(row_index, column_index)
    return 0 if row_index > size - 1 || column_index < 0

    cell = board[row_index][column_index]
    cell + check_diagonals_down_left(row_index+1, column_index - 1)
  end

  def check_diagonals_down_right(row_index, column_index)
    return 0 if row_index > size - 1 || column_index > size - 1

    cell = board[row_index][column_index]
    cell + check_diagonals_down_right(row_index+1, column_index + 1)
  end
end
