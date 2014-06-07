noflo = require 'noflo'
seedrandom = require 'seedrandom'

class SeedRandom extends noflo.Component
  constructor: ->
    @inPorts =
      seed: new noflo.Port 'string',
      in: new noflo.Port 'bang'
    @outPorts =
      out: new noflo.Port 'number'

    @inPorts.in.on 'data', (data) =>
      console.log seedrandom

exports.getComponent = -> new SeedRandom
