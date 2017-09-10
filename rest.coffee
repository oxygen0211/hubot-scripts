module.exports = (robot) ->
  robot.router.post '/automation/alert', (request, response) ->
    message = request.body.message
    robot.messageRoom 'automation', "#{message}"

    response.send 'OK'
