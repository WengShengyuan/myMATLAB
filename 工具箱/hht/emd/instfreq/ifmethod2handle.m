function iffunc = ifmethod2handle(ifmethod)
% ifmethod2handle translates old-style instantaneous frequency method names
% to function handles. This is depreciated and functionality relying on it
% will be removed. Function handles just look and work so much nicer.

switch ifmethod
    case 'hilbert'; iffunc = @fah;
    case 'acos'; iffunc = @faacos;
    case 'zc'; iffunc = @faz;
    otherwise
        iffunc = [];
end
