
# http://stackoverflow.com/questions/11959203/rails-3-displaying-jpg-images-from-the-local-file-system-above-rails-root

class ImagesController < ApplicationController
    def serve
        scan = Scan.find params[:id]
        path = Rails.root.to_s+"/#{scan.directory}/#{scan.file_name}"

        send_file( path,
                  :disposition => 'inline',
                  :type => 'image/jpeg',
                  :x_sendfile => true )
    end
end
