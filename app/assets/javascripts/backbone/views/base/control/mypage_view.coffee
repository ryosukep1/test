# 管理対象
class GameGui.Views.Base.Control.MypageView extends Backbone.View

    el: '#mypage_panel'
    
    template: _.template JST['templates/base/control/mypage_panel']()
    
    initialize: (token) ->
        @token = token
    
    # パネルを閉じる
    close: ->
        console.log('mypage panel close')
        # マイページパネルを閉じる
        @remove()
    
    # パネルを初期表示する
    renderInit: ->
        console.log('mypage panel render init')
        @$el.html @template
        
        # アカウント情報を取得する
        accounts = new GameGui.Collections.AccountsCollection
        accounts.fetchByToken(@token)
            .done =>
                # アカウント情報を取得できた場合
                account = accounts.first()
                
                # マイページパネルにアカウント情報を反映する
                @outputAccountInfo(account)
                
                # Now Loading をフェードアウト
                @$el.find("#load_account_info_executing_img").hide('fade')

            .fail (jqXHR, textStatus, errorThrown) =>
                # APIレスポンスがエラー系だった場合
                console.log('accounts_collection.fetch fail')
                
                # トークンが失効されたよ と報告
                App.mediator.trigger('invalid:token:authenticate')
    
    # アカウント情報をパネルに出力する
    outputAccountInfo: (account_model) ->
        
        @$el.find("#account_id_text").text(account_model.get('user_name'))