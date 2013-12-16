class QwuxController < ApplicationController
    def new
        flash[:notice] = 'Note that Qwux'
        flash[:alert] = 'Alert that Qwux!'
    end
end
