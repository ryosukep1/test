class Api::AccountsController < Api::Base

    # アカウント情報取得API
    # スタブとして仮実装中
    def index
        puts "------params: #{params}"
        
        @result = {
            accounts: {
                status: "free",
                game_status: "free",
                user_name: "stub_user_name",
            },
        }
        
        #raise Application::Exceptions::ErrCode006Error.new
        
        sleep 1
        
        render json: @result
    end
end