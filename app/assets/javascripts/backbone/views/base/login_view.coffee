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
        
        # 入力フォームの入力値を取得
        #val_login_id_input = $("#login_id_input").val()
        val_login_id_input = @$el.find("#login_id_input").val()
        val_password_input = @$el.find("#password_input").val()
        
        # アカウントに対して認証情報を登録する
        if true
        
            # 認証情報を登録できた場合
            if true
                
                # 認証情報が更新されたよ と報告
                #   第一引数：最新の認証トークン
                App.mediator.trigger('finish:token:update', 'token_sample')
            
            # APIレスポンスがエラー系だった場合
        
