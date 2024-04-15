class SismicDataService

  def self.fetch_and_save_data

    current_date = Date.today.strftime("%Y-%m-%d")
    # Fetching data from USGS API for #{current_date}...

    url = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=#{current_date}"
    # URL

    uri = URI.parse(url)
    # URI object
    #begin
    response = Net::HTTP.get_response(uri)
      # Resto del código...
    #rescue => e
      #puts "Error al realizar la solicitud HTTP: #{e.message}"
    #end
    #response = Net::HTTP.get_response(uri)
    # Response to Get

    if response.is_a?(Net::HTTPSuccess)
      # Request to USGS API successful
      data = JSON.parse(response.body)
      features = data['features']
      # Set features to the data['features']

      features.each do |obj|
        external_id = obj['id']
        existing_obj = Feature.find_by(external_id: external_id)

        unless existing_obj

          Feature.create(
            external_id: external_id,
            magnitude: obj['properties']['mag'],
            place: obj['properties']['place'],
            time: obj['properties']['time'],
            tsunami: obj['properties']['tsunami'],
            mag_type: obj['properties']['magType'],
            title: obj['properties']['title'],
            longitude: obj['geometry']['coordinates'][0],
            latitude: obj['geometry']['coordinates'][1],
            external_url: obj['properties']['url']
          )
        end
      end
    end
  end

end
