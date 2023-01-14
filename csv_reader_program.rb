require 'csv'

def read_file
  total_orders = CSV.read(ARGV[0].to_s).count

  type_orders = Hash.new(0) 
  type_brand = Hash.new {|h,k| h[k] = Array.new }
  type_most_brand = Hash.new

  CSV.foreach(ARGV[0].to_s) do |row|
    type_orders[row[2]] += row[3].to_i
    type_brand[row[2]].push(row[4])
  end

  type_orders.each do |k,v|
    type_orders[k] = type_orders[k].to_f / total_orders
  end

  type_brand.each do |k,v|
    type_most_brand[k] = v.group_by(&:itself).values.max_by(&:size).first
  end

  first_file_name = "0_" + ARGV[0].to_s

  CSV.open(first_file_name, "w") do |csv|
    type_orders.to_a.each {|elem| csv << elem}
  end

  second_file_name = second_file_name = "1_" + ARGV[0].to_s

  CSV.open(second_file_name, "w") do |csv|
    type_most_brand.to_a.each {|elem| csv << elem}
  end
end

read_file