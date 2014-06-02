namespace :prep do
  desc "prep the transcriptor collection"
  task symlinks: :environment do
    # TODO get these from collection constants (and eventually db in generic version)
    #      config/initializers/my_constants.rb
    LINK_TO = [ GB_COLLECTION[:digital_surrogate][:pint_size_folder], GB_COLLECTION[:digital_surrogate][:thumbs_folder] ]
    # LINK_TO = ["../../../../mediawiki-transcription-desk/boole/pint-size", "../../../../mediawiki-transcription-desk/boole/thumbs"]
    d = Dir.getwd
    Dir.chdir "public/images"
    LINK_TO.each do |file|
      File.stat(file)
      File.symlink(file, (File.basename file))
    end
    Dir.chdir d
  end

  desc "derp"
  task year: :environment do
    # 
    Item.find_each do |item|
        item.year = item.date_to_year
        item.save!
    end
  end
end

namespace :cron do
  desc "expire locked facsimiles"
  task expire_locks: :environment do
    msg = "Attempting to expire locks (if any) at #{Time.now}"
    # puts msg
    Rails.logger.info msg
    Scan.find_each do |scan|
      if scan.state == Scan::LOCKED
        v = scan.versions.last
        if scan.updated_at < 24.hours.ago
          msg = "Unlocking #{scan.pretty_inspect}"
          puts msg
          Rails.logger.info msg
          scan.state = Scan::BEING_EDITED
          # Anything with an exclamation with raise an error if it is not 
          # successful, without an exclamation it will just return false
          scan.save!
        end
      end
    end
  end
end
