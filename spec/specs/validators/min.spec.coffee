Vue = require("../../shared")

make = ->
  new Vue
    validations:
      "user.login_count": "min: 1"

describe "validator: min", ->
  it "should validate undefined", ->
    component = make()
    expect(component.$validate()).equal(true)

  it "should validate 0", ->
    component = make()
    component.$set "user.login_count", 0
    expect(component.$validate()).equal(false)

  it "should validate 1", ->
    component = make()
    component.$set "user.login_count", 1
    expect(component.$validate()).equal(true)


