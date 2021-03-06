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
    end

    context 'when the size is a 8x8' do
      let(:size) { 8 }
      it 'returns a grid with 8 placed queens that cannot attack each other' do
        expect(subject.solve).to eq(
          [
            [1, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 1],
            [0, 0, 0, 0, 0, 1, 0, 0],
            [0, 0, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 1, 0],
            [0, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 0, 0, 0]
          ]
        )
      end
    end
  end

  describe '#queen_can_be_placed?' do
    let(:board) {
      Array.new(size, Array.new(size, 0))
    }
    context 'when the move is valid for all directions' do
      it 'returns true' do
        expect(subject.queen_can_be_placed?(1,1)).to eq(true)
      end
    end

    context 'when the move is invalid on the row' do
      it 'returns false' do
        subject.board[0] = [1,0,0,0]
        expect(subject.queen_can_be_placed?(0,3)).to eq(false)
      end
    end

    context 'when the move is invalid on the column' do
      it 'returns false' do
        subject.board[0] = [1,0,0,0]
        expect(subject.queen_can_be_placed?(3,0)).to eq(false)
      end
    end

    context 'when the move is invalid diagonally' do
      it 'returns false' do
        subject.board[0] = [1,0,0,0]
        expect(subject.queen_can_be_placed?(1,1)).to eq(false)
      end
    end
  end
end
