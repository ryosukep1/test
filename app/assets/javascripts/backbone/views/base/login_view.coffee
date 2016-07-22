# 管理対象
#   ログインAPI実行
#   ログインID入力フォーム
#   パスワード入力フォーム
#   ログイン実行ボタン
class GameGui.Views.Base.LoginView extends Backbone.View
    
    el: '#login_panel'
    
    template: _.template JST['templates/base/login_panel']()
    
    initialize: ->
        # 指定時間後にエラーメッセージを非表示にするオブジェクト
        @interval_obj_hide_error_message = null
        
        this.delegateEvents({
            'click #login_btn': 'execLogin'
        })

    # 指定時間後にエラーメッセージを非表示するように設定する
    makeReservationHideErrorMessage: (m_seq)->
        @interval_obj_hide_error_message = setTimeout =>
            @hideErrorMessage()
        , m_seq
    
    # パネルを破棄する
    close: ->
        @canselReservationHideErrorMessage()
        @remove()
        
    # エラーメッセージを非表示にする設定を停止する
    canselReservationHideErrorMessage: ->
        clearTimeout(@interval_obj_hide_error_message)

    # パネルを初期表示する
    renderInit: ->
        @$el.html @template
        
    # ログインを実施する
    execLogin: ->
        
        # ログイン中画像を表示
        @$el.find("#login_execting_img").show()
        
        # 入力フォームを非表示
        @$el.find("#login_form").hide()
        
        # エラーメッセージの非表示予約をキャンセルし、すぐに非表示にする
        @canselReservationHideErrorMessage()
        @hideErrorMessage()

        # 入力フォームの入力値を取得
        val_login_id_input = @$el.find("#login_id_input").val()
        val_password_input = @$el.find("#password_input").val()
        
        # アカウントに対して認証情報を登録する
        sign_model = new GameGui.Models.Sign
        input_params = 
            account_id: val_login_id_input
            password: val_password_input
        sign_model.set(input_params)
        sign_model.save()
            .done =>
                # 認証情報を登録できた場合
                console.log('sign_model.save done')
                console.log(sign_model.get('token'))

                # 認証情報が更新されたよ と報告
                #   第一引数：最新の認証トークン
                App.mediator.trigger('finish:token:update', 'token_sample')

            .fail (jqXHR, textStatus, errorThrown) =>
                # APIレスポンスがエラー系だった場合
                console.log('sign_model.save fail')
                
                switch jqXHR.responseJSON.error_code
                    when "API_ERR_CODE_001"
                        # 表示したエラーメッセージは5秒後に非表示にする
                        @$el.find("#login_fail_001_img").show()
                        @makeReservationHideErrorMessage(1000 * 5)
                        
                    when "API_ERR_CODE_002"
                         # 表示したエラーメッセージは5秒後に非表示にする
                        @$el.find("#login_fail_002_img").show()
                        @makeReservationHideErrorMessage(1000 * 5)
                        
                    when "API_ERR_CODE_003"
                        console.log("オーダータイムアウト")
                        
                    when "API_ERR_CODE_004"
                        console.log("オーダーエラー")
                    
                    when "UNKNOWN"
                        console.log('不明')
                
                # ログイン中画像を非表示
                @$el.find("#login_execting_img").hide()
                
                # 入力フォームを表示
                @$el.find("#login_form").show()



    # 表示中のエラーメッセージを非表示にする
    hideErrorMessage: ->
        
        @$el.find("#login_fail_001_img").hide('fade')
        @$el.find("#login_fail_002_img").hide('fade')