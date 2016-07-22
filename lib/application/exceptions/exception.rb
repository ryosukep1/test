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
            def initialize(message = '')
                error_code = "API_ERR_CODE_000"
                super(error_code, message)
            end
        end
        
        class ErrCode001Error < ErrCodeCommonError
            def initialize(message = '')
                error_code = "API_ERR_CODE_001"
                super(error_code, message)
            end
        end
        
        class ErrCode002Error < ErrCodeCommonError
            def initialize(message = '')
                error_code = "API_ERR_CODE_002"
                super(error_code, message)
            end
        end
        
        class ErrCode003Error < ErrCodeCommonError
            def initialize(message = '')
                error_code = "API_ERR_CODE_003"
                super(error_code, message)
            end
        end
        
        class ErrCode004Error < ErrCodeCommonError
            def initialize(message = '')
                error_code = "API_ERR_CODE_004"
                super(error_code, message)
            end
        end
    end
end