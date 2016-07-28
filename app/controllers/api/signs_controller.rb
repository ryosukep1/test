class Api::SignsController < Api::Base

    # ログインAPI
    # スタブとして仮実装中
    def create
        @result = {
            token: "stub_token",
        }
        
        #raise Application::Exceptions::ErrCode000Error.new
        
        sleep 1
        
        render json: @result
    end
    
    # ログアウトAPI
    def delete
        puts "------params: #{params}"
        
        @result = {}
        
        raise Application::Exceptions::ErrCode004Error.new
        
        render json: @result
    end
end