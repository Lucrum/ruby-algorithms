def split_array_half(arr)
  arr.each_slice((arr.length / 2.0).round).to_a
end
