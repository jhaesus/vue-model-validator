Vue = require("../../shared")

make = ->
  new Vue
    validations:
      "user.images.length": "max: 1"
    data:
      user:
        images: []

describe "validator: max", ->
  it "should validate []", ->
    component = make()
    expect(component.$validate()).equal(true)

  it "should validate [{}]", ->
    component = make()
    component.$get("user.images").push({})
    expect(component.$validate()).equal(true)

  it "should validate [{}, {}]", ->
    component = make()
    component.$get("user.images").push({})
    component.$get("user.images").push({})
    expect(component.$validate()).equal(false)


