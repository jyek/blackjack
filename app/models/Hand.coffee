class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    if @score() > 21 then @stand()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  score: ->
    result = @.scores()
    if result[1] <= 21 and result[1]?
      return result[1]
    result[0]

  stand: ->
    #alert "hello"
    @.trigger 'stand', @

  dealerPlay: ->
    @at(0).flip()
    # on Stand if the dealer has less than 17 he hit a card himself
    while @score() < 17
      @hit()