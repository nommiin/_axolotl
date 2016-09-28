/// -- Load Program
_axOutput = ds_list_create()
_axCartridge = sprite_add("cartridge.png",1,false,false,0,0)
_axSurface = surface_create(sprite_get_width(_axCartridge),sprite_get_height(_axCartridge))
_axWidth = sprite_get_width(_axCartridge)
_axHeight = sprite_get_height(_axCartridge)
surface_set_target(_axSurface)
draw_sprite(_axCartridge,0,0,0)
surface_reset_target()

/// -- Run Program
var _axRunning = false, _axContinue = true, _axStack = ds_stack_create(), _axStart = current_time;
_axPixel = c_white;
_axRed = _axPixel & 255;
_axGreen = (_axPixel >> 8) & 255;
_axBlue = (_axPixel >> 16) & 255;
surface_set_target(_axSurface)
for(var yy = 0; yy < _axHeight; yy++) {
    for(var xx = 0; xx < _axWidth; xx++) {
        if _axContinue {
            var _axPixel = _axGetPixel(xx,yy);
            if _axRunning {
                switch _axRed {
                    case 0: {
                        switch _axGreen {
                            case 0: {
                                switch _axBlue {
                                    case 0: {
                                        // __axpst (Program Start)
                                        _axRunning = true
                                    break}
                                }
                            break}    
                        }
                    break}
                    
                    case 128: {
                        switch _axGreen {
                            case 128: {
                                switch _axBlue {
                                    case 128: {
                                        // __axend (Program End)
                                        _axRunning = false
                                        _axContinue = false
                                    break}
                                }
                            break}
                            
                            case 64: {
                                switch _axBlue {
                                    case 128: {
                                        // __axprt (Print)
                                        var _axString = "";
                                        while !ds_stack_empty(_axStack) {
                                            _axString = string_insert(string(ds_stack_pop(_axStack)),_axString,1)
                                        }
                                        ds_list_add(_axOutput,_axString)
                                    break}
                                }
                            break}
                        }
                    break}
                    
                    case 255: {
                        switch _axGreen {
                            case 200: {
                                switch _axBlue {
                                    case 16: {
                                        // __axpus (Push String)
                                        xx++
                                        if xx > _axWidth {xx = 0; yy++}
                                        _axGetPixel(xx,yy)
                                        if _axRed == 255 && _axGreen = 255 {
                                            repeat(_axBlue) {
                                                xx++
                                                if xx > _axWidth {xx = 0; yy++}
                                                _axGetPixel(xx,yy)
                                                if _axRed == 99 && _axGreen == 99 {
                                                    ds_stack_push(_axStack,chr(_axBlue))
                                                }
                                            }
                                        }
                                    break}
                                }
                            break}
                        }
                    break}
                }
            } else {
                if _axRed == 0 && _axGreen == 0 && _axBlue == 0 {
                    _axRunning = true
                }
            }
        }
    }
}
surface_reset_target()
ds_list_add(_axOutput,"Compile Finished: " + string(current_time-_axStart) + "ms")
