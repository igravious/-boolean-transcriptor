class Scan < ActiveRecord::Base
  has_paper_trail

  belongs_to :item

  VIRGIN=1
  BEING_EDITED=2
  IN_REVIEW=3
  COMPLETED=4

  def self.set_to_void_if_empty
  end
end
