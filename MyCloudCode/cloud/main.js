
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

Parse.Cloud.beforeSave("tempUser", function(request, response) {
  

  /* Checks if there is already a User with this tempUser's phone number.
  *  If there is, it throws out the tempUser object.
  */
  var phoneNumber = request.object.get("phoneNumber");
  query = new Parse.Query("User");


  //there are no users, so create a tempuser for now
  if(!query){
    repsonse.success();
  }

  //there are users, so get the tempUser's phone number and check if there is already
  //a user with that phone number
  query.equalTo("phoneNumber", phoneNumber);
  query.count({
    success: function(count) {
      if (count > 0) {
        response.error("This user is already signed up, so no new tempUser will be created.");
      } else {
        response.success();
      }
    },
    error: function(error) {
      response.error("Error " + error.code + " : " + error.message + " when getting user with phoneNumber count.");
    }
  });

  // query.find({
  //   success: function(user) {
  //     user.
  //   error: function(error) {
  //     console.error("Error finding related comments " + error.code + ": " + error.message);
  //   }
  // });
});