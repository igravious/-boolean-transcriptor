class SearchController < ApplicationController

    def index
        q = params['q']
        if q.nil? or !q or q == ''
            flash[:alert] = 'Unsearchable search term'
            redirect_to :back
        else
            @elapsed_time_in_secs = Benchmark.realtime { @items = Item.find(:all, :conditions => ['description LIKE ?', "%#{q}%"]) }
            @elapsed_time_in_secs += Benchmark.realtime { @scans = Scan.find(:all, :conditions => ['transcription LIKE ?', "%#{q}%"]) }
            flash[:notice] = "( #{@elapsed_time_in_secs.round(4)} seconds)"
        end
    end
end
