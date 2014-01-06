class Note < ActiveRecord::Base
    self.inheritance_column = 'need_to_figure_out_single_table_inheritance'
    
    belongs_to :item
    belongs_to :scan

    # enum type: [ :text, :image ]

    TEXT=1
    IMAGE=2

    def img_tag
        jpeg_base_64 = Base64.strict_encode64(bytes)
        "<img style='max-width: 100%; max-height: 100%;' src='data:image/png;base64,#{jpeg_base_64}' />"
    end
end
