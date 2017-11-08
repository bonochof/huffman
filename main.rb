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

p tree

