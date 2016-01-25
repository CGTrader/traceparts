module Traceparts
  class Product
    attr_reader :id, :title, :manufacturer_id, :manufacturer_name, :picture_url, :published, :updated,
                :manufacturer_picture_url

    def initialize(data, client)
      @client = client

      @id = data.fetch('partID')
      @title = data.fetch('title')
      @manufacturer_id = data.fetch('manufacturerID')
      @manufacturer_name = data.fetch('manufacturerName')
      @picture_url = data.fetch('partPictureUrl')
      @published = data.fetch('published')
      @updated = data.fetch('updated')
      @manufacturer_picture_url = data.fetch('manufacturerPictureUrl')
    end

    def download
      # TODO:
    end
  end
end
