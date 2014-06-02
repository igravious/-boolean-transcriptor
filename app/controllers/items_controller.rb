class ItemsController < ApplicationController

    # grabs a bunch of items and show them in a slider, one scan per item
    # (i think)
    # could use for
    #     1) groups of items (based on certain criteria)
    #     2) one item with many sub-items
    def index
        if params[:fa_structure] and params[:selector_id]
            @selector_id = params[:selector_id]
            @items = Item.where("fa_structure = ?", params[:fa_structure])
        # where the fuck did i think this would be called from?
        # elsif params[:year]
        #    year = params[:year]
        #    year = nil if year == ''
        #    @items = Item.where("year #{(year ? '=' : 'is')} ?", year)
        else
            # could this show what we show when we click Browse?
            raise ActionController::RoutingError.new('Selection criteria not recognised')
        end
        @all_scans = Scan.all
        respond_to do |format|
            # */* gets caught by whatever comes first, dunno how to force that to a default
            # format.html { render "_bxslider" } # hmm
            format.js { render :layout => false } # not sure if i even need =>
        end
        # i still don't fully understand respond_to
        # raise ActionController::RoutingError.new('I only respond to JS at the moment')
    end

    def show
        @item = Item.find(params[:id])
        # XXX is this X-rated?
        params[:item_id] = params[:id]
        params.delete(:id)
        if Rails.env.development? and params['debug']
            render "horror_show"
            return
        end
    end

    def slice
        @all_items = Item.all_except_sub
        @all_scans = Scan.all

        # how do you want to slice through the items
        # (as in, what way do you want to display them?)
        aspect = params["aspect"]
        case aspect
        when "display_in_finding_aid_order"
            finding_aid
        when "group_by_significant_term" # reference
            significant_term
        when "group_chronologically"
            time
        when "group_by_difficulty"
            render "hard"
        when "ordered_by_transcription_state"
            state
        when "display_by_number_of_scans"
            number_of_scans
		when "advanced_search"
			advanced_search
        else # show_raw
            render "raw"
        end
    end

    private

    def finding_aid
        control_file = YAML.load_file('db/Boole_Finding_Aid.yml')
        @top_level = control_file["data"]
        render "order_by_finding_aid"
    end

    def time
        render "order_by_time"
    end

	def advanced_search
		render ""
	end

    def state
        render "order_by_state"
    end

    def number_of_scans
        render "order_by_number_of_scans"
    end

    def significant_term
        render "order_by_significant_term"
    end
end
