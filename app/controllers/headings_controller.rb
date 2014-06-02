
require 'heading_locator_interaction'

class HeadingsController < ApplicationController
    def from_wiki
        # TODO fix this for the love of God
        index_term = (URI.unescape params[:index_term]).gsub('+',' ')
        @heading = Heading.where('index_term = ?', index_term).first
        if @heading
            render 'edit'
        else
            @heading = Heading.new
            @heading.index_term = index_term
            render 'new'
        end
    end

    def new
        @heading = Heading.new
    end

    include HeadingLocatorInteraction
    def create
        begin
            heading = params['heading']
            # if params['id']
            #    scan = Scan.find params['id']
            # else
                scan = nil
            # end
            create_heading heading['index_term'], heading['type'], scan
            flash[:notice] = "Oh joy of joys, index term created"
        rescue Exception => dang
            flash[:alert] = "Insert expletive here: #{dang.message}"
        end
        redirect_to :back
    end

    def bulk_create
        # begin
            Rails.logger.info("params in bulk_create: #{params.inspect}")
            headings = params['headings']
            # always have an id because we always come from a scan, unlike regular create
            @scan = Scan.find params['scan']['id']
            # replace with - @scan.bulk_update(params['scan']['transcription'], params['headings'], params['to_delete'])
            @scan.transcription = params['scan']['transcription']
            @scan.save!
            if !headings.nil?
                headings.each do |h|
                    create_heading h[1]['index_term'], h[1]['type'], @scan
                end
            end
            # flash[:notice] = "Oh joy of joys, index terms created"
            to_delete = params['to_delete']
            if !to_delete.nil?
                to_delete.each do |id|
                    (Locator.find id.to_i).destroy
                end
            end
        # rescue Exception
            # flash[:alert] = "Oh arse biscuits: #{dang.message}"
        # end
        # TODO flubify
        flub = {}
        flub[:aspect] = params[:aspect] unless params[:aspect].blank?
        flub[:whence] = params[:whence] unless params[:whence].blank?
        flub[:q] = params[:q] if not params[:q].blank?
        flash[:notice] = "The transcription (with annotation) was successfully updated"
        redirect_to edit_transcription_path(@scan, flub)
    end

    def index
        # @typd_headings = Heading.where('NOT type = ""', Heading::NO_TYPE).order(:index_term)
        # @typeless_headings = Heading.where('type = ""', Heading::NO_TYPE).order(:index_term)
        # Heading.find(Locator.pluck(:heading_id))
        # # pluck replaces
        # Locator.select(:heading_id).map { |h| h.heading_id }
        # # or
        # Locator.select(:heading_id).map(&:heading_id)
        # 
        # https://stackoverflow.com/questions/4307411/how-to-express-a-not-in-query-with-activerecord-rails
        # Heading.find(:all, :conditions => ['id not in (?)', Locator.select(:heading_id).map(&:heading_id)])
        # check out named_scope as well
        #
        @refd_headings = Heading.where(id: Locator.pluck(:heading_id))
        # @orphaned_headings = Heading.where.not(id: Locator.pluck(:heading_id))
        render 'index'
    end

    def the_index
        index
    end

	def orphaned_index
        @orphaned_headings = Heading.where.not(id: Locator.pluck(:heading_id))
	end

    def edit
        @heading = Heading.find params['id']
    end

    def update
        begin
            heading_id = params[:id]
            # TODO do i need to be paramsing here?
            aspect = params['aspect']
            heading = params['heading']
            @heading = Heading.find heading_id
			raise "Cannot (yet) modify a heading term that references rely on" if @heading.locators.length > 0
            # http://guides.rubyonrails.org/getting_started.html#updating-posts
            if @heading.update(heading.permit(:index_term, :type))
                flash[:notice] = "Oh joy of joys, index term updated"
                redirect_to the_index_headings_path
            else
                raise "You know what I was trying to do? I was trying to update that index term. And I couldn't."
            end
        rescue Exception => dang
            flash.now[:alert] = "Exceptional circumstances: #{dang.message}"
            render 'edit'
        end
    end

    def destroy
        begin
            heading_id = params[:id]
            aspect = params['aspect']
            @heading = Heading.find heading_id
            # http://guides.rubyonrails.org/getting_started.html#deleting-posts
            @heading.destroy
            # TODO create a `shorten' method
            flash[:notice] = "Oh joy of joys, index term <strong>#{@heading.index_term}</strong> deleted"
            redirect_to the_index_headings_path
        rescue Exception => dang
            flash.now[:alert] = "Behold my terseness - unable to delete index term: #{dang.message}"
            render 'edit'
        end
    end
end

# TODO DRY

class EventsController < HeadingsController
    def update
        super params["event"]
    end
end
class PlacesController < HeadingsController
    def update
        super params["place"]
    end
end
class ActivitiesController < HeadingsController
    def update
        super params["activity"]
    end
end
class PeopleController < HeadingsController
    def update
        super params["person"]
    end
end
class ConceptsController < HeadingsController
    def update
        super params["concept"]
    end
end
