require 'erb'
require 'csv'

# 1. read the HTML
# 2. apply the data

destinations = []
CSV.foreach("./planet_express_logs.csv", headers: true) do |row|
  destinations << row.to_hash
end

# revenue = []
# CSV.foreach("./planet_express_logs.csv", headers: true) do |col|
#     revenue << col[3].to_i
# end

revenue = destinations.map {|destination| destination["Money"].to_i }

total_revenue = revenue.reduce(:+)

bender = []
fry = []
amy = []
leela = []

destinations.each do |shipment|
  if shipment["Destination"] == "Uranus"
    bender << shipment

  elsif shipment["Destination"] == "Earth"
    fry << shipment

  elsif shipment["Destination"] == "Mars"
    amy << shipment

  else
    leela << shipment
  end
end

bender_total = bender.map {|destination| destination["Money"].to_i }.reduce(:+)
fry_total = fry.map {|destination| destination["Money"].to_i }.reduce(:+)
amy_total = amy.map {|destination| destination["Money"].to_i }.reduce(:+)
leela_total = leela.map {|destination| destination["Money"].to_i }.reduce(:+)

bender_bonus = bender_total * 0.1
fry_bonus = fry_total * 0.1
amy_bonus = amy_total * 0.1
leela_bonus = leela_total * 0.1

b = binding
html = File.read("./report.erb")
the_html = ERB.new(html).result(b)

puts the_html

File.open("./logs.html", "wb") {|f| f << the_html }
