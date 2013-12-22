class NotesController < ApplicationController
    # display a list of all notes
    def index
        @item = Item.find params[:item_id]
        # @scans = Scan.where(item_id: item.id).to_a
        @notes = @item.notes
    end

    def new
        # return an HTML form for creating a new photo
    end
end
