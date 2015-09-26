Vue = require("../../shared")

make = ->
  new Vue
    validations:
      "user.email": "email"

describe "validator: email", ->
  it "should validate 'test@email.com'", ->
    component = make()
    component.$set("user.email", "test@email.com")
    expect(component.$validate()).equal(true)

  it "should validate 'bla'", ->
    component = make()
    component.$set("user.email", "bla")
    expect(component.$validate()).equal(false)

  it "should validate undefined", ->
    component = make()
    expect(component.$validate()).equal(true)


