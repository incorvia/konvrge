# Event Model / View CoffeeScript
# -------------------------------

# Vote object constructor
class Voteable
  constructor: (@model, @id, @question_id) ->

# Vote function
vote = (voteable) ->
  $.ajax '/vote',
    dataType: "json"
    data: {vote: voteable}
    type: "POST"

# Star status selector
jQuery ->
  $('.vote[data-current-vote = \"up\"]').addClass('on')

jQuery ->
  $('.vote[data-function = \"voteable\"]').click ->
    $vote = new Voteable
    $vote.id = $(this).attr('data-id')
    $vote.model = $(this).attr('data-model')
    $val = $('span[data-function = "vote_count"][data-model =  ' + $vote.model + '][data-id = ' + $vote.id + ']').html()

    if $(this).attr('data-question-id')
      $vote.question_id = $(this).attr('data-question-id')

    if $(this).attr("data-current-vote") == "up"
      $(this).removeClass('on')
      $(this).attr("data-current-vote", "nil")
      $('span[data-function = "vote_count"][data-model =  ' + $vote.model + '][data-id = ' + $vote.id + ']').html ->
        +$val - 1
      vote $vote

    else
      $(this).addClass('on')
      $(this).attr("data-current-vote", "up")
      $('span[data-function = "vote_count"][data-model =  ' + $vote.model + '][data-id = ' + $vote.id + ']').html ->
        +$val + 1
      vote $vote

# Answer input toggle
jQuery ->
  $("a[data-function = toggle_input]").click ->
    $id = $(this).attr 'data-id'
    $("div[data-id =" + $id + "][data-function = input]").animate({height: 'toggle'})
    return false

