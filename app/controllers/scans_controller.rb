class ScansController < ApplicationController
    def index
        @item = Item.find params[:item_id]
        @scans = @item.scans
    end
end
