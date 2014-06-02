class Item < ActiveRecord::Base
    has_many :scans
    has_many :notes

    # instance method
    # @item.date_to_year
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

    def prev
         a,b,c=fa_seq.split('/')
         test_seq = "#{a}/#{b}/#{(c.to_i)-1}"
         Item.find_by_fa_seq!(test_seq)
         return test_seq
    rescue
         return false
    end

    def next
         a,b,c=fa_seq.split('/')
         test_seq = "#{a}/#{b}/#{(c.to_i)+1}"
         Item.find_by_fa_seq!(test_seq)
         return test_seq
    rescue
         return false
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
        when "group_by_significant_term"
            "Significant Term Order"
        when "display_by_number_of_scans"
			"Order by Number of Scans"
		when "advanced_search"
			"Ordered by Search Criteria"
        else
            "Database Order"
        end
    end

    scope :all_except_sub, ->() { where(sub: nil) }
end
