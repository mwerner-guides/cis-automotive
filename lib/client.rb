require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class APIClient
  HOST = 'cis-automotive.p.rapidapi.com'.freeze
  API_KEY = '3c0_your_api_key_b9f'.freeze

  def sale_prices(brand)
    content = get("/salePrice", brandName: brand)
    content[:data].map! {|entry| SalePrice.new(entry) }
  end

  def list_prices(brand)
    content = get("/listPrice", brandName: brand)
    content[:data].map! {|entry| ListPrice.new(entry) }
  end

  def days_to_sell(brand)
    content = get("/daysToSell", brandName: brand)
    content[:data].map! {|entry| DaysToSell.new(entry) }
  end

  private

  def get(path, params)
    response = request(path, {regionName: 'REGION_STATE_CA'}.merge(params))
    content = JSON.parse(response.read_body, symbolize_names: true)
  end

  def request(path, params)
    url = URI("https://#{HOST}#{path}")
    url.query = URI.encode_www_form(params)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = HOST
    request["x-rapidapi-key"] = API_KEY
    response = http.request(request)
  end
end
