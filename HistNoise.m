% Created: 2022-09-28
% 2022-12-01
function [HistdiffSpectrum, Edges, noise] = HistNoise (input, level, NBins)
% input - array of frequency (spectrum)
% level - parameter 0 < level < 1: level = max in histogram bin / sum (all bins)
% NBins - count bins in histogram
%
% Diff spectrum 
diffSpectrum = diff(input);
% 
EdgesMed = median( diffSpectrum );
%
EdgeStd = std( diffSpectrum );
% 2022-09-28
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find outliers and zero it
[aa, aa_ind] = find( abs(diffSpectrum) > 3 * EdgeStd );
diffSpectrum(aa) = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%% default
% level = 0.3
%NBins = 20
% NBins = 40
noise = 0
%%%%%%%%%%%%%%%%%%%%% default

%%%%%%%%%%%%%% HIST
% min / max for hist
EdgesMin = min( diffSpectrum );
EdgesMax = max( diffSpectrum );
StepBins = (EdgesMax - EdgesMin) / (NBins);
% array of Edges
Edges = EdgesMin : StepBins : EdgesMax;
%
[ HistdiffSpectrum, idx ] =  histc(diffSpectrum, Edges);
%%%%%%%%%%%%%% HIST
[maxHistdiffSpectrum maxHistdiffSpectrumind] = max(HistdiffSpectrum);
% mid
midEdges = (Edges(maxHistdiffSpectrumind) + Edges(maxHistdiffSpectrumind+1))/2;
% max of left - right
midEdges = max(abs(Edges(maxHistdiffSpectrumind)), abs(Edges(maxHistdiffSpectrumind+1)));
%%%%%%% CHECK 
if maxHistdiffSpectrum / numel(diffSpectrum) > level
  noise = abs(midEdges);
%%%%%%%%%%%%%%  
end
endfunction


