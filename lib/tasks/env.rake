namespace :env do
  desc "prep the transcriptor collection"
  task setup: :environment do
    # TODO: get these from collection constants (and eventually db in generic version)
    LINK_TO = ["../../../../mediawiki-transcription-desk/boole/pint-size", "../../../../mediawiki-transcription-desk/boole/thumbs"]
    d = Dir.getwd
    Dir.chdir "public/images"
    LINK_TO.each do |file|
      File.symlink(file, (File.basename file))
    end
    Dir.chdir d
  end
end
