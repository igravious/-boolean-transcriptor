class ScansController < ApplicationController
    def index
        @item = Item.find params[:item_id]
        # @scans = Scan.where(item_id: item.id).to_a
        @scans = @item.scan
    end
end
