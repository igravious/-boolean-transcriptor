class SearchController < ApplicationController

    def index
        @elapsed_time_in_secs = Benchmark.realtime { @items = Item.find(:all, :conditions => ['description LIKE ?', "%#{params['q']}%"]) }
    end
end
