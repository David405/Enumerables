# frozen_string_literal: true

require_relative '../enumerable.rb'

RSpec.describe Enumerable do
  describe 'my_each' do
    let(:array) { [1, 2, 3, 4] }

    it 'returns the original array' do
      expect(array.my_each { |element| element }).to eql(0...4)
    end

    it 'returns an enumerable if no code block is given' do
      expect(array.my_each).to be_a(Enumerable)
    end
  end

  describe 'my_select' do
    let(:array) { [1, 2, 3, 4, 5, 6] }

    it 'returns all items for which the given block returns a true value' do
      expect(array.my_select { |element| element > 3 }).to eql([4, 5, 6])
    end
  end

  describe 'my_all?' do
    context 'when code block is given' do
      it 'returns true if the block never returns false or nil' do
        expect([1, 2, 3].my_all? { |element| element > 0 }).to eql(true)
      end
    end

    context 'when code block is given' do
      it 'returns false if the block returns any falsy value' do
        expect([1, 2, 3].my_all? { |element| element > 1 }).to eql(false)
      end
    end

    context 'when no code block is given' do
      it 'returns false if any of the elements are false or nil' do
        expect([1, 2, nil].my_all?).to eql(false)
      end
    end
  end

  describe 'my_any?' do
    context 'when code block is given' do
      it 'returns true if the block ever return a true value' do
        expect([1, 2, 3].my_any? { |element| element > 2 }).to eql(true)
      end
    end

    context 'when code block is given' do
      it 'returns false if the block does not return any true value' do
        expect([1, 2, 3].my_any? { |element| element > 4 }).to eql(false)
      end
    end

    context 'when no code block is given' do
      it 'returns true if any of the elements are true' do
        expect([nil, false, 99].my_any?).to eql(true)
      end
    end
  end

  describe 'my_count' do
    let(:array) { [1, 2, 3, 2] }

    context 'when no code block is given' do
      it 'returns the number of elements' do
        expect(array.my_count).to eql(4)
      end
    end

    context 'when an argument is given' do
      it 'returns the number of elements which are equal to the argument' do
        expect(array.my_count(2)).to eql(2)
      end
    end

    context 'when code block is given' do
      it 'returns the number of elements for which the block returns a true value' do
        expect(array.my_count { |element| element >= 2 }).to eql(3)
      end
    end
  end

  describe 'my_inject' do
    let(:array) { [3, 6, 10, 13] }

    context 'when code block is given without any argument' do
      it 'passes each element and accumulates the sum sequentially' do
        expect(array.my_inject { |sum, number| sum + number }).to eql(32)
      end
    end

    context 'when code block is given without any argument' do
      it 'passes each element and accumulates the product sequentially' do
        expect(array.my_inject { |prod, number| prod * number }).to eql(2340)
      end
    end

    context 'when code block and an argument are given' do
      it 'accumulates the sum sequentially using the argument as base' do
        expect(array.my_inject(5) { |sum, number| sum + number }).to eql(37)
      end
    end

    context 'when code block and an argument are given' do
      it 'accumulates the product sequentially using the argument as base' do
        expect(array.my_inject(5) { |sum, number| sum * number }).to eql(11_700)
      end
    end
  end
end
