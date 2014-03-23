
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
            headings = params['headings']
            # always have an id because we always come from a scan, unlike regular create
            @scan = Scan.find params['scan']['id']
            @scan.transcription = params['scan']['transcription']
            @scan.save!
            headings.each do |h|
                create_heading h[1]['index_term'], h[1]['type'], @scan
            end
            # flash[:notice] = "Oh joy of joys, index terms created"
        # rescue Exception
            # flash[:alert] = "Oh arse biscuits: #{dang.message}"
        # end
        # TODO flubify
        flub = {}
        flub[:aspect] = params[:aspect] if not params[:aspect].blank?
        flub[:whence] = params[:whence] if not params[:whence].blank?
        flub[:q] = params[:q] if not params[:q].blank?
        redirect_to edit_transcription_path(@scan, flub)
    end

    def index
        @all_headings = Heading.order(:index_term)
    end

    def edit
        @heading = Heading.find params['id']
    end

    def update heading
        begin
            heading_id = params[:id]
            # TODO do i need to be paramsing here?
            aspect = params['aspect']
            @heading = Heading.find heading_id
            # http://guides.rubyonrails.org/getting_started.html#updating-posts
            if @heading.update(heading.permit(:index_term, :type))
                flash[:notice] = "Oh joy of joys, index term updated"
                redirect_to @heading
            else
                flash[:alert] = "Unable to update index term, um"
                render 'edit'
            end
        rescue Exception => dang
            flash[:alert] = "You know what I was trying to d? I was trying to update that index term. And I couldn't: #{dang.message}"
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
            redirect_to headings_path
        rescue Exception => dang
            flash[:alert] = "Behold my terseness - unable to delete index term: #{dang.message}"
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
