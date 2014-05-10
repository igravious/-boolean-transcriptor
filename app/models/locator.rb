class Locator < ActiveRecord::Base
    belongs_to :heading
    belongs_to :scan
end
