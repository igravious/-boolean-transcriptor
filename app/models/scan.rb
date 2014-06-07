
require 'heading_locator_interaction'

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
    wikify = Creole::creolize self.transcription
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
	
  def self.total_possible
    Scan.all
  end

  def self.total_accepted
    Scan.where(state: Scan::COMPLETED)
  end

  include HeadingLocatorInteraction
  # where should this function be ideally?
  def bulk_update(script, headings, to_delete)
	self.transcription = script
	save!
	if !headings.nil?
		headings.each do |h|
			create_heading h[1]['index_term'], h[1]['type'], self
		end
	end
	# flash[:notice] = "Oh joy of joys, index terms created"
	if !to_delete.nil?
		to_delete.each do |id|
			(Locator.find id.to_i).destroy
		end
	end
  end

  def annotate
    1
  end

  def narrative
      ""
  end

  def snippets?
	Note.where(scan_id: self.id, type: 2).length > 0
  end

  def endnotes?
    Note.where(scan_id: self.id, type: 1).length > 0
  end

  def references?
    Locator.where(scan_id: self.id).length > 0
  end
end
