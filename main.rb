# coding: utf-8

puts "============ Huffman Coding ============"

# input
puts "INPUT: code1 prob1, code2 prob2, ..."
input = gets.split(",")
input.each{ |line| line.strip! }

# init tree
tree = Array.new
input.each do |pair|
  val = pair.split
  tree.push( [val[0], val[1].to_f, nil, nil] )
end

# sort tree
tree[0].sort! do |a, b|
  b[1] <=> a[1]
end

# make pair
pair = Array.new( 2 )
pair[0] = tree[-1]
pair[1] = tree[-2]
tree[1].push( ["pair0", pair[0][1]+pair[1][1], pair[0][0], pair[1][0]] )

p tree
