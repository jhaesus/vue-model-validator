Vue = require("../../shared")

describe "validator: email", ->
  it "should validate email", ->
    component = new Vue
      validations:
        "user.email": "email"

    component.$set("user.email", "test@email.com")

    expect(component.$validate()).equal(true)

    component.$set("user.email", "bla")

    expect(component.$validate()).equal(false)

    component.$set("user.email", null)

    expect(component.$validate()).equal(false)


