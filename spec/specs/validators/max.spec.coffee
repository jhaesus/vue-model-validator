Vue = require("../../shared")

describe "validator: max", ->
  it "should validate maximum", ->
    component = new Vue
      validations:
        "user.images.length": "max: 1"
      data:
        user:
          images: []

    expect(component.$validate()).equal(true)

    component.$get("user.images").push({})

    expect(component.$validate()).equal(true)

    component.$get("user.images").push({})

    expect(component.$validate()).equal(false)


