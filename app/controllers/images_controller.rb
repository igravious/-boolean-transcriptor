
# http://stackoverflow.com/questions/11959203/rails-3-displaying-jpg-images-from-the-local-file-system-above-rails-root

class ImagesController < ApplicationController
    def serve
        send_file( path,
                  :disposition => 'inline',
                  :type => 'image/jpeg',
                  :x_sendfile => true )
    end

    def portion
        # TODO process as a transaction
        fw     = (params['fw']).to_f
        tiw    = (params['tiw']).to_f
        nw     = (params['nw']).to_f
        til    = (params['til']).to_f
        tpl    = (params['tpl']).to_f
        tit    = (params['tit']).to_f
        tpt    = (params['tpt']).to_f
        tih    = (params['tih']).to_f
        nh     = (params['nh']).to_f
        require 'RMagick'
        scan   = Magick::ImageList.new(path).first
        size   = (fw/tiw*nw).round
        piece  = Magick::Image.new(size,size)
        width  = (((til+tpl).abs)/tiw*nw).round
        height = (((tit+tpt).abs)/tih*nh).round
        pixels = scan.dispatch(width, height, piece.columns, piece.rows, "RGB")
        store  = Magick::Image.constitute(piece.columns, piece.rows, "RGB", pixels)
        @note  = Note.new
        @reply = nil
        
        Note.transaction do
            @note.type = Note::IMAGE
            @note.save!
            tmp_file = "#{Rails.root}/tmp/note_grab#{@note.id}.jpeg"
            store.write(tmp_file)
            bytes = IO.read(tmp_file)
            @note.bytes = bytes
            @note.scan_id = params[:id]
            @reply = {:note_id => params['note_id'], :note_msg => render_to_string("cannot_figure_out", layout: false) }
        end
        @note.save
        logger.debug params.pretty_inspect
        render json: @reply
    end

    private

    def path
        # TODO error handling
        scan = Scan.find params[:id]
        "#{scan.directory}/#{scan.file_name}"
    end
end
