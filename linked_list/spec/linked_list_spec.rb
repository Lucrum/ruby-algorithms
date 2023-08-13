# frozen_string_literal: true

require_relative '../lib/linked_list'

describe 'Linked List' do
  describe 'class methods' do
    linky = LinkedList.new
    it 'appends a value' do
      linky.append(5)
      linky.append(4)
      expect(linky.to_s).to eql('( 5 ) -> ( 4 ) -> nil')
    end
    it 'prepends a value' do
      linky.prepend(3)
      expect(linky.to_s).to eql('( 3 ) -> ( 5 ) -> ( 4 ) -> nil')
    end
    it 'returns its size' do
      expect(linky.size).to eql(3)
    end
    it 'returns the head and tail' do
      expect(linky.head.value).to eql(3)
      expect(linky.tail.value).to eql(4)
    end
    it 'returns the node at the given index' do
      expect(linky.at(1).value).to eql(5)
    end
    it 'pops a value' do
      expect(linky.pop).to eql(4)
      expect(linky.to_s).to eql('( 3 ) -> ( 5 ) -> nil')
    end
    it 'returns true if list contains a value' do
      linky.append(7)
      expect(linky.contains?(7)).to eql(true)
    end
    it 'returns false if list does not contain a value' do
      expect(linky.contains?(900)).to eql(false)
    end
    it 'finds the index of a node containing a value' do
      expect(linky.find(7)).to eql(2)
    end
    it 'returns nil if there is no node containing a value' do
      expect(linky.find(-1)).to eql(nil)
    end
  end
end
