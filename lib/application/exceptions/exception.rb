# エラークラス定義
module Application
    module Exceptions
        class CommonError < StandardError
            attr_reader :status, :error_code, :message
            def initialize(status, error_code, message)
                @status = status
                @error_code = error_code
                @message = message
            end
        end
        
        class ErrCodeCommonError < CommonError
            def initialize(error_code, message)
                status = 400
                super(status, error_code, message)
            end
        end
        
        class ErrCode000Error < ErrCodeCommonError
            def initialize(message)
                error_code = "API_ERR_CODE_001"
                super(error_code, message)
            end
        end
    end
end