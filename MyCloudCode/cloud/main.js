
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

// Require and initialize the Twilio module with your credentials
Parse.Cloud.define("text", function(request, response) {
// Require and initialize the Twilio module with your credentials
var client = require('twilio')('ACf45135a1d712fedc464bcc1d6dd18f36', 'd2eb495b885d131fec4aaad1850b54be');

// Send an SMS message
client.sendSms({
    to:'+19739024752', 
    from: '+18622797466', 
    body: 'Hello world!'
  }, function(err, responseData) { 
    if (err) {
      console.log(err);
    } else { 
      console.log(responseData.from); 
      console.log(responseData.body);
      response.success("It worked.");
    }
  }
);
});

Parse.Cloud.beforeSave("Group", function(request, response) {
  
  
  var members = request.object.get("members");



  for (var i = 0; i < members.length; i++) { 
    var currentMember = members[i];
    var phoneNum = currentMember.object.get("phoneNumber");
    var query = new Parse.Query("User");
    query.equalTo("phoneNumber", phoneNum);
    query.find({
    success: function(results)
    {
        if ( results.length == 0 )
        {
            // not voted yet
            response.success("no existing vote");
        }
        else if ( results.length == 1)
        {
            // update existing vote
            result = results[0];
            result.object.set = ("Groups", result.object.get("Groups") + request.object.get("groupName"));

            result.save();        /// <---- This save isn't working

            response.success();
        }
        else
        {
            response.error("Multiple internal votes on object");
        }
    },
    error: function(error) {
        response.error("Query failed. Error = " + error.message);
    }
});
}
  response.success();
});