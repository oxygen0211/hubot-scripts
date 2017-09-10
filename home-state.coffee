homeAssistantURL = 'http://192.168.2.160:8123/api/'
api_password = 'jengelhardt211'

module.exports = (robot) ->
  robot.hear /lights/i, (res) ->
    robot.http("#{homeAssistantURL}/states")
    .header('x-ha-access': "#{api_password}")
    .get() (err, httpres, body) ->
      data = JSON.parse body

      res.send('Current light states:')

      for entity of data
        #check if entity is in domain light like light.buro
        if entity.entity_id.indexOf('light.') === 0
          res.send("#{entity_id}: #{entity_id.state}")
