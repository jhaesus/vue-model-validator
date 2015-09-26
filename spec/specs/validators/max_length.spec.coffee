Vue = require("../../shared")

make = ->
  new Vue
    validations:
      "user.name": "max_length: 5"

describe "validator: max_length", ->
  it "should validate 'aaaaa'", ->
    component = make()
    component.$set("user.name", "aaaaa")
    expect(component.$validate()).equal(true)

  it "should validate 'aaaaaa'", ->
    component = make()
    component.$set("user.name", "aaaaaa")
    expect(component.$validate()).equal(false)


