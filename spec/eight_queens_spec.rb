require 'spec_helper'
require 'eight_queens'
require 'byebug'
describe EightQueens do
  subject { described_class.new(size)}
  let(:size) { 4 }

  describe '#board' do
    it 'displays a 4x4 board' do
      expect(subject.board).to eq(
        [
          [0,0,0,0],
          [0,0,0,0],
          [0,0,0,0],
          [0,0,0,0]
        ]
      )
    end
  end

  describe '#solve' do
    context 'when size is 4x4' do
      it 'returns a grid with 4 placed queens that cannot attack each other' do
        expect(subject.solve).to eq(
          [
            [0,1,0,0],
            [0,0,0,1],
            [1,0,0,0],
            [0,0,1,0]
          ]
        )
      end

      it 'returns a grid with 3 placed queens that cannot attack each other' do
        expect(subject.solve).to eq(
          [
            [1,0,0,0],
            [0,0,1,0],
            [0,0,0,0],
            [0,1,0,0]
          ]
        )
      end

      xit 'sums the flattened board to the size provided on initialization' do
        subject.solve
        expect(subject.board.flatten.sum).to eq(4)
      end
    end
  end

  describe '#valid_move?' do
    let(:board) {
      Array.new(size, Array.new(size, 0))
    }
    context 'when the move is valid for all directions' do
      it 'returns true' do
        expect(subject.valid_move?(1,1)).to eq(true)
      end
    end

    context 'when the move is invalid on the row' do
      it 'returns false' do
        subject.board[0] = [1,0,0,0]
        expect(subject.valid_move?(0,3)).to eq(false)
      end
    end

    context 'when the move is invalid on the column' do
      it 'returns false' do
        subject.board[0] = [1,0,0,0]
        expect(subject.valid_move?(3,0)).to eq(false)
      end
    end

    context 'when the move is invalid diagonally' do
      it 'returns false' do
        subject.board[0] = [1,0,0,0]
        expect(subject.valid_move?(1,1)).to eq(false)
      end
    end
  end
end
