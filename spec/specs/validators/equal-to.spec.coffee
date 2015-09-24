Vue = require("../../shared")

describe "validator: equal-to", ->
  it "should validate equalness", ->
    component = new Vue
      validations:
        "user.email_confirmation": "equal-to: user.email"

    component.$set("user.email_confirmation", "test@email.com")

    expect(component.$validate()).equal(false)

    component.$set("user.email", "test@email.com")

    expect(component.$validate()).equal(true)


