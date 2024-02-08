local g = vim.g

if g.neovide then
  -- Put anything you want to happen only in Neovide her
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
  vim.opt.linespace = 0
  g.neovide_refresh_rate = 120
  g.neovide_scale_factor = 1.0
  g.neovide_padding_top = 0
  g.neovide_padding_bottom = 0
  g.neovide_padding_right = 0
  g.neovide_padding_left = 0
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor((255 * g.transparency) or 0.8))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of
  -- content and title bar.
  g.neovide_transparency = 0.8
  -- g.neovide_background_color = ("#0f1117" .. alpha())
  -- hide mouse when typing
  g.neovide_hide_mouse_when_typing = true
  -- VFX Effects: railgun, torpedo, pixiedust, sonicboom, ripple, wireframe
  g.neovide_cursor_vfx_mode = "torpedo"
  g.neovide_cursor_vfx_particle_speed = 1.0
  g.neovide_cursor_vfx_opacity = 0.1

  g.neovide_cursor_vfx_particle_density = 1.0
  g.neovide_cursor_vfx_particle_lifetime = 0.1
  g.neovide_cursor_vfx_particle_phase = 10.5 -- only for railgun
  g.neovide_cursor_vfx_particle_curl = 10.0 -- only for railgun
end
