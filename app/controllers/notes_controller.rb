class NotesController < ApplicationController

    # index-like methods

    # normal index
    def index
        @all_notes = Note.all
    end

    # only type == TEXT
    def endnotes
        @all_notes = Note.where('type = ?', Note::TEXT)
    end

    # only type == IMAGE
    def snippets
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
        # not allowed to create anonymous notes
        what = @note.user_visible_name
        raise "The way this system works means you can't create a #{what} anonymously" if !member_signed_in?
        @note.member_id = current_member.id
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
    rescue Exception => e
        # def rescue end redirect_to pattern? i need to write the pattern for each {index|new|destroy|create|edit|update}
        flash[:alert] = "Woooah dude: #{e.message}"
        redirect_to :back
    end

    def destroy
        begin
            @note = Note.find params['id']
            # as notes/snippets cannot be created anonymously (why? is this really a necessary restriction?) you must be logged in to destroy
            what = @note.user_visible_name
            raise "You appear to be different from the person who created the #{what}, sorry" if !member_signed_in? or (@note.member_id != current_member.id)
            @note.destroy
            flash[:notice] = "Happy happy joy joy, #{what} destroyed"
        rescue Exception => e
            flash[:alert] = "Like, total bummer dude: #{e.message}"
        end
        redirect_to :back
    end

    def create
        begin
            raise "The commitee has decided that neither notes nor snippets are to be made anonymously, sowwy" if !member_signed_in? 
            # be the consumer of your own API
            @note = Note.new
            note = params['note']
            raise "Now, that's not good, highly problematic" if !note
            @note.type = note['type']
            raise "Now, that's not good, dang it anyway" if !@note.type
            what = @note.user_visible_name
            @note.bytes = note['bytes']
            raise "Now, that's not good, most unusual" if !@note.bytes
            raise "Why on earth would you want a blank #{what}?" if @note.bytes.blank?
            if ! note["item_id"].blank?
                @item = Item.find note['item_id']
                @note.item_id = @item.id
                if Note.where('type = ? AND bytes LIKE ? AND item_id = ?', @note.type, @note.bytes, @note.item_id).length > 0
                    raise "Oi! Duplicate #{what} by the looks of things"
                end
            elsif ! note["scan_id"].blank?
                @scan = Scan.find note['scan_id']
                @note.scan_id = @scan.id
                if Note.where('type = ? AND bytes LIKE ? AND scan_id = ?', @note.type, @note.bytes, @note.scan_id).length > 0
                    raise "Ahem, duplicate #{what} by the looks of things"
                end
                @item = Item.find @scan.item_id
            else
                raise "Current state of play dictates that a #{what} must belong to an item or a scan I reckon"
            end
            # @items = Item.where("fa_structure = ?", params[:fa_structure])
            @note.member_id = current_member.id
            @note.save
            flash[:notice] = "Your #{what} successfully created methinks"
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
            # see comment in destroy
            what = @note.user_visible_name # not really needed as you can see this is a text note, snippet update over at ImagesController.upload
            raise "You appear to be different from the person who created the #{what}, sorry" if !member_signed_in? or (@note.member_id != current_member.id)
            unless @note.bytes.nil?
                @note.bytes.force_encoding("UTF-8")
            end
            # could do bulk update but i ain't
            note = params['note']
            raise "Now, that's not good, deep(ly) undesirable" if !note
            @note.update_attribute(:bytes, note['bytes'])
            flash[:notice] = "Happy happy joy joy, #{what} updated"
        rescue Exception => e
            flash[:alert] = "I don't know how to tell you this but: #{e.message}"
        end
        redirect_to :back
    end

end
