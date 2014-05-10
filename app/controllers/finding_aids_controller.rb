class FindingAidsController < ApplicationController

    # TODO CONST
    def type
        # should i be doing somethihng in config/initializers/mime_types.rb ?
        # and using respond_to ?

        # "Mime types that start with text/ are to be processed as ISO-8859-1
        # unless another mime type is explicitly declared (e.g. text/html; 
        # charset=utf-8). Mime types that start with application/ are processed as UTF-8 
        case params['type']
        when "pdf"
            path = "http://booleweb.ucc.ie/documents/George_Boole_Descriptive_List.pdf"
            redirect_to path
        when "yaml"
            # https://en.wikipedia.org/wiki/YAML
            # http://stackoverflow.com/questions/332129/yaml-mime-type
            path = Rails.root.to_s+"/db/Boole_Finding_Aid.yml"
            send_file(  path, :disposition => 'inline', :type => 'application/x-yaml', :x_sendfile => true)
        when "ead"
            # https://en.wikipedia.org/wiki/Encoded_Archival_Description
            # EAD Report Card
            # http://www.oclc.org/research/activities/ead/reportcard.html?urlm=159904
            #
            path = Rails.root.to_s+"/db/boole_papers_ead.xml"
            send_file(  path, :disposition => 'inline', :type => 'application/ead+xml', :x_sendfile => true)
        when "edm"
            path = "http://pro.europeana.eu/technical-requirements"
            redirect_to path
        else
            # should this really be a redirect_to ?
            redirect_to root_path, notice: "Reckon I don't speak that language."
        end
    end

end
