# 認証情報
class GameGui.Models.Account extends Backbone.Model
    urlRoot: '/accounts'
    #idAttribute: "account_id"
    
    # アカウントが対戦していない状態か否か
    isGameNotPlaying: ->
        game_status = @get('game_status')
        return (game_status == 'free')
    
class GameGui.Collections.AccountsCollection extends Backbone.Collection
    model: GameGui.Models.Account
    url: '/accounts'

    parse: (data) ->
        return data['accounts']
    
    # トークンを指定してアカウント情報を取得する
    fetchByToken: (token) ->
        params = {
            token: token
        }
        @fetch(data: params)