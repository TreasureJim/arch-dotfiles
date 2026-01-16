function logout --wraps='swaymsg exit' --description 'alias logout swaymsg exit'
  swaymsg exit $argv
        
end
