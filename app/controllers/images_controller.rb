
# http://stackoverflow.com/questions/11959203/rails-3-displaying-jpg-images-from-the-local-file-system-above-rails-root

class ImagesController < ApplicationController
    def serve
        send_file( path,
                  :disposition => 'inline',
                  :type => 'image/jpeg',
                  :x_sendfile => true )
    end

    def snap
        begin
            raise "We don't support creating snippets anonymously at the mo', sorry" if !member_signed_in?
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
                @note.member_id = current_member.id
                @note.save!
                tmp_file = "#{Rails.root}/tmp/note_grab#{@note.id}.jpeg"
                store.write(tmp_file)
                bytes = IO.read(tmp_file)
                @note.bytes = bytes
                @note.scan_id = params[:id]
                @reply = {:note_id => params['note_id'], :note_msg => render_to_string("notes/snap", layout: false) }
            end
            @note.save
        rescue Exception => e
            @reply = {:note_id => nil, :note_msg => e.message}
        end

        render json: @reply
    end

    def upload
        begin
            # TODO update image data, hmm, maybe a snippet/highlight is a resource
            data = params[:imgBase64]
            # remove all extras except data
            image_data = Base64.decode64(data['data:image/jpeg;base64,'.length .. -1])

            # tmp_file = "#{Rails.root}/tmp/note_grab#{id}.jpeg"
            # File.open(tmp_file, 'wb') do |f|
            #      f.write image_data
            # end
            @note = Note.find params[:id]
            # see comment in NotesController.destroy
            what = @note.user_visible_name # not really needed as you can see this is a text note, snippet update over at ImagesController.upload
            raise "You appear to be different from the person who created the #{what}, sorry" if !member_signed_in? or (@note.member_id != current_member.id)
            @note.bytes = image_data
            # should use proper update pattern
            @note.save
            render text: 'saved :)'
        rescue Exception => e
            render text: "Uh oh: #{e.message}"
        end

    end

    private

    def path
        # TODO error handling
        scan = Scan.find params[:id]
        "#{scan.directory}/#{scan.file_name}"
    end
end
