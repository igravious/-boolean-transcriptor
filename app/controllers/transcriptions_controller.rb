class TranscriptionsController < ApplicationController
    def new
        begin
            scan_id = params[:scan_id]
            aspect = params['aspect']
            whence = params['whence']
            q = params['q']
            @scan = Scan.find scan_id
            raise "Not a blank transcription" unless @scan.state == Scan::VIRGIN
            @scan.state = Scan::BEING_EDITED
            @scan.save!
            ok = "A freshly baked transcription"
        rescue Exception => oops
            redirect_to :back, alert: oops.message
        else
            redirect_to edit_transcription_path(id: scan_id, aspect: aspect, q: q, whence: whence), notice: ok
        end
    end

    def edit
        @scan = Scan.find(params[:id])
        # XXX is this X-rated?
        params[:scan_id] = params[:id]
        params.delete(:id)
        @item = Item.find @scan.item_id
    end

    def update
        begin
            scan_id = params[:id]
            aspect = params['aspect']
            whence = params['whence']
            q = params['q']
            @scan = Scan.find scan_id
            if params[:lock_button]
                raise "You gotta be signed in to lock a transcription" unless member_signed_in?
                raise "Unable to lock transcription (already locked perhaps?)" unless @scan.state == Scan::BEING_EDITED
                @scan.state = Scan::LOCKED
                @scan.save!
                ok = "Locked transcription for #{Scan::CAPTURE_TIME} hours"
            elsif params[:unlock_button]
                raise "It is tricky to unlock something that is not locked" unless @scan.state == Scan::LOCKED
                if member_signed_in? and (current_member.special? or current_member.matches_whodunnit? @scan)
                    @scan.state = Scan::BEING_EDITED
                    @scan.save!
                    ok = "Unlocked transcription"
                else
                    # TODO
                    not_privileged_enough
                end
            elsif params[:review_button]
                if @scan.state == Scan::LOCKED
                    raise "You can't submit this unless you locked it" unless member_signed_in? and (current_member.matches_whodunnit? @scan)
                    @scan.state = Scan::IN_REVIEW
                    @scan.save!
                    ok = "Transcription now in review"
                elsif @scan.state == Scan::BEING::EDITED
                    @scan.state = Scan::IN_REVIEW
                    @scan.save!
                    ok = "Transcription now in review"
                else
                    raise "Not possible to place this transcription under review"
                end
            else
                if @scan.transcription != params[:scan][:transcription]
                    # TODO wiki stuff
                    #
                    # make a list of wikilinks tuples
                    # https://en.wikipedia.org/wiki/Controlled_vocabulary
                    #
                    wikify = Creole::creolize(params[:scan][:transcription])
                    noko = Nokogiri::HTML.fragment(wikify)
                    @existing = []
                    @must_create = []
                    noko.css('a').each do |e|
                        h = Heading.where('index_term = ?', (URI.unescape e['href']).gsub('+',' ')).first
                        if h
                            # the index term already exists, keep the same index type
                            @existing <<= h
                        else
                            # new index term
                            @must_create <<= e
                        end
                    end
                    @to_delete = Locator.where('scan_id = ?', @scan.id)

                    # @scan.transcription = params[:scan][:transcription]
                    # @scan.save!
                    if @must_create.length
                        render "interstitial"
                        ok = "need type info"
                    else
                        if @to_delete.length
                            ok = "should delete some"
                        else
                            ok = "Updated transcription"
                        end
                        redirect_to edit_transcription_path(id: scan_id, aspect: aspect, q: q, whence: whence), notice: ok
                    end
                else
                    ok = "No need to update, transcription unchanged"
                    redirect_to edit_transcription_path(id: scan_id, aspect: aspect, q: q, whence: whence), notice: ok
                end
            end
            @item = Item.find @scan.item_id
        rescue Exception => oops
            redirect_to edit_transcription_path(id: scan_id, aspect: aspect, q: q, whence: whence), alert: oops.message
        else
            redirect_to edit_transcription_path(id: scan_id, aspect: aspect, q: q, whence: whence), notice: ok
        end
    end

    private

end
