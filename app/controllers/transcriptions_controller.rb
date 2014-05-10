class TranscriptionsController < ApplicationController
    def new
        begin
            scan_id = params[:scan_id]
            aspect ||= params['aspect']
            whence ||= params['whence']
            q ||= params['q']
            @scan = Scan.find scan_id
            raise "Not a blank transcription" unless @scan.state == Scan::VIRGIN
            @scan.state = Scan::BEING_EDITED
            @scan.save!
            ok = "A freshly baked untouched transcription"
        rescue Exception => oops
            redirect_to :back, alert: oops.message
        else
            redirect_to edit_transcription_path(id: scan_id, aspect: aspect, q: q, whence: whence), notice: ok
        end
    end

    def edit
        @scan = Scan.find(params[:id])
        params[:scan_id] = params[:id]
        params.delete(:id)
        @item = Item.find @scan.item_id
    end

    def show
        @scan = Scan.find(params[:id])
        params[:scan_id] = params[:id]
        params.delete(:id)
        @item = Item.find @scan.item_id
        render "edit"
    end

    def update
        begin
            # config.log_level = :debug
            # Rails.logger.debug("Oh logger: #{params.inspect}")
            # Rails.logger.info("Oh params: #{params.inspect}")
            scan_id = params[:id]
            aspect ||= params['aspect']
            whence ||= params['whence']
            q ||= params['q']
            interstitial = false
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
                    raise "You can't submit this (while locked) unless you locked it" unless member_signed_in? and (current_member.matches_whodunnit? @scan)
                    @scan.state = Scan::IN_REVIEW
                    @scan.save!
                    ok = "Transcription now in review"
                elsif @scan.state == Scan::BEING_EDITED
                    @scan.state = Scan::IN_REVIEW
                    @scan.save!
                    ok = "Transcription now in review"
                else
                    raise "Not possible to place this transcription under review"
                end
            elsif params[:accept_button]
                if @scan.state == Scan::IN_REVIEW
                    raise "Need to be a bit more special" unless member_signed_in? and current_member.special?
                    @scan.state = Scan::COMPLETED
                    @scan.save!
                    Member::transcription_accept(@scan, params[:scan][:narrative])
                else
                    raise "impossible my dear bod"
                end
            elsif params[:reject_button]
                if @scan.state == Scan::IN_REVIEW
                    raise "Need to be a bit more special" unless member_signed_in? and current_member.special?
                    @scan.state = Scan::BEING_EDITED
                    @scan.save!
                    Rails.logger.info "***"
                    Member::transcription_reject(@scan, params[:scan][:narrative])
                else
                    raise "impossible my dear dude"
                end
            else
                if @scan.transcription != params[:scan][:transcription]
                    # TODO wiki stuff
                    #
                    # make a list of wikilinks tuples
                    # https://en.wikipedia.org/wiki/Controlled_vocabulary
                    #

                    # note that annotate is in params[:scan], not simply params
                    if params[:scan][:annotate] == "1"
                        wikify = Creole::creolize(params[:scan][:transcription])
                        noko = Nokogiri::HTML.fragment(wikify)
                        @existing_term = []
                        @assoc_wiki = []
                        @must_create = []
                        @refs_on_page = []
                        noko.css('a').each do |e|
                            Rails.logger.info("Oh noko.css('a').each : #{e.inspect}")
                            index_term = (URI.unescape e['href']).gsub('+',' ')
                            h = Heading.where('index_term = ?', index_term).first
                            if h
                                # the index term already exists, keep the same index term type
                                match = Locator.where('scan_id = ? AND content = ? AND heading_id = ?', @scan.id, e.text, h.id).first
                                if match.nil? # otherwise unchanged
                                    @existing_term <<= h
                                    @assoc_wiki <<= e
                                end
                            else
                                # new index term
                                @must_create <<= e
                            end
                            @refs_on_page <<= e
                        end
                        # maybe don't destroy refereces if removed from all transcriptions?
                        @potential_delete = Locator.where('scan_id = ?', @scan.id)
                        @to_delete = []
                        @potential_delete.each do |l|
                            found = false
                            @refs_on_page.each do |e|
                                if l.content == e.text
                                    Rails.logger.info("#{l.content} == #{e.text}")
                                    # found it but maybe index term has changed
                                    index_term = (URI.unescape e['href']).gsub('+',' ')
                                    Rails.logger.info("index term #{index_term}")
                                    h = Heading.find l.heading_id
                                    Rails.logger.info("h is #{h.inspect}")
                                    if h.index_term == index_term
                                        found = true
                                    end
                                end
                            end
                            if !found # tis been deleted!
                                Rails.logger.info("Could not find #{l.content} on #{@scan.id} ... will delete ... #{l.inspect}")
                                @to_delete <<= l
                            end
                        end

                        Rails.logger.info("Oh existing_term: #{@existing_term.inspect}")
                        Rails.logger.info("Oh assoc_wiki: #{@assoc_wiki.inspect}")
                        Rails.logger.info("Oh must_create: #{@must_create.inspect}")
                        Rails.logger.info("Oh to_delete: #{@to_delete.inspect}")
                        Rails.logger.info("Oh potential_delete: #{@potential_delete.inspect}")
                        Rails.logger.info("Oh refs_on_page: #{@refs_on_page.inspect}")
                        if @must_create.length > 0 or @assoc_wiki.length > 0 or @to_delete.length > 0
                            ok = "should create or delete some"
                            interstitial = true
                        end
                    else
                        @scan.transcription = params[:scan][:transcription]
                        @scan.save!
                        ok = "(Not doing bulk.) The transcription was successfully updated"
                    end
                else
                    ok = "No need to update, transcription unchanged"
                end
            end
            @item = Item.find @scan.item_id
        rescue Exception => oops
            redirect_to edit_transcription_path(id: scan_id, aspect: aspect, q: q, whence: whence), alert: oops.message
        else
            if interstitial
                render "interstitial"
            else
                redirect_to edit_transcription_path(id: scan_id, aspect: aspect, q: q, whence: whence), notice: ok
            end
        end
    end

    def markup
        render json: {:markup => Creole::creolize(params['transcription'])}
    end

    private

end
