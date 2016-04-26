# 管理対象
#   対戦エントリーパネル
#   対戦プレイパネル
#   対戦リザルトパネル
class GameGui.Views.Base.Control.GameView extends Backbone.View

    el: '#game_panel'
    
    #template: _.template JST['templates/base/control/game_panel']()
    
    initialize: (token) ->
        @token = token
    
    # パネルを破棄する
    close: ->
        console.log('game panel close')
        @remove()
    
    renderInit: ->
        console.log("game panel render init")
        
        