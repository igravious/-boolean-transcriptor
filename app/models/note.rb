class Note < ActiveRecord::Base
    self.inheritance_column = 'need_to_figure_out_single_table_inheritance'
    
    belongs_to :item
    belongs_to :scan

    has_paper_trail

    has_many :children, class_name: "Node", foreign_key: "parent_id"
    belongs_to :parent, class_name: "Node"
    # enum type: [ :text, :image ]

    TEXT=1
    IMAGE=2

    def img_tag
        "<img style='max-width:100%; max-height:100%;' src='#{src_data}'>"
    end

    def src_data
        jpeg_base_64 = Base64.strict_encode64(bytes)
        "data:image/jpeg;base64,#{jpeg_base_64}"
    end

    def user_visible_name
        what = 'thingy' # should never be thingy of course
        if type == Note::TEXT
            what = 'note'
        elsif type == Note::IMAGE
            what = 'snippet'
        end
        what
    end
end
