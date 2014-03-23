class NotesController < ApplicationController

    # index-like methods

    # normal index
    def index
        @all_notes = Note.all
    end

    # only type == TEXT
    def scribbled
        @all_notes = Note.where('type = ?', Note::TEXT)
    end

    # only type == IMAGE
    def snapped
        @all_notes = Note.where('type = ?', Note::IMAGE)
    end

    # ===

    def new
        # return an HTML (aitch, not haitch baby) form for creating a new
        # piece of text or an image grab
        @note = Note.new
        unless @note.bytes.nil?
            @note.bytes.force_encoding("UTF-8")
        end
        @note.type = Note::TEXT
        if params['item_id']
            @item = Item.find params['item_id']
            @note.item_id = @item.id
            render "new_for_item"
        elsif params['scan_id']
            @scan = Scan.find params[:scan_id]
            @note.scan_id = @scan.id
            @item = Item.find @scan.item_id
            render "new_for_scan"
        else
            raise ActionController::RoutingError.new("You'd like that, wouldn't you?")
        end
    end

    def destroy
        begin
            @note = Note.find params['id']
            @note.destroy
            flash[:notice] = "Happy happy joy joy, note destroyed"
        rescue Exception => e
            flash[:alert] = "Like, total bummer dude: #{e.message}"
        end
        redirect_to :back
    end

    def create
        begin
            # be the consumer of your own API
            @note = Note.new
            note = params['note']
            raise "Now, that's not good, highly problematic" if !note
            @note.bytes = note['bytes']
            raise "Now, that's not good, most unusual" if !@note.bytes
            @note.type = note['type']
            raise "Now, that's not good, dang it anyway" if !@note.type
            if ! note["item_id"].blank?
                @item = Item.find note['item_id']
                @note.item_id = @item.id
                if Note.where('type = ? AND bytes LIKE ? AND item_id = ?', @note.type, @note.bytes, @note.item_id).length > 0
                    raise "Oi! Duplicate note by the looks of things"
                end
            elsif ! note["scan_id"].blank?
                @scan = Scan.find note['scan_id']
                @note.scan_id = @scan.id
                if Note.where('type = ? AND bytes LIKE ? AND scan_id = ?', @note.type, @note.bytes, @note.scan_id).length > 0
                    raise "Ahem, duplicate note by the looks of things"
                end
                @item = Item.find @scan.item_id
            else
                raise "Current state of play dictates that a note must belong to an item or a scan I reckon"
            end
            # @items = Item.where("fa_structure = ?", params[:fa_structure])
            @note.save
            flash[:notice] = "Note successfully created methinks"
        rescue Exception => e
            flash[:alert] = "God damn it to hell and back: #{e.message}"
        end
        redirect_to :back
    end

    def edit
        begin
            @note = Note.find params['id']
            unless @note.bytes.nil?
                @note.bytes.force_encoding("UTF-8")
            end
            render 'edit'
        rescue Exception => e
            flash[:alert] = "Oh fiddlesticks: #{e.message}"
            redirect_to :back
        end
    end

    def update
        begin
            @note = Note.find params['id']
            unless @note.bytes.nil?
                @note.bytes.force_encoding("UTF-8")
            end
            note = params['note']
            # could do bulk update but i ain't
            @note.update_attribute(:bytes, note['bytes'])
            flash[:notice] = "Happy happy joy joy, note updated"
        rescue Exception => e
            flash[:alert] = "I don't know how to tell you this but: #{e.message}"
        end
        redirect_to :back
    end

end
