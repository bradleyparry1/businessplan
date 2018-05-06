=begin
User.create!(name: "Bradley Parry", email: "bradley.parry@digital.cabinet-office.gov.uk", password: "testpass", password_confirmation: "testpass", admin: true, activated: true, activated_at: Time.zone.now, user_type: "Master")

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
    #puts "Open the following URL in the browser and enter the " +
    #     "resulting code after authorization"
    puts url
    #code = gets
    #code = "4/AACtAxlWR5dskVebdktncNGpTkrz3y9_dGrwc9aZrBhe_VDg-9YLWwU"
    #code = "4/AABTf3uizJu-dAlz8Cbe9baVk7lHCE_WNzyRCMdabmy7AelWmBZOKu4"
    code = "4/AACORY4IgFEJ_i1caBDq3DvzkcK7WawpIfP3DJwvqUDAvl9X5NSznIU"
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


if ENV["groups"] || ENV["all"]
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
end

if ENV["users"] || ENV["all"]
  User.delete_all
  User.reset_pk_sequence

  range = 'Users!A2:G'
  response = service.get_spreadsheet_values(spreadsheet_id, range)

  puts 'No data found.' if response.values.empty?
  response.values.each do |row|
    t = User.new
    t.name = row[1]
    t.email = row[2]
    t.password = row[3]
    t.password_confirmation = row[3]
    t.admin = row[4] == "TRUE" ? true : false
    t.activated  = row[5] == "TRUE" ? true : false
    t.activated_at = Time.zone.now
    t.user_type = row[6]
    t.save
  end
end

if ENV["permissions"] || ENV["all"]
  Permission.delete_all
  Permission.reset_pk_sequence

  range = 'Permissions!A2:C'
  response = service.get_spreadsheet_values(spreadsheet_id, range)

  puts 'No data found.' if response.values.empty?
  response.values.each do |row|
    t = Permission.new
    t.user_id = row[1]
    t.group_id = row[2]
    t.save
  end
end

if ENV["programmes"] || ENV["all"]
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
end

if ENV["teams"] || ENV["all"]
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
end

if ENV["communities"] || ENV["all"]
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
end

if ENV["professions"] || ENV["all"]
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
end

if ENV["accounts"] || ENV["all"]
  Account.delete_all
  Account.reset_pk_sequence

  range = 'Account!A2:E'
  response = service.get_spreadsheet_values(spreadsheet_id, range)

  puts 'No data found.' if response.values.empty?
  response.values.each do |row|
    t = Account.new
    t.code = row[1].to_s
    t.name = row[2]
    t.major = row[3].to_s
    t.minor = row[4].to_s
    t.save
  end
end

if ENV["status"] || ENV["all"]
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
end

if ENV["grades"] || ENV["all"]
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
end

if ENV["roles"] || ENV["all"]
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
end

if ENV["frameworks"] || ENV["all"]
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
end

if ENV["rates"] || ENV["all"]
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
end

if ENV["names"] || ENV["all"]
  Name.delete_all
  Name.reset_pk_sequence

  range = 'Names!A2:K'
  response = service.get_spreadsheet_values(spreadsheet_id, range)


  puts 'No data found.' if response.values.empty?
  response.values.each do |row|
    if Name.exists?(id: row[0])
      t = Name.find(row[0])
      t.name = row[1] unless t.name == row[1]
      t.staff_number = row[2] unless t.staff_number == row[2]
      t.job_title = row[3] unless t.job_title == row[3]
      t.role_id = row[4] unless t.role_id == row[4]
      t.community_id = row[5] unless t.community_id == row[5]
      t.grade_id = row[6] unless t.grade_id == row[6]
      t.profession_id = row[7] unless t.profession_id == row[7]
      t.framework_id = row[8] unless t.framework_id == row[8]
      t.status_id = row[9] unless t.status_id == row[9]
      t.charge_rate = row[10] unless t.charge_rate == row[10]
      t.save
    else
      t = Name.new
      t.name = row[1]
      t.staff_number = row[2]
      t.job_title = row[3]
      t.role_id = row[4]
      t.community_id = row[5]
      t.grade_id = row[6]
      t.profession_id = row[7]
      t.framework_id = row[8]
      t.status_id = row[9]
      t.charge_rate = row[10]
      t.save
    end
  end
end

if ENV["people"] || ENV["all"]
  Person.delete_all
  Person.reset_pk_sequence

  range = 'People!A2:G'
  response = service.get_spreadsheet_values(spreadsheet_id, range)

  puts 'No data found.' if response.values.empty?
  response.values.each do |row|
    t = Person.new
    t.name_id = row[1]
    t.team_id = row[2]
    t.start = row[3] == "" ? nil : Date.parse(row[3])
    t.end = row[4] == "" ? Date.parse("2019-04-01") : Date.parse(row[4])
    t.fte = row[5]
    t.brexit = row[6] == "Yes" ? true : false
    t.created_at = Date.parse("2018-04-01")
    t.save

    t = BasePerson.new
    t.name_id = row[1]
    t.team_id = row[2]
    t.start = row[3] == "" ? nil : Date.parse(row[3])
    t.end = row[4] == "" ? Date.parse("2019-04-01") : Date.parse(row[4])
    t.fte = row[5]
    t.brexit = row[6] == "Yes" ? true : false
    t.created_at = Date.parse("2018-04-01")
    t.save
  end
end

if ENV["others"] || ENV["all"]
  Other.delete_all
  Other.reset_pk_sequence

  range = 'Other!A2:R'
  response = service.get_spreadsheet_values(spreadsheet_id, range)

  puts 'No data found.' if response.values.empty?
  response.values.each do |row|
    t = Other.new
    t.description = row[1]
    t.team_id = row[2]
    t.account_id = row[3]
    t.supplier = row[4]
    t.po_number = row[5]
    t.apr = row[6] == nil ? 0.0 : row[6]
    t.may = row[7] == nil ? 0.0 : row[7]
    t.jun = row[8] == nil ? 0.0 : row[8]
    t.jul = row[9] == nil ? 0.0 : row[9]
    t.aug = row[10] == nil ? 0.0 : row[10]
    t.sep = row[11] == nil ? 0.0 : row[11]
    t.oct = row[12] == nil ? 0.0 : row[12]
    t.nov = row[13] == nil ? 0.0 : row[13]
    t.dec = row[14] == nil ? 0.0 : row[14]
    t.jan = row[15] == nil ? 0.0 : row[15]
    t.feb = row[16] == nil ? 0.0 : row[16]
    t.mar = row[17] == nil ? 0.0 : row[17]
    t.created_at = Date.parse("2018-04-01")
    t.save

    t = BaseOther.new
    t.description = row[1]
    t.team_id = row[2]
    t.account_id = row[3]
    t.supplier = row[4]
    t.po_number = row[5]
    t.apr = row[6] == nil ? 0.0 : row[6]
    t.may = row[7] == nil ? 0.0 : row[7]
    t.jun = row[8] == nil ? 0.0 : row[8]
    t.jul = row[9] == nil ? 0.0 : row[9]
    t.aug = row[10] == nil ? 0.0 : row[10]
    t.sep = row[11] == nil ? 0.0 : row[11]
    t.oct = row[12] == nil ? 0.0 : row[12]
    t.nov = row[13] == nil ? 0.0 : row[13]
    t.dec = row[14] == nil ? 0.0 : row[14]
    t.jan = row[15] == nil ? 0.0 : row[15]
    t.feb = row[16] == nil ? 0.0 : row[16]
    t.mar = row[17] == nil ? 0.0 : row[17]
    t.created_at = Date.parse("2018-04-01")
    t.save
  end
end

if ENV["actuals"] || ENV["all"]
  Actual.delete_all
  Actual.reset_pk_sequence

  range = 'Actuals!A2:AK'
  response = service.get_spreadsheet_values(spreadsheet_id, range)

  months = [8,9,10,11,0,1,2,3,4,5,6,7]

  puts 'No data found.' if response.values.empty?
  response.values.each do |row|
    t = Actual.new
    t.team_id = Team.find_by(cc: row[5].to_s).id unless !Team.find_by(cc: row[5].to_s)
    t.account_id = Account.find_by(code: row[7].to_s).id unless !Account.find_by(code: row[7].to_s)
    t.po_number = row[24]
    t.description = row[12]
    t.amount = row[34].to_f
    t.month = months[Date.parse(row[1]).month]
    t.save
  end

end
