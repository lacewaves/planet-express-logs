require 'erb'
require 'csv'

# 1. read the HTML
# 2. apply the data

destinations = []
CSV.foreach("./planet_express_logs.csv", headers: true) do |row|
  destinations << row.to_hash
end

revenue = []
CSV.foreach("./planet_express_logs.csv", headers: true) do |col|
    revenue << [col[3]].reduce(:+).to_i
end

total_revenue = revenue.reduce(:+)

b = binding
html = File.read("./report.erb")
the_html = ERB.new(html).result(b)

puts the_html

File.open("./logs.html", "wb") {|f| f << the_html }
