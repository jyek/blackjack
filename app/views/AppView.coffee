class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button btn btn-primary">Hit</button>
    <button class="stand-button btn btn-info">Stand</button>
    <button class="bet-button btn btn-primary">Bet Now!!!!</button>
    <div class="message-results"></div>
    <div class="player-cash">$1,000,000</div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .bet-button": ->
      @model.initialize()
      @render()
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.on 'endGame', @endGame

    @model.on 'reset', =>
      @render()

  render: ->
    # alert @model.get 'message'
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.message-results').html(@model.get 'message').el

  endGame: =>
    @render()
    $('.hit-button').addClass('disabled')
    $('.stand-button').addClass('disabled')

  winning: =>
    @render()
    $cash = $('.player-cash').text()
    $('.player-cash').text($cash + 10000)