# 管理対象
#   対戦パネル
#   マイページパネル
#   ログアウト実行ボタン
#   対戦パネル表示ボタン
class GameGui.Views.Base.ControlView extends Backbone.View
    
    el: '#control_panel'
    
    template:  _.template JST['templates/base/control_panel']()
    
    initialize: (token) ->
        @token = token
        
        this.delegateEvents({
            'click #logout_btn': 'execLogout'
            'click #game_btn': 'activateGamePanel'
        })
    
    # パネルを破棄する
    close: ->
        console.log('control panel close')
        
        # マイページパネルを破棄する
        @closeMypagePanel()
        
        # 対戦パネルを破棄する
        if @gameView?
            @gameView.close()
            @gameView = null
        
        # コントロールパネルを破棄する
        @remove()
        
    # マイページパネルを破棄する
    closeMypagePanel: ->
        if @mypageView?
            @mypageView.close()
            @mypageView = null
        
    # パネルを初期表示する
    renderInit: ->
        console.log('control panel renderInit')
        @$el.html @template
        
        # アカウントが対戦状態である場合
        if false
            # 対戦パネルを活性化する
            @activateGamePanel()
        else
            # マイページパネルを開く
            unless @mypageView?
                @$el.append '<div id="mypage_panel" class="mypage_panel_blk"></div>'
                @mypageView = new GameGui.Views.Base.Control.MypageView(@token)
                @mypageView.renderInit()

    # 対戦パネルを活性化する
    activateGamePanel: ->
        
        # ログアウトボタン、対戦ボタンをフェードアウト
        #@$el.find('#logout_btn').hide('fade')
        @$el.find('#game_btn').hide('fade')
        
        # マイページパネルを閉じる
        @closeMypagePanel()
        
        # 対戦パネルを表示する
        unless @gameView?
            console.log('activate game panel non game panel')
            @$el.append '<div id="game_panel" class="game_panel_blk"></div>'
            @gameView = new GameGui.Views.Base.Control.GameView(@token)
            @gameView.renderInit()

    # ログアウトを実施する
    execLogout: ->
        console.log('exec logout')
        
        # アカウントに対する認証情報を破棄する
        if true
            
            # 認証情報を破棄できた場合
            if true
                
                # 認証情報が破棄されたよ と報告
                #   第一引数：最新の認証トークン
                App.mediator.trigger('finish:token:delete')