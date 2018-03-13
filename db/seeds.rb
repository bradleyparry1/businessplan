=begin
User.create(name: "Bradley Parry",
            email: "bradley@example.com",
            password: "testpass",
            password_confirmation: "testpass",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

5.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
=end
require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Google Sheets API Ruby Quickstart'
CLIENT_SECRETS_PATH = 'db/client_secret.json'
CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                             "sheets.googleapis.com-ruby-quickstart.yaml")
SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
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
    puts "Open the following URL in the browser and enter the " +
         "resulting code after authorization"
    puts url
    #code = gets
    code = "4/AACtAxlWR5dskVebdktncNGpTkrz3y9_dGrwc9aZrBhe_VDg-9YLWwU"
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI)
  end
  credentials
end

# Initialize the API
service = Google::Apis::SheetsV4::SheetsService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

spreadsheet_id = '1WkzHYNr9XNVW3-2doPoTINCqnhHJEGfW56r21eaGfuE'

Group.delete_all
Group.reset_pk_sequence

range = 'Groups!A2:C'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Group.new
  t.name = row[2]
  t.pcc = row[1]
  t.save
end

Team.delete_all
Team.reset_pk_sequence

range = 'Teams!A2:E'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Team.new
  t.name = row[1]
  t.cc = row[2]
  t.group_id = row[3]
  t.programme_id = row[4]
  t.save
end

Programme.delete_all
Programme.reset_pk_sequence

range = 'Programme!A2:B'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Programme.new
  t.name = row[1]
  t.save
end

Community.delete_all
Community.reset_pk_sequence

range = 'Community!A2:B'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Community.new
  t.name = row[1]
  t.save
end

Profession.delete_all
Profession.reset_pk_sequence

range = 'Profession!A2:B'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Profession.new
  t.name = row[1]
  t.save
end

Account.delete_all
Account.reset_pk_sequence

range = 'Account!A2:E'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Account.new
  t.code = row[1]
  t.name = row[2]
  t.major = row[3]
  t.minor = row[4]
  t.save
end

Status.delete_all
Status.reset_pk_sequence

range = 'Status!A2:B'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Status.new
  t.name = row[1]
  t.save
end

Grade.delete_all
Grade.reset_pk_sequence

range = 'Grade!A2:B'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Grade.new
  t.name = row[1]
  t.save
end

Role.delete_all
Role.reset_pk_sequence

range = 'Role!A2:C'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Role.new
  t.name = row[1]
  t.account_id = row[2]
  t.save
end

Framework.delete_all
Framework.reset_pk_sequence

range = 'Framework!A2:C'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Framework.new
  t.name = row[1]
  t.save
end

Rate.delete_all
Rate.reset_pk_sequence

range = 'Rate!A2:D'
response = service.get_spreadsheet_values(spreadsheet_id, range)

puts 'No data found.' if response.values.empty?
response.values.each do |row|
  t = Rate.new
  t.group_id = row[1]
  t.grade_id = row[2]
  t.salary = row[3]
  t.save
end
