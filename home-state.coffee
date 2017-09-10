homeAssistantURL = 'http://192.168.2.160:8123/api'
apiPassword = 'jengelhardt211'

module.exports = (robot) ->
  robot.hear /light state/i, (res) ->
    robot.http("#{homeAssistantURL}/states")
    .header('x-ha-access', apiPassword)
    .get() (err, httpres, body) ->
      data = JSON.parse body

      res.send('Current light states:')
      for i,entity of data
        #check if entity is in domain light like light.buro
        console.log entity
        if entity.entity_id.indexOf('light.') == 0
          res.send("#{entity.entity_id}: #{entity.state}")

  robot.hear /packers mode/i, (res) ->
    robot.http("#{homeAssistantURL}/services/scene/turn_on")
    .header('x-ha-access', apiPassword)
    .post('{"entity_id":"scene.greenbaypackers"}') (err, httpres, body) ->
      res.send("Go, Pack, Go!")

  robot.hear /turn on lights/i, (res) ->
    robot.http("#{homeAssistantURL}/services/lights/turn_on")
    .header('x-ha-access', apiPassword)
    .post() (err, httpres, body) ->
      res.send("Lights are on")

  robot.hear /turn off lights/i, (res) ->
    robot.http("#{homeAssistantURL}/services/lights/turn_off")
    .header('x-ha-access', apiPassword)
    .post() (err, httpres, body) ->
      res.send("Lights are off")
