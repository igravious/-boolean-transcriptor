# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# copied from bin/yaml_to_items

thing = YAML.load_file('db/Boole_Finding_Aid.yml')

# slice = thing["boole_papers_descriptive_list"]["part"][0]["part"][0]["part"][1]["part"][0]["items"][0]["desc"]

def go_into_level level, struct
    level.each do |section|
        # p section 

        # print "__section__\n"
        # p section

        sub = section["sub"]
        label = section["label"]

        # print "__sub__\n"
        # p sub
        # print "__label__\n"
        # p label

        next_level = section["part"]
        if next_level.nil?
            items = section["items"]
            if items.nil?
                p "Error in control file"
                exit
            else
                items.each do |item|
                    # check if the item is already in the database!
                    p item["name"]
                    i = Item.new
                    i.description = item["desc"]
                    i.pp = item["pp"]
                    # date validation !!
                    i.item_date = item["date"]
                    i.fa_seq = item["name"]
                    i.fa_structure = struct+"#{sub}"
                    i.year = item["year"]
                    # note, commentary
                    i.save
                end
            end
        else
            go_into_level(next_level, struct+"#{sub}.")
        end
    end
end

top_level = thing["boole_papers_descriptive_list"]["part"]

go_into_level(top_level, "")

# copied from bin/jpegs_to_scans

SCANS=["../../mediawiki-transcription-desk/boole/BOOLE-MASTER-STAMPED-JPEG-1-OF-2", "../../mediawiki-transcription-desk/boole/BOOLE-MASTER-STAMPED-JPEG-2-OF-2"]

SCANS.each do |dir|
    # p dir
    d = Dir.new dir
    # p d
    d.entries.each do |file|
        #
        # file is in format
        # BP-1-iii-nnn_stamped.jpeg
        # /BP-1-(\d+)-(\d+)_stamped\.jpeg/.match(d.entries[2])
        #
        #<Scan id: nil, stringified: nil, file_name: nil, institution: nil, prefix: nil, major_seq: nil, seq: nil, minor_seq: nil,
        #item_id: nil, state: nil, transcription: nil, created_at: nil, updated_at: nil, image_data: nil, directory: nil>
        #
        m = /BP-1-(\d+)-(\d+)_stamped\.jpeg/.match(file)
        unless m.nil?
            lookup = "BP/1/"+(m[1])
            i = Item.find_by(fa_seq: lookup)
            if i.nil?
                # currently, 423, 424, 425
                # check Special Collections
                STDERR.print "*** Could not find sequence number, #{lookup}\n"
            else
                # check if the scan is already in the database!
                # p i
                s = Scan.new
                # store the directory separately!
                s.file_name = file
                s.directory = File.realpath dir
                # SLOW !!!
                # File.open(dir+"/"+file, 'rb') { |io| s.image_data = io.read }
                s.institution = 1 # UCC
                s.prefix = "BP"
                s.major_seq = "1"
                s.seq = m[1]
                s.minor_seq = m[2]
                s.item_id = i.id
                s.state = 1 # virgin
                s.transcription = ""
                p s
                s.save
            end
        end
    end
end

