noflo = require 'noflo'
seedrandom = require 'seedrandom'

class RandomNumber extends noflo.Component
  description: 'Generates a random number using a given string as seed'
  icon: 'random'
  constructor: ->
    @seed = null
    @prng = seedrandom('')

    @inPorts =
      seed: new noflo.Port 'string'
      send: new noflo.Port 'bang'
    @outPorts =
      number: new noflo.Port 'number'

    @inPorts.seed.on 'data', (data) =>
      if @seed isnt data
        @prng = seedrandom(data)
      @compute()

    @inPorts.send.on 'data', (data) =>
      @compute()

  compute: ->
    return unless @outPorts.number.isAttached()
    randomValue = @prng()
    @outPorts.number.send randomValue
        
exports.getComponent = -> new RandomNumber
