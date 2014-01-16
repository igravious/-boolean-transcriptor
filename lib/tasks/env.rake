namespace :prep do
  desc "prep the transcriptor collection"
  task symlinks: :environment do
    # TODO: get these from collection constants (and eventually db in generic version)
    LINK_TO = ["../../../../mediawiki-transcription-desk/boole/pint-size", "../../../../mediawiki-transcription-desk/boole/thumbs"]
    d = Dir.getwd
    Dir.chdir "public/images"
    LINK_TO.each do |file|
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
