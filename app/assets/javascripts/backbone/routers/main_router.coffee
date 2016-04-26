# URLに応じた画面の初期化処理を定義
class GameGui.Routers.MainRouter extends Backbone.Router

    initialize: ->
        @baseView ?= new GameGui.Views.BaseView
    
    routes:
        'gui': 'gui_init'
    
    gui_init: ->
        @baseView.authenticate()