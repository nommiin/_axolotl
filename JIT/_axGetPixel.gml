///_axGetPixel(x,y)
_axPixel = draw_getpixel_ext(argument0,argument1);
_axRed = _axPixel & 255;
_axGreen = (_axPixel >> 8) & 255;
_axBlue = (_axPixel >> 16) & 255;
