requestAnimFrame = require "animationframe"
module.exports = () ->
  nextFrame = false
  runs(() -> requestAnimFrame( () -> nextFrame = true ))
  waitsFor(()-> return nextFrame )
