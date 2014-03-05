class Item < ActiveRecord::Base
    has_many :scans
    has_many :notes

    # instance method
    # item.date_to_year
    def date_to_year
      begin
        i = item_date.to_i
        # either a year (i is year) or NULL (i is 0)
        item_date
      rescue Exception => e
        # in DotW, dd, m, yyyy format - get year with .year
        item_date.year
      end
    end

    # class method
    # Item.aspect
    def self.aspect str
        # l10n
        case str
        when "display_in_finding_aid_order"
            "Finding Aid Order"
        when "group_chronologically"
            "Ordered by Year"
        when "ordered_by_transcription_state"
            "Ordered by State"
        else
            "Database Order"
        end
    end
end
