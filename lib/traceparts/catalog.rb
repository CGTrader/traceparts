module Traceparts
  class Catalog
    attr_reader :id, :title, :picture_url, :published, :updated, :type

    def initialize(client, data)
      @client = client

      @id = data.fetch('classificationId')
      @title = data.fetch('title')
      @picture_url = data.fetch('pictureUrl')
      @published = data.fetch('published')
      @updated = data.fetch('updated')
      @type = data.fetch('classType')
    end

    def products
      @client.products(id)
    end

    def categories
      @client.categories(id)
    end
  end
end
