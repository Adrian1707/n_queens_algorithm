require 'byebug'
class EightQueens
  attr_accessor :board, :size
  def initialize(size)
    @board = create_board(size)
    @new_board = create_board(size)
    @size = size
  end
  [
    [1,0,0,0],
    [0,0,1,0],
    [0,0,0,0],
    [0,0,0,0]
  ]
  def solve
    board.map!.with_index do |row, row_index|
      row.map.with_index do |cell, column_index|
        if valid_move?(row_index, column_index)
          row[column_index] = 1
        else
          row[column_index] = 0
        end
      end
    end
  end

  def queen_cannot_be_placed?(new_row)
    new_row.sum == 0
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
  # rescue
  #   byebug
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
    Array.new(size, Array.new(size, 0))
  end
end
