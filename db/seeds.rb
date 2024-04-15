require 'net/http'
require 'open-uri'
require 'json'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

puts "Cleaning up database..."
Comment.delete_all
Feature.delete_all
# Feature.destroy_all
puts "Database cleaned"

current_date = Date.today.strftime("%Y-%m-%d")
puts "Fetching data from USGS API for #{current_date}..."

api = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=#{current_date}"
puts "URL"

uri = URI.parse(api)
puts "URI"
response = Net::HTTP.get_response(uri)
puts "Response: #{response}"

if response.is_a?(Net::HTTPSuccess)
  puts "Request to USGS API successful"
  data = JSON.parse(response.body)

  puts "Data"
  i = 0
  features = data['features']
  features.each do |obj|
    puts "Object: #{ i+=1}"
    external_id = obj['id']
    existing_obj = Feature.find_by(external_id: external_id)

    unless existing_obj
      puts "Creating new Feature..."
      puts "External ID: #{external_id}"
      attributes = {
        external_id: external_id,
        magnitude: obj["properties"]["mag"],
        place: obj["properties"]["place"],
        time: obj["properties"]["time"],
        tsunami: obj["properties"]["tsunami"],
        mag_type: obj["properties"]["magType"],
        title: obj["properties"]["title"],
        longitude: obj["geometry"]["coordinates"][0],
        latitude: obj["geometry"]["coordinates"][1],
        external_url: obj["properties"]["url"]
      }

      Feature.new(attributes)
    end
    puts "Feature created"
  end
  puts "Data fetched and saved successfully"
else
  puts "Failed to fetch data from #{url}"
end
