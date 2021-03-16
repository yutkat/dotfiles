require('specs').setup{
  show_jumps  = true,
  min_jump = 30,
  popup = {
    delay_ms = 10,
    inc_ms = 10,
    blend = 40,
    width = 40,
    fader = require('specs').linear_fader,
    resizer = require('specs').shrink_resizer
  }
}
