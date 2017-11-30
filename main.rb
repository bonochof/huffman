# coding: utf-8

# display
puts "============ Huffman Coding ============"

# init
sources = Array.new( ARGV )
sources = ["0", "1"] if sources.empty?

# error process
if sources.size < 2
  puts "ERROR: incorrect number of arguments"
  exit
end

# input
puts "INPUT: code1 prob1, code2 prob2, ..."
input = STDIN.gets.split(",")
input.each{ |line| line.strip! }

# init tree
tree = Array.new
order = Array.new
search = Hash.new( 0 )
sum = 0.0
# calc node num
node_num = 0
10.times do |i|
  node_num = ( sources.size - 1 ) * ( i + 1 ) + 1
  break if node_num >= input.size
end
# add supplement node
( node_num - input.size ).times do |i|
  node_name = Time.now.usec.to_s
  init_node = [node_name, 0.0]
  sources.size.times do |i|
    init_node.push( nil )
  end
  tree.push( init_node )
  search[node_name] = 1
end
# add input node
input.each do |pair|
  val = pair.split
  init_node = [val[0], val[1].to_f]
  sources.size.times do |i|
    init_node.push( nil )
  end
  tree.push( init_node )
  order.push( val[0] )
  search[val[0]] = 1
  sum += val[1].to_f
end

# error process
if tree.size < 2 or sum.round(3) != 1.0
  puts "ERROR: invalid argument"
  exit
end

# make tree
i = 0
pair = Array.new( sources.size )
until tree.all?{ |node| node[1] == 1.0 } do
  # sort tree
  tree.sort_by! do |node|
    node[1]
  end
  
  sources.size.times do |j|
    # make pair
    pair[j] = Array.new( tree[j] )
    
    # change prob
    tree[j][1] = 1.0
  end
  
  # make pair node
  pair_node = ["pair#{i}"]
  pair_prob = 0
  sources.size.times do |k|
    pair_prob += pair[k][1]
  end
  pair_node.push( pair_prob.round(3) )
  sources.size.times do |k|
    pair_node.push( pair[k][0] )
  end
  
  # push node
  tree.push( pair_node )
  
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
  back = true
  code = codes[node[0]].clone
  
  # transition to child
  sources.size.times do |i|
    if node[i+2] != nil and visit[node[i+2]] == 0
      search[node[0]] = 1 if i == sources.size - 1
      visit[node[i+2]] = 1
      node = tree.assoc( node[i+2] )
      stack.push( node )
      code << sources[i]
      codes[node[0]] = code.clone
      back = false
      break
    end
  end
  # transition to parent
  if back
    if stack.empty? or search[stack.last[0]] == 1
      node = stack.pop
    else
      node = stack.last
    end
  end
end

# output
length = 0.0
puts
order.each do |c|
  print c, ": ", codes[c], "\n"
  length += codes[c].length
end
puts
print "L = ", length/order.size, "\n"
