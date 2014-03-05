class ItemsController < ApplicationController

    def index
        if params[:fa_structure] and params[:selector_id]
            @items = Item.where("fa_structure = ?", params[:fa_structure])
        elsif params[:year]
            year = params[:year]
            year = nil if year == ''
            @items = Item.where("year #{(year ? '=' : 'is')} ?", year)
        else
            # else shows index which is selection screen
            raise ActionController::RoutingError.new('Halt! Who goes there!')
        end
        @all_scans = Scan.all
        respond_to do |format|
            @selector_id = params[:selector_id]
            # */* gets caught by whatever comes first, dunno how to force that to a default
            format.html { render "_bxslider" } # hmm
            format.js { render :layout => false } # not sure if i even need =>
        end
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
        @all_items = Item.all
        @all_scans = Scan.all

        # how do you want to slice through the items
        # (as in, what way do you want to display them?)
        aspect = params["aspect"]
        case aspect
        when "display_in_finding_aid_order"
            finding_aid
        when "group_by_theme"
            render "theme"
        when "group_chronologically"
            time
        when "group_by_difficulty"
            render "hard"
        when "ordered_by_transcription_state"
            state
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

    def state
        render "order_by_state"
    end
end
