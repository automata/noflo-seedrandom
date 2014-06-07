noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  SeedRandom = require '../components/SeedRandom.coffee'
else
  SeedRandom = require 'noflo-seedrandom/components/SeedRandom.js'

describe 'SeedRandom component', ->
  c = null
  ins = null
  out = null
  beforeEach ->
    c = SeedRandom.getComponent()
    ins = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.in.attach ins
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have an input port', ->
      chai.expect(c.inPorts.in).to.be.an 'bang'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'number'