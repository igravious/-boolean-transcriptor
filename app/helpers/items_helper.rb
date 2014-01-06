module ItemsHelper

    ### how?
    def item_path_with_params
        item_path_without_aspect(id, aspect: params['aspect'], q: params['q'])
    end

    ### assign remember <- legacy
    # alias_method :item_path_without_aspect, :item_path
    ### replace legacy <- improved
    # alias_method :item_path, :item_path_with_aspect

end
