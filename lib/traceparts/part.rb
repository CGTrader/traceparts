module Traceparts
  class Part
    attr_reader :classification_id, :part_number, :user_email

    def initialize(client, classification_id, part_number, user_email)
      @client = client

      @classification_id = classification_id
      @part_number = part_number
      @user_email = user_email
    end

    def details
      @client.part_details(classification_id, part_number, user_email)
    end

    def available_formats
      @client.available_formats(classification_id, part_number, user_email)
    end

    def download_archive_link(cad_format_id)
      @client.download_archive_link(classification_id, part_number, cad_format_id, user_email)
    end
  end
end
