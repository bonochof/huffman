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

i = 0
pair = Array.new( 2 )
until tree.all?{ |node| node[1] == 1.0 } do
  # sort tree
  tree.sort_by! do |node|
    node[1]
  end
  
  2.times do |j|
    # make pair
    pair[j] = Array.new( tree[j] )
    
    # change prob
    tree[j][1] = 1.0
  end
  
  # push node
  tree.push( ["pair#{i}", (pair[0][1]+pair[1][1]).round(1), pair[0][0], pair[1][0]] )
  
  # increment
  i += 1
end

p tree
