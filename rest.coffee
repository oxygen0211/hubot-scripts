module.exports = (robot) ->
  robot.router.post '/automation/alert', (request, response) ->
    data   = if request.body.payload? then JSON.parse request.body.payload else request.body
    robot.messageRoom 'automation', "#{data.message}"

    response.send 'OK'
