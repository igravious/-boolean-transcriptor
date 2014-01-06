class Item < ActiveRecord::Base
    has_many :scans
    has_many :notes

    # instance method
    # item.foo
    def foo
    end

    # class method
    # Item.aspect
    def self.aspect str
        case str
        when "display_in_finding_aid_order"
            "Finding Aid Order"
        when "group_chronologically"
            "Ordered by Year"
        else
            "Database Order"
        end
    end
end
