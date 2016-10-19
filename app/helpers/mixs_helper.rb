require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
module MixsHelper
  class Gmail
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    APPLICATION_NAME = 'Gmail API'
    CLIENT_SECRETS_PATH = "#{Rails.root.to_s}/config/client_secret.json"
    CREDENTIALS_PATH = File.join(Dir.pwd, '.credentials',
                                 "gmail-ruby.yaml")
    SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

    def initialize
      # Initialize the API
      @service = Google::Apis::GmailV1::GmailService.new
      @service.client_options.application_name = APPLICATION_NAME
      @service.authorization = authorize
      @user_id = 'me'
    end

    def authorize
      FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

      client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
      authorizer = Google::Auth::UserAuthorizer.new(
        client_id, SCOPE, token_store)
      user_id = 'default'
      credentials = authorizer.get_credentials(user_id)
      if credentials.nil?
        url = authorizer.get_authorization_url(
          base_url: OOB_URI)
        puts "Open the following URL in the browser and enter the " +
          "resulting code after authorization"
        puts url
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI)
      end
      credentials
    end

    def get_email(query_str=nil,max=5)
      emails = @service.list_user_messages(@user_id,q: query_str).messages
      return [] if emails.nil?
      emails[0..max].map do |email|
        message = @service.get_user_message(@user_id,email.id).payload
        {from:message.headers[3].value, to:message.headers[0].value, content:message.parts[0].body.data}
      end
    end
  end
end
