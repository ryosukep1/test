# ゲーム情報を保持するオブジェクト
class GameGui.Objs.Game
    
    initialize: (data) ->
        @data = data
        @drawData = null
    
    # ゲームの進行状況を更新する
    updateData: (data) ->
        console.log('game obj update data')
        @data = data
    
    # ゲームの表示情報を更新する
    updateDrawData: ->
        console.log('game obj update drawdata')
        
    # ゲームの表示情報
    getDrawData: ->
        console.log('game obj get drawdata')
    
    