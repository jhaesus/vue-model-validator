Vue = require("../shared")

describe "$validate", ->
  it "should return true/false", ->
    component = new Vue
      validations:
        "user.email": "required"

    expect(component.$validate()).equal(false)

    component.$set("user.email", "test@email.com")

    expect(component.$validate()).equal(true)

  it "should accept which fields to validate", ->
    component = new Vue
      validations:
        "user.email": "required"
        "user.phone": "required"

    expect(component.$validate("user.email")).equal(false)

    component.$set("user.email", "test@email.com")

    expect(component.$validate("user.email")).equal(true)
    expect(component.$validate()).equal(false)
