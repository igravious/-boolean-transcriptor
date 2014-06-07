class DeskPagesController < ApplicationController
    def desk
    end

    def browse
    end

	def faqs_n_guide
	end

	def member_scans
        return Scan.none unless member_signed_in?
		Scan.all.keep_if { |s| current_member.id == s.versions.last.whodunnit.to_i }
	end

	def accepted_scans
		return Scan.none unless member_signed_in?
		Scan.all.keep_if do |s|
			s.state == Scan::COMPLETED and current_member.id == s.versions.last.previous.whodunnit.to_i
		end 
	end

	def rejected_scans
		return Scan.none unless member_signed_in?
		Scan.all.keep_if do |s|
			s.state == Scan::BEING_EDITED and current_member.id == s.versions.last.previous.whodunnit.to_i and s.versions.last.reify.state == Scan::IN_REVIEW
		end
	end

    def locked_by_member
        @member_scans = member_scans
        @locked_scans = @member_scans.keep_if { |s| s.state == Scan::LOCKED }
    end

	def scans_by_member
        @member_scans = member_scans
		# @accepted_scans = current_member.accepted_scans
		@accepted_scans = accepted_scans
		# @rejected_scans = current_member.rejected_scans
		@rejected_scans = rejected_scans
		@member_scans = @member_scans + @accepted_scans + @rejected_scans
	end

	def member_notes
		return Note.none unless member_signed_in?
		Note.all.keep_if do |n|
			current_member.id == n.member_id
		end
	end

	def notes_by_member
		@member_notes = (member_signed_in? ? Note.where(member_id: current_member.id) : Note.none)
		@member_snippets = @member_notes.where('type = ?', Note::IMAGE)
		@member_endnotes = @member_notes.where('type = ?', Note::TEXT)
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
