class Api::SignsController < Api::Base

    # ログインAPI
    # スタブとして仮実装中
    def create
        @result = {
            token: "stub_token",
        }
        
        raise Application::Exceptions::ErrCode000Error.new
        
        sleep 3
        
        render json: @result
    end
end