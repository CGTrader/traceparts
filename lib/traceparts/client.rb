require 'faraday'
require 'json'
require 'traceparts/catalog'
require 'traceparts/product'
require 'traceparts/category'
require 'traceparts/part'
require 'traceparts/part_details'
require 'traceparts/cad_format'
require 'traceparts/user'

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
      json_catalogs['classificationList'].map { |catalog| Catalog.new(self, catalog) }
    end

    def categories(classification_id)
      json_categories(classification_id)['categorieList'].map { |category| Category.new(self, category) }
    end

    # Returns product family id's for specified page
    def page_products(classification_id, category_path = nil, page = 1)
      json = json_products(classification_id, category_path, page)

      products_present?(json) ? bind_products(json) : []
    end

    # Returns all product family id's available
    def products(catalog_id, category_path = nil)
      page = 1
      all_products = []

      while (products_for_page = page_products(catalog_id, category_path, page)).any? do
        all_products.push(*products_for_page)

        page += 1
      end

      all_products
    end

    def part_details(classification_id, part_number, user_email)
      json = json_part_details(classification_id, part_number, user_email)

      PartDetails.new(json)
    end

    def available_formats(classification_id, part_number, user_email)
      json = json_available_formats(classification_id, part_number, user_email)

      json.map { |format| CadFormat.new(self, format) }
    end

    def download_archive_link(classification_id, part_number, cad_format_id, user_email)
      response = get_request('DownloadCADPath', {
        'PartNumber' => part_number,
        'ClassificationID' => classification_id,
        'CADFormatID' => cad_format_id,
        'UserEmail' => user_email
      })

      json = JSON.parse(response.body)

      return if json.is_a?(Hash)

      json[1][0][1]
    end

    def part(classification_id, part_number, user_email)
      Part.new(self, classification_id, part_number, user_email)
    end

    def user(user_email)
      User.new(self, user_email)
    end

    def user_exists?(user_email)
      response = get_request('CheckLogin', {
        'UserEmail' => user_email
      })

      json = JSON.parse(response.body)

      json['registered'] == true
    end

    def register_user(user_email, company, country, first_name, last_name, phone)
      response = get_request('UserRegistration', {
        'UserEmail' => user_email,
        'company' => company,
        'country' => country,
        'fname' => first_name,
        'name' => last_name,
        'phone' => phone
      })

      json = JSON.parse(response.body)

      json['registered'] == true
    end

    private

    def json_catalogs
      response = get_request('CatalogsList')

      JSON.parse(response.body)
    end

    def json_categories(classification_id)
      response = get_request('CategoriesList', {
        'ClassificationId' => classification_id
      })

      JSON.parse(response.body)
    end

    def json_products(catalog_id, category_path, page)
      response = get_request('ProductsList', {
        'ClassificationID' => catalog_id,
        'Path' => category_path,
        'Page' => page
      })
      json = response.body

      return {} unless json && json.length >= 2

      JSON.parse(json)
    end

    def json_part_details(classification_id, part_number, user_email)
      response = get_request('PartNumberData', {
        'PartNumber' => part_number,
        'ClassificationID' => classification_id,
        'UserEmail' => user_email
      })

      JSON.parse(response.body)
    end

    def json_available_formats(classification_id, part_number, user_email)
      response = get_request('CADFormatsList', {
        'PartNumber' => part_number,
        'ClassificationID' => classification_id,
        'UserEmail' => user_email
      })

      JSON.parse(response.body)
    end

    def bind_products(json)
      json['productList'].map { |product| Product.new(self, product) }
    end

    def products_present?(json)
      !json['productList'].nil?
    end

    def get_request(endpoint, params = {})
      @connection.get("#{WEB_SERVICE_PATH}/#{endpoint}", default_params.merge(params))
    end

    def post_request(endpoint, params = {})
      @connection.post(endpoint, default_params.merge(params))
    end

    def default_params
      {
        'ApiKey' => @api_key,
        'Format' => 'json',
        options: {
          timeout: 50,
          open_timeout: 50
        }
      }
    end
  end
end
