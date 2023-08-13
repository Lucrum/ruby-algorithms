# frozen_string_literal: true

require_relative '../../lib/utils'

def merge_sort(arr)
  if arr.length < 2
    arr
  else
    left, right = split_array_half(arr)
    merge(merge_sort(left), merge_sort(right))
  end
end

def merge(left, right)
  res = []
  until left.empty? && right.empty?
    if left.empty? && !right.empty?
      res += right
      right.clear
    elsif !left.empty? && right.empty?
      res += left
      left.clear
    elsif !left.empty? && !right.empty?
      if left[0] > right[0]
        res.append(right.shift)
      else
        res.append(left.shift)
      end
    end
  end
  res
end
