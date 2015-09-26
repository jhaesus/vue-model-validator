Vue = require("../../shared")

make = ->
  new Vue
    validations:
      "user.email_confirmation": "equal_to: user.email"

describe "validator: equal_to", ->
  it "should validate as invalid", ->
    component = make()
    component.$set("user.email_confirmation", "test@email.com")
    expect(component.$validate()).equal(false)

  it "should validate as valid", ->
    component = make()
    component.$set("user.email_confirmation", "test@email.com")
    component.$set("user.email", "test@email.com")
    expect(component.$validate()).equal(true)


