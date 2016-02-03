module Traceparts
  class PartDetails
    attr_reader :title, :description, :long_description, :big_picture, :manufacturer_id, :manufacturer_name,
                :manufacturer_picture, :manufacturer_description, :manufacturer_emails, :manufacturer_websites,
                :manufacturer_address

    def initialize(data)
      global_info = data.fetch('globalInfo')
      part_info = global_info.fetch('partInfo')
      manufacturer_info = global_info.fetch('manufacturerInfo')

      @title = part_info.fetch('titlePart')
      @description = part_info.fetch('description')
      @long_description = part_info.fetch('longDescription')
      @big_picture = part_info.fetch('partPictureUrl')
      @manufacturer_id = part_info.fetch('manufacturerID')
      @manufacturer_name = part_info.fetch('manufacturerName')
      @manufacturer_picture= part_info.fetch('manufacturerPictureUrl')

      @manufacturer_description = manufacturer_info.fetch('description')
      @manufacturer_emails = manufacturer_info.fetch('emails')
      @manufacturer_websites = manufacturer_info.fetch('webSites')
      @manufacturer_address = manufacturer_info.fetch('address')
    end
  end
end
