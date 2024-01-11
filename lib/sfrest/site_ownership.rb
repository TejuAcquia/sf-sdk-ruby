# frozen_string_literal: true

module SFRest
  # We need to keep this naming due to the way connection.rb autoloads things.
  # rubocop: disable Naming/ClassAndModuleCamelCase
  # Manage the site default ownership feature.
  class Site_ownership
    # rubocop: enable Naming/ClassAndModuleCamelCase

    # @param [SFRest::Connection] conn
    def initialize(conn)
      @conn = conn
    end

    # Get current site ownership settings.
    #
    # @return [Array] an array containing current settings.
    def default_ownership
      @conn.get('/api/v1/site-ownership')
    end

    # Set the site ownership settings.
    # @param [String] The default owner username. The user has to have the "Platform admin" role.
    #
    # @return [Array] an array containing the message given by the server.
    def make_default_owner(username)
      payload = {
        'username' => username
      }

      @conn.put('/api/v1/site-ownership', payload.to_json)
    end

    # Removes the default site owner.
    #
    # @return [Array] an array containing the message given by the server.
    def remove_default_owner
      @conn.delete('/api/v1/site-ownership')
    end

    # Transfers site ownership using recipients username.
    # @param [Integer] site id.
    # @param [String] username.
    # @param [Boolean] force_transfer.
    #
    # @return [Array] an array containing the message given by the server.
    def transfer_site_ownership_using_username(site_id, username, force_transfer)
      payload = {
        'username' => username,
        'force_transfer' => force_transfer
      }

      @conn.post("/api/v1/site-ownership/#{site_id}", payload.to_json)
    end

    # Transfers site ownership using recipients email.
    # @param [Integer] site id.
    # @param [String] email.
    # @param [Boolean] force_transfer.
    #
    # @return [Array] an array containing the message given by the server.
    def transfer_site_ownership_using_email(site_id, email, force_transfer)
      payload = {
        'email' => email,
        'force_transfer' => force_transfer
      }

      @conn.post("/api/v1/site-ownership/#{site_id}", payload.to_json)
    end

    # Check if a username or email address corresponds to a valid user
    # @param [String] recipient.
    #
    # @return [Array] an array containing the message given by the server.
    def transfer_site_check_recipient_using_email_username(recipient)
      payload = {
        'recipient' => recipient
      }

      @conn.post("/transfer-site/check-recipient", payload.to_json)
    end
  end
end
