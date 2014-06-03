class DeskPagesController < ApplicationController
    def desk
    end

    def browse
    end

	def faqs_n_guide
	end

    def locked_by_member
        @all_scans = Scan.all
        @member_scans = @all_scans.keep_if { |s| current_member.id == s.versions.last.whodunnit.to_i }
        @locked_scans = @member_scans.keep_if { |s| s.state == Scan::LOCKED }
    end

    def leaderboard
        # see app/views/items/_default.html.erb
        # <%= render partial: "scans/scan_bxslider", object: item.scans.order(:minor_seq) %>
        @ranked_members = Member.all.order(:scans_accepted).reverse
    end

    def outline
        @all_items = Item.all_except_sub
    end

    # best way to route by param other than :id
    def item_view
        @item = Item.find_by_fa_seq!(params[:fa_seq])
        # TODO refactor into above
        params[:item_id] = @item.id
        if Rails.env.development? and params[:debug]
            render "items/horror_show"
        else
            render "items/show"
        end
    rescue ActiveRecord::RecordNotFound => e
        flash[:alert] = "Invalid item sequence? #{e.message}"
        # https://www.google.ie/search?q=rails+redirect+back+or+root
        redirect_to :back
    end
end
