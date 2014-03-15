#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    # this initialize a deck
    @set 'deck', deck = new Deck()
    # this creates a property player hand and retrieves it from the deck model
    @set 'playerHand', deck.dealPlayer()
    # this creates a property dealer hand and retrieves it from the deck model
    @set 'dealerHand', deck.dealDealer()

    @set 'message' , ''

    @get('playerHand').on 'stand', =>
      @get('dealerHand').dealerPlay()
      @compare()

  compare: ->
    playerScore = @get('playerHand').score()
    dealerScore = @get('dealerHand').score()

    if (dealerScore > playerScore and dealerScore <= 21) or playerScore > 21
      # alert "you lost"
      @set 'message', 'you lost'
    else if playerScore == 21
      # alert "you win"
      @set 'message', 'you win'
    else if dealerScore == playerScore
      # alert "you draw"
      @set 'message', 'you draw'
    else
      # alert "you win"
      @set 'message', 'you win'

    @trigger 'endGame'