module Traceparts
  class User
    attr_reader :email, :company, :country

    def initialize(client, email)
      @client = client

      @email = email
      @company = nil
      @coutry = nil
    end

    def exists?
      @client.user_exists?(email)
    end

    def register(company, country)
      @client.register_user(email, company, country)
    end
  end
end
