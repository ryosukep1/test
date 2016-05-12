window.GameGui = 
    Models: {}
    Collections: {}
    Routers: {}
    Views: {
        Base: {
            Control: {
                Game: {}
            }
        }
    }

$(->
    window.App = {}
    App.mediator = _.extend {}, Backbone.Events
    App.router = new GameGui.Routers.MainRouter
    Backbone.history.stop()
    Backbone.history.start
        pushState: true
)