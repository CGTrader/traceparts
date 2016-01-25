module Traceparts
  class Category
    attr_reader :path, :title, :path_caption, :classification_id, :picture_url, :level, :description

    def initialize(client, data)
      @client = client

      @path = data.fetch('path')
      @title = data.fetch('title')
      @path_caption = data.fetch('pathCaption')
      @classification_id = data.fetch('pathCaption')
      @picture_url = data.fetch('pictureUrl')
      @level = data.fetch('level')
      @description = data.fetch('description')
    end

    def products
      @client.products(classification_id, path)
    end
  end
end
