username = "upgWHMsNmzq-5AeZPtGImxdmIWbamgbdbPh4PetC";
baseurl = "http://192.168.2.157/api/"+username;

module.exports = (robot) ->

  robot.hear /list lights/i, (res) ->
     robot.http("#{baseurl}/lights").get() (err, httpres, body) ->
      data = JSON.parse body
      names = ""

      for name, info of data
        names = names + info.name + ", "
      res.send "Connected lights: #{names}"

  robot.hear /turn (.*) light (.*)/i, (res)->
    state = res.match[1]
    lightName = res.match[2]

    turnon = false

    if state == "on"
      turnon = true
    else if state == "off"
      turnon = false
    else
      res.send "Can turn lights only on or off"
      return

    robot.http("#{baseurl}/lights").get() (err, httpres, body) ->
     data = JSON.parse body

     for name, info of data
       if info.name is lightName
         body = "on": turnon
         bodyjson = JSON.stringify body
         robot.http("#{baseurl}/lights/#{name}/state").put(bodyjson) (err, httpres, body) ->
           if err != null
             res.send "Switching light #{lightName} #{state} failed"
           else
             res.send "Light #{lightName} turned #{state}"

   robot.hear /nightmode/i, (res) ->
     res.send "entering night mode..."
     res.send "turning off hue lights..."
     robot.http("#{baseurl}/lights").get() (err, httpres, body) ->
      data = JSON.parse body

      for name, info of data
        body = "on": false
        bodyjson = JSON.stringify body
        robot.http("#{baseurl}/lights/#{name}/state").put(bodyjson) (err, httpres, body) ->
          if err != null
            res.send "Switching light #{lightName} #{state} failed"
     res.send "good night"
