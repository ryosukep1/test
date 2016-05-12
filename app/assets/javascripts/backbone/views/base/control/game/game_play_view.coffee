# 管理対象
#   対戦コマンドAPI実行
#   チャレンジ実行ボタン
#   チャレンジ拒否ボタン
#   妨害許容ボタン
#   カード指定ボタン
#   色指定ボタン
class GameGui.Views.Base.Control.Game.GamePlayView extends Backbone.View

    el: '#game_play_panel'
    
    template: _.template JST['templates/base/control/game/game_play_panel']()
    
    initialize: (token) ->
        @token = token
        
        # 対戦進行の最新情報
        @obj_latest_game_progress = null
        
        # 対戦進行の遷移履歴リスト
        @objs_game_progress_history = null
        
        # 定期的に対戦の開始を確認する処理オブジェクト
        @interval_obj_check_game_start = null
        
        # 定期的に対戦の進行状況を確認する処理オブジェクト
        @interval_obj_check_game_progress = null
        
        # 定期的に対戦の進行を描画する処理オブジェクト
        @interval_obj_draw_game_progress = null
        
        # 共通のイベント監視定義
        @delegate_events_base = {}
        
        # 選択フォーム毎のイベント監視定義
        @delegate_events_selector_card = {}
        
        # イベント監視定義を更新する
        @updateDelegateEvents()
        
    # イベント監視定義を更新する
    updateDelegateEvents: ->
        
        # イベント監視定義を初期化する
        this.undelegateEvents()
        
        # イベント監視定義を設定する
        delegate_events_parameter = {}
        $.extend(delegate_events_parameter, @delegate_events_base, @delegate_events_selector_card)
        this.delegateEvents(delegate_events_parameter)
    
    # 定期的に対戦の開始を確認するように設定する（10秒間隔）
    startIntervalCheckGameStart: ->
        @interval_obj_check_game_start = setInterval =>
            @checkGameStart()
        , 10000
    
    # 定期的に対戦の進行を確認するように設定する（20秒間隔）
    startIntervalCheckGameProgress: ->
        @interval_obj_check_game_progress = setInterval =>
            @checkGameProgress()
        , 20000
    
    # パネルを破棄する
    close: ->
        console.log('game play panel close')
        
        # 定期処理設定を全て停止する
        @stopIntervalCheckGameStart()
        @stopIntervalCheckGameProgress()
        @stopIntervalDrawGameProgress()
        
        @remove()
    
    # 定期的に対戦の開始を確認する設定を停止する
    stopIntervalCheckGameStart: ->
        clearInterval(@interval_obj_check_game_start)
    
    # 定期的に対戦の進行を確認する設定を停止する
    stopIntervalCheckGameProgress: ->
        clearInterval(@interval_obj_check_game_progress)
    
    # 定義的に対戦の進行を描画する設定を停止する
    stopIntervalDrawGameProgress: ->
        clearInterval(@interval_obj_draw_game_progress)
    
    # パネルの初期表示
    renderInit: ->
        console.log("game play panel render init")
        @$el.html @template
        
        # 定期的に対戦の開始を確認するように設定する
        @startIntervalCheckGameStart()

    
    # 対戦の開始を確認する
    checkGameStart: ->
        console.log('check game start')
        
        # 対戦状況を取得する
        if true
            
            # 対戦状況を取得できた場合
            if true
                
                # 定期的に対戦の開始を確認することを止める
                @stopIntervalCheckGameStart()
                
                # Now Loading をフェードアウト
                @$el.find("#now_loading_img").hide('fade')
    
    # 対戦の進行状況を確認する
    checkGameProgress: ->
        console.log('check game progress')
    
    # 対戦の進行状況を描画する
    drawGameProgress: ->
        console.log('draw game progress')
    
    # 提出するカードを選択する
    selectCard: (ev) ->
        console.log("select card")
        #console.log($(ev.target).attr('id'))
        
        