class Scan < ActiveRecord::Base
  has_paper_trail

  belongs_to :item
  has_many :notes
  has_many :locators

  VIRGIN=1
  BEING_EDITED=2
  IN_REVIEW=3
  LOCKED=4
  COMPLETED=5

  CAPTURE_TIME=24
  COOL_OFF_PERIOD=72
  NO_MORE_THAN=5

  # TODO need a reject count/trail
  # TODO locked counter on label
  STATE_STRING=[nil, "Untouched", "In Progress", "Needs Review", "Locked", "Completed"]

  def index_content index_term
    wikify = Creole::creolize transcription
    noko = Nokogiri::HTML.fragment(wikify)
    content = []
    noko.css('a').each do |e|
      if (URI.unescape e['href']).gsub('+',' ') == index_term
        content <<= e.text
      end
    end
    content
  end

  def self.set_to_void_if_empty
  end

  def annotate
      0
  end

  def narrative
      ""
  end
end
