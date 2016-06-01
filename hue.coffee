username = "upgWHMsNmzq-5AeZPtGImxdmIWbamgbdbPh4PetC";
baseurl = "http://192.168.2.157/api/"+username;

module.exports = (robot) ->

   robot.hear /list lights/i, (res) ->
     robot.http("#{baseurl}/lights").get() (err, res, body) ->
       res.send "Connected lights: #{res}"
