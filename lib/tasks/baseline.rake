namespace :baseline do
  desc "Sets created_at of versions to start of financial year."
  task base: :environment do
    PaperTrail::Version.all.update_all(created_at: Date.parse("2018-04-01"), whodunnit: 1)
  end
end
