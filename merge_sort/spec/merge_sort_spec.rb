# frozen_string_literal: true

require_relative '../lib/merge_sort'

describe 'Merge Sort' do
  describe 'sort' do
    it 'sorts a list' do
      unsorted = [7, 8, 2, 4, 1, 5, 0, 9, 6]
      expect(merge_sort(unsorted)).to eql([0, 1, 2, 4, 5, 6, 7, 8, 9])
    end
    it 'sorts a reversed list' do
      unsorted = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
      expect(merge_sort(unsorted)).to eql([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    end
    it 'returns an empty list if array is empty' do
      expect(merge_sort([])).to eql([])
    end
  end
end
