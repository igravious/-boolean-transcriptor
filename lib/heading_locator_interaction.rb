
# Headings and Locators models are manipulated by Transcriptions (Scans)
# and lso by Headings and Locators controllers so put common stuff here
#
# https://stackoverflow.com/questions/8225518/calling-a-method-from-another-controller

module HeadingLocatorInteraction
    # create headings just from scans?
    # the way this works is that headings either already exist or they are created
    # the locator is always created and linked with the now existent heading
    def create_heading index_term, type, scan
        raise "ah hell, no ways you can be blank, can you?" if index_term.blank?
        # why?
        # raise "ah hell, ya gotta be something" if type.blank?
        h = Heading.where('index_term = ?', index_term).first
        if h.nil?
            h = Heading.new
            h.index_term = index_term
            h.type = type
            h.save
        end
        if scan
            scan.index_content(index_term).each do |c|
				begin
                	l = Locator.new
                	l.heading_id = h.id
                	l.scan_id = scan.id
                	l.content = c
                	l.save
      			# rescue SQLite3::ConstraintException => e
      			rescue Exception => e
					Rails.logger.info(e.message)
				end
            end
        end
    end
end
