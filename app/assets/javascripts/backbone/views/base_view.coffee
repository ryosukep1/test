# 管理対象
#   認証情報
#   ログインフォームパネル
#   コントロールパネル
class GameGui.Views.BaseView extends Backbone.View

    el: '#gui'
    
    initialize: ->
        
        # 認証情報の更新報告を監視する
        @listenTo App.mediator, 'finish:token:update', (token) =>

            # 認証情報を管理する
            @token = token
            
            # 認証情報の有無に応じたパネル表示に切り替える
            @authenticate()
        
        # 認証情報の破棄報告を監視する
        @listenTo App.mediator, 'finish:token:delete', () =>
            
            # 認証情報を破棄する
            @token = null
            
            # 認証情報の有無に応じたパネル表示に切り替える
            @authenticate()
        

    # 認証情報の有無に応じて表示するパネルを制御する
    authenticate: ->
        
        # 認証情報を保持している場合
        if @token?
            
            # 認証状態としてのパネル表示に切り替える
            @renderLogined()
    
        # 認証情報を保持していない場合
        else
            
            # 未認証状態としてのパネル表示に切り替える
            @renderNotLogin()
        
    # 認証状態としてのパネル表示に切り替える
    renderLogined: ->
        console.log("show control panel")
        
        # ログインフォームパネルを閉じる
        if @loginView?
            @loginView.close()
            @loginView = null
        
        # コントロールパネルを表示する
        unless @controlView?
            @$el.append '<div id="control_panel" class="control_panel_blk"></div>'
            @controlView = new GameGui.Views.Base.ControlView(@token)
            @controlView.renderInit()
    
    # 未認証状態としてのパネル表示に切り替える
    renderNotLogin: ->
        
        # コントロールパネルを閉じる
        if @controlView?
            @controlView.close()
            @controlView = null
        
        # ログインフォームパネルを表示する
        unless @loginView?
            @$el.append '<div id="login_panel" class="login_panel_blk"></div>'
            @loginView = new GameGui.Views.Base.LoginView
            @loginView.renderInit()