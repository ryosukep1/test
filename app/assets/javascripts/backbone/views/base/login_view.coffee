# 管理対象
#   ログインAPI実行
#   ログインID入力フォーム
#   パスワード入力フォーム
#   ログイン実行ボタン
class GameGui.Views.Base.LoginView extends Backbone.View
    
    el: '#login_panel'
    
    template: _.template JST['templates/base/login_panel']()
    
    initialize: ->
        this.delegateEvents({
            'click #login_btn': 'execLogin'
        })

    # パネルを破棄する
    close: ->
        @remove()

    # パネルを初期表示する
    renderInit: ->
        @$el.html @template
        
    # ログインを実施する
    execLogin: ->
        
        # ログイン中画像を表示
        @$el.find("#login_execting_img").show()
        
        # 入力フォームを非表示
        @$el.find("#login_form").hide()

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
            .done ->
                # 認証情報を登録できた場合
                console.log('sign_model.save done')
                console.log(sign_model.get('token'))

                # 認証情報が更新されたよ と報告
                #   第一引数：最新の認証トークン
                App.mediator.trigger('finish:token:update', 'token_sample')

            .fail (jqXHR, textStatus, errorThrown) ->
                # APIレスポンスがエラー系だった場合
                console.log('sign_model.save fail')
                
                # ログイン中画像を非表示
                @$el.find("#login_execting_img").hide()
                
                # 入力フォームを表示
                @$el.find("#login_form").show()
