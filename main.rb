# coding: utf-8

puts "============ Huffman Coding ============"

# input
puts "INPUT: code1 prob1, code2 prob2, ..."
input = gets.split(",")
input.each{ |line| line.strip! }

# init tree
tree = Array.new
order = Array.new
input.each do |pair|
  val = pair.split
  tree.push( [val[0], val[1].to_f, nil, nil] )
  order.push( val[0] )
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
  tree.push( ["pair#{i}", (pair[0][1]+pair[1][1]).round(3), pair[0][0], pair[1][0]] )
  
  # increment
  i += 1
end

# trace node
stack = Array.new
visit = Hash.new( 0 )
codes = Hash.new( "" )
code = String.new
node = tree[-1]
stack.push( node )
until node == nil do
  code = codes[node[0]].clone
  # transition to child1
  if node[2] != nil and visit[node[2]] == 0
    visit[node[2]] = 1
    node = tree.assoc( node[2] )
    stack.push( node )
    code << "0"
    codes[node[0]] = code.clone
  # transition to child2
  elsif node[3] != nil and visit[node[3]] == 0
    visit[node[3]] = 1
    node = tree.assoc( node[3] )
    stack.push( node )
    code << "1"
    codes[node[0]] = code.clone
  # transition to parent
  else
    node = stack.pop
  end
end

order.each do |c|
  print c, ": ", codes[c], "\n"
end
