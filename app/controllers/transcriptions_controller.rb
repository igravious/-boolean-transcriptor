class TranscriptionsController < ApplicationController
    def new
        scan = Scan.find params[:scan_id]
        scan.state = Scan::BEING_EDITED
        scan.save
        not
        redirect_to edit_transcription_path(id: scan.id, aspect: params['aspect'])
    end

    def edit
        @scan = Scan.find params[:id]
        @item = Item.find @scan.item_id
    end

    def update
        begin
            scan_id = params[:id]
            aspect = params['aspect']
            ok = "Updated transcription"
            @scan = Scan.find scan_id
            if @scan.transcription != params[:scan][:transcription]
                @scan.transcription = params[:scan][:transcription]
                @scan.save
            else
                ok = "Transcription unchanged"
            end
            @item = Item.find @scan.item_id
        rescue oops
            redirect_to edit_transcription_path(id: scan_id, aspect: aspect), alert: oops.message
        else
            redirect_to edit_transcription_path(id: scan_id, aspect: aspect), notice: ok
        end
    end
end
