Vue = require("../../shared")

make = ->
  new Vue
    validations:
      "user.value": "required"


describe "validator: required", ->
  it "shoud validate true", ->
    component = make()
    component.$set("user.value", true)
    expect(component.$validate()).equal(true)

  it "shoud validate false", ->
    component = make()
    component.$set("user.value", false)
    expect(component.$validate()).equal(false)

  it "should validate 0", ->
    component = make()
    component.$set("user.value", 0)
    expect(component.$validate()).equal(true)

  it "should validate -1", ->
    component = make()
    component.$set("user.value", -1)
    expect(component.$validate()).equal(true)

  it "should validate '0'", ->
    component = make()
    component.$set("user.value", "0")
    expect(component.$validate()).equal(true)

  it "should validate ''", ->
    component = make()
    component.$set("user.value", "")
    expect(component.$validate()).equal(false)

  it "should validate '    '", ->
    component = make()
    component.$set("user.value", "    ")
    expect(component.$validate()).equal(false)

  it "should validate 'asdasd'", ->
    component = make()
    component.$set("user.value", "asdasd")
    expect(component.$validate()).equal(true)
