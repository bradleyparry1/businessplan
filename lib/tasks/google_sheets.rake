namespace :google_sheets do
  desc "TODO"
  task export: :environment do
    include PeopleHelper
    require 'google/apis/sheets_v4'
    require 'googleauth'
    require 'googleauth/stores/file_token_store'

    require 'fileutils'

    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    APPLICATION_NAME = 'Google Sheets API Ruby Quickstart'
    CLIENT_SECRETS_PATH = 'db/client_secret.json'
    CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                                 "sheets.googleapis.com-ruby-quickstart.yaml")
    SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS

    # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
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

        puts url

        code = "4/AAAhXO7haL85F5oQ7Kg6y3FwxPU3XGbzwWlV8Lv5THb9xRvpa89fjMo"
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI)
      end
      credentials
    end

    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize

    spreadsheet_id = '1OL84dSYJe8gnvD7C-NIzi2DuJLAkNhT_5RBwIx060fo'

    values =[]

    Person.all.each do |p|
      new_row = [p.id.to_s,
                     p.team.group.name,
                     p.team.name,
                     p.name.name,
                     p.name.job_title,
                     p.name.community.name,
                     p.name.profession.name,
                     p.fte,
                     p.start,
                     p.end]

      new_row += get_all_fte(p.start,p.end,p.fte)

      values.append(new_row)
    end

    range_name = "People!A2:" + values[0].length.alph + (values.length + 1).to_s

    body = {
      'values': values
    }
    result = service.update_spreadsheet_value(spreadsheet_id, range_name, value_range_object = body, value_input_option: "RAW", quota_user: nil, fields: nil, options: nil)
  end

end
