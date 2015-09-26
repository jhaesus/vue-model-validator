Vue = require("../../shared")

make = ->
  new Vue
    validations:
      "user.name": "min_length: 5"

describe "validator: min_length", ->
  it "should validate 'aaaaa'", ->
    component = make()
    component.$set("user.name", "aaaaa")
    expect(component.$validate()).equal(true)

  it "should validate 'aaaaa'", ->
    component = make()
    component.$set("user.name", "aaaa")
    expect(component.$validate()).equal(false)

  it "should validate undefined", ->
    component = make()
    expect(component.$validate()).equal(true)


