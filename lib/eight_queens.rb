class EightQueens
  attr_accessor :board, :size
  def initialize(size)
    @board = create_board(size)
    @size = size
    @backtracks = 0
  end

  def solve(row_number = 0)
    board.map.with_index do |row, row_index|
      row.map.with_index do |cell, column_index|
        if board[row_number][column_index] == 1
          board[row_number][column_index] = 0
          next
        end

        if valid_move?(row_number, column_index)
          board[row_number][column_index] = 1
        end
      end

      solve(row_number - 1) if queen_cannot_be_placed?(row_number)
      return board if board.flatten.sum == size

      row_number += 1
    end
  end

  def queen_cannot_be_placed?(row_number)
    board[row_number].sum == 0
  end

  def valid_move?(row_index, column_index)
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
    up_left = check_diagonals_up_left(row_index, column_index)
    up_right = check_diagonals_up_right(row_index, column_index)
    down_left = check_diagonals_down_left(row_index, column_index)
    down_right = check_diagonals_down_right(row_index, column_index)
    [up_left, up_right, down_left, down_right].all? {|sum| sum == 0}
  end

  private

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

  def create_board(size)
    Array.new(size) { Array.new(size, 0) }
  end
end
