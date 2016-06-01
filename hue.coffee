username = "upgWHMsNmzq-5AeZPtGImxdmIWbamgbdbPh4PetC";
baseurl = "http://192.168.2.157/api/"+username;

module.exports = (robot) ->

   robot.hear /list lights/i, (res) ->
     robot.http("#{baseurl}/lights").get() (err, httpres, body) ->
      data = JSON.parse body
      names = ""

      for i of data
        names = names + i + ","
      res.send "Connected lights: #{names}"
