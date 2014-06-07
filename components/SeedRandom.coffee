noflo = require 'noflo'
seedrandom = require 'seedrandom'

class SeedRandom extends noflo.Component
  description: 'Generates a random number using a given string as seed'
  icon: 'random'
  constructor: ->
    @seed = null
    @prng = seedrandom('')

    @inPorts =
      seed: new noflo.Port 'string'
      in: new noflo.Port 'bang'
    @outPorts =
      out: new noflo.Port 'number'

    @inPorts.seed.on 'data', (data) =>
      if @seed isnt data
        @prng = seedrandom(data)

    @inPorts.in.on 'data', (data) =>
      if @outPorts.out.isAttached()
        randomValue = @prng()
        @outPorts.out.send randomValue
        
exports.getComponent = -> new SeedRandom
