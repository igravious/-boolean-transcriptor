
# Headings and Locators models are manipulated by Transcriptions (Scans)
# and lso by Headings and Locators controllers so put common stuff here
#
# https://stackoverflow.com/questions/8225518/calling-a-method-from-another-controller

module HeadingLocatorInteraction
    # create headings just from scans?
    def create_heading index_term, type, scan
        h = Heading.new
        raise "ah hell, ya gotta point to something" if index_term.blank?
        raise "ah hell, ya gotta be something" if type.blank?
        h.index_term = index_term
        h.type = type
        h.save
        if scan
            scan.index_content(index_term).each do |c|
                l = Locator.new
                l.heading_id = h.id
                l.scan_id = scan.id
                l.content = c
                l.save
            end
        end
    end
end
