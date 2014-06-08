noflo = require 'noflo'
seedrandom = require 'seedrandom'

class RandomArray extends noflo.Component
  description: 'Generates an array of random numbers using a \
                given string as seed.'
  icon: 'folder-o'
  constructor: ->
    @min = null
    @max = null
    @count = null
    @seed = null
    @prng = seedrandom('')

    @inPorts = new noflo.InPorts
      seed:
        datatype: 'string'
      min:
        datatype: 'number'
      max:
        datatype: 'number'
      count:
        datatype: 'int'

    @outPorts = new noflo.OutPorts
      numbers:
        datatype: 'array'

    @inPorts.seed.on 'data', (data) =>
      @seed = data
      @compute()  

    @inPorts.min.on 'data', (data) =>
      @min = data
      @compute()

    @inPorts.max.on 'data', (data) =>
      @max = data
      @compute()

    @inPorts.count.on 'data', (data) =>
      @count = data
      @compute()

  compute: ->
    return unless @outPorts.numbers.isAttached()
    return unless @min? and @max? and @count? and @count >= 1
    
    # Restart the random generator everytime something change
    @prng = seedrandom(@seed)

    spread = @max - @min
    if @count is 1
      number = @min + @prng()*spread
      @outPorts.numbers.send number
    else
      numbers = []
      for i in [0..@count-1]
        numbers[i] = @min + @prng()*spread
      @outPorts.numbers.send numbers

exports.getComponent = -> new RandomArray
