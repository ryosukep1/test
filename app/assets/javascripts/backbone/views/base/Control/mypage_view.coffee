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
        if true
            
            # アカウント情報を取得できた場合
            if true
                
                # マイページパネルにアカウント情報を反映する
                @outputAccountInfo()
                
                # Now Loading をフェードアウト
                @$el.find("#now_loading_img").hide('fade')
    
    # アカウント情報をパネルに出力する
    outputAccountInfo: ->
        
        @$el.find("#account_id_text").text('account_id_sample')