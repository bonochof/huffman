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

pair = Array.new( 2 )
2.times do |i|
  # sort tree
  tree.sort_by! do |node|
    node[1]
  end
  
  # make pair
  pair[0] = Array.new( tree[0] )
  pair[1] = Array.new( tree[1] )
  
  # change prob
  tree[0][1] = 1.0
  tree[1][1] = 1.0
  
  # push node
  tree.push( ["pair#{i}", pair[0][1]+pair[1][1], pair[0][0], pair[1][0]] )
end

p tree
