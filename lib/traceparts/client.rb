require 'faraday'
require 'json'
require 'traceparts/catalog'
require 'traceparts/product'

module Traceparts
  class Client
    API_BASE = 'http://ws.tracepartsonline.net'
    WEB_SERVICE_PATH = '/tpowebservices'

    def initialize(api_key)
      @api_key = api_key

      @connection = Faraday.new(url: API_BASE) do |faraday|
        faraday.adapter(Faraday.default_adapter)
      end
    end

    def catalogs
      response = get_request("#{WEB_SERVICE_PATH}/CatalogsList")

      response = JSON.parse(response.body)

      response['classificationList'].map { |catalog| Catalog.new(catalog, self) }
    end

    def products(catalog_id, category_path = nil)
      response = get_request("#{WEB_SERVICE_PATH}/ProductsList", { 'ClassificationID' => catalog_id, 'Path' => category_path })

      response = JSON.parse(response.body)

      response['productList'].map { |product| Product.new(product, self) }
    end

    private

    def get_request(endpoint, params = {})
      @connection.get(endpoint, default_params.merge(params))
    end

    def post_request(endpoint, params = {})
      @connection.post(endpoint, default_params.merge(params))
    end

    def default_params
      {
        'ApiKey' => @api_key,
        'Format' => 'json'
      }
    end
  end
end
