% Instantaneous frequency functions
%
% General functions
%   fa            - Find frequency and amplitude (generic; use if you don't know the others)
%
% Specific functions
%   faacos        - Find frequency by corrected arccosine; input must be normalized
%   fah           - Find frequency and amplitude using the corrected Hilbert transform
%   faz           - Find frequency and amplitude by Huang's Generalized
%                   Zero-Crossing Method
%
% Helper functions
%   hilbtm        - Computer Hilbert transform, corrected to avoid edge
%                   effects / Gibbs phenomena
%   ifmethod2handle - Translate an old-style instantaneous frequency method
%                     string into a new-style function handle
%
% All other functions in this directory are DEPRECIATED.

% Kenneth C. Arnold (for NASA GSFC), 2004-08-05
