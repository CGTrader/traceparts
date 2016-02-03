module Traceparts
  class CadFormat
    attr_reader :id, :name

    def initialize(client, data)
      @client = client

      @id = data.fetch('cadFormatId')
      @name = data.fetch('cadFormatName')
    end
  end
end
