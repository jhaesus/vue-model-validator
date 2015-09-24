Vue = require("../../shared")

describe "validator: min", ->
  it "should validate minimum", ->
    component = new Vue
      validations:
        "user.images.length": "min: 1"
      data:
        user:
          images: []

    expect(component.$validate()).equal(false)

    component.$get("user.images").push({})

    expect(component.$validate()).equal(true)


