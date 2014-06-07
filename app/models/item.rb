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
        return nil
    end

    def next
        a,b,c=fa_seq.split('/')
        test_seq = "#{a}/#{b}/#{(c.to_i)+1}"
        Item.find_by_fa_seq!(test_seq)
        return test_seq
    rescue
        return nil
    end

    def initial
		i = self
		while i.prev do i = Item.find_by_fa_seq(i.prev) end
		i.fa_seq
	end

	def final
		i = self
		while i.next do i = Item.find_by_fa_seq(i.next) end
		i.fa_seq	
	end	
    
    def completed
		s = self.scans
		s.length > 0 and s.length == s.where(state: Scan::COMPLETED).length
	end

	def self.total_possible
		Item.all_except_sub.keep_if { |i| i.scans.length > 0 }
	end

	def self.total_accepted
		Item.all_except_sub.keep_if { |i| i.completed }
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
