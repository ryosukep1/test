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
        
        # 対戦のエントリー中断報告を監視する
        @listenTo App.mediator, 'abort:game:entry',  =>

            # 適切なパネルを活性化する
            @activeAppropriatePanel()
    
    # パネルを破棄する
    close: ->
        console.log('control panel close')
        
        # マイページパネルを破棄する
        @closeMypagePanel()
        
        # 対戦パネルを破棄する
        @closeGamePanel()
        
        # コントロールパネルを破棄する
        @remove()
    
    # 対戦パネルを破棄する
    closeGamePanel: ->
        if @gameView?
            @gameView.close()
            @gameView = null
    
    # マイページパネルを破棄する
    closeMypagePanel: ->
        if @mypageView?
            @mypageView.close()
            @mypageView = null
        
    # パネルを初期表示する
    renderInit: ->
        console.log('control panel renderInit')
        @$el.html @template
        
        # 適切なパネルを活性化する
        @activeAppropriatePanel()

    
    # 適切なパネルを活性化する
    activeAppropriatePanel: ->
        
        # 適切なパネルを判定中画像を表示
        @$el.find("#activate_panel_executing_img").show()

        # アカウント情報を取得する
        accounts = new GameGui.Collections.AccountsCollection
        accounts.fetchByToken(@token)
            .done =>
                # アカウント情報を取得できた場合
                console.log('accounts_collection.fetch success')
                account = accounts.first()
                
                # アカウントが対戦をしていない場合
                if account.isGameNotPlaying()
                    
                    # マイページパネルを開く
                    @activateMyPagePanel()
                
                else
                    # 対戦パネルを活性化する
                    @activateGamePanel()
                
                # 適切なパネルを判定中画像を非表示
                @$el.find("#activate_panel_executing_img").hide()
                
            .fail (jqXHR, textStatus, errorThrown) =>
                # APIレスポンスがエラー系だった場合
                console.log('accounts_collection.fetch fail')
                
                # トークンが失効されたよ と報告
                App.mediator.trigger('invalid:token:authenticate')
                
        
    
    # マイページパネルを活性化する
    activateMyPagePanel: ->
        
        # 対戦パネルを閉じる
        @closeGamePanel()
        
        # マイページパネルを開く
        unless @mypageView?
            @$el.append '<div id="mypage_panel" class="mypage_panel_blk"></div>'
            @mypageView = new GameGui.Views.Base.Control.MypageView(@token)
            @mypageView.renderInit()
        
        # ログアウトボタン、対戦ボタンを表示
        @$el.find('#logout_btn').show()
        @$el.find('#game_btn').show()

    # 対戦パネルを活性化する
    activateGamePanel: ->
        
        # ログアウトボタン、対戦ボタンをフェードアウト
        @$el.find('#logout_btn').hide()
        @$el.find('#game_btn').hide()
        
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
        
        # 認証情報の破棄要求を受理したよ と報告
        App.mediator.trigger('requested:sign:delete')