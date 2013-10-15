helpers do
    def alert_error(text)
        '<div data-alert class="alert-box alert">'+text+'</div>'
    end
    
    def alert_success(text)
        '<div data-alert class="alert-box success">'+text+'</div>'
    end
    
    def flash_messenger(text, type)
        case type
            when 'error' 
                session[:msg] = self.alert_error(text)
            else 'success' 
                session[:msg] = self.alert_success(text)
        end
    end
    
    def flash_messenger_return()
        if session[:msg]    
            session[:msg]
            session.delete(:msg)
        end
    end
end