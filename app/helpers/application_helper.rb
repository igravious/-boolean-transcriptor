module ApplicationHelper

    def switch_on toggle
        if params['controller'] == "pages"
            if params['action'] == "welcome" and toggle == "brand"
                return "brand-active"
            end
            if params['action'] == toggle
                return "active"
            end
        end
        ""
    end

end
