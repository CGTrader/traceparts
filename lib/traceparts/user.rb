module Traceparts
  class User
    attr_reader :email

    def initialize(client, email)
      @client = client

      @email = email
    end

    def exists?
      @client.user_exists?(email)
    end

    def register(company, country, first_name = nil, last_name = nil, phone = nil)
      @client.register_user(email, company, country, first_name, last_name, phone)
    end
  end
end
