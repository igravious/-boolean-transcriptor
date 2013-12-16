class Item < ActiveRecord::Base
    has_many :scan
    def self.this_is_my_class_method
    end
    def this_is_my_instance_method
    end

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
