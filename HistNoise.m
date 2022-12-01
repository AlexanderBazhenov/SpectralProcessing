% Created: 2022-09-28
% Calculation noise of histogram
% 2022-10-13 NBins
function [HistdiffSpectrum, Edges, noise] = HistNoise (input1, level, NBins)
% input1 = H2Ospectrum;
% input1 = mu_array;
diffSpectrum = diff(input1);
EdgesMed = median( diffSpectrum );
EdgeStd = std( diffSpectrum );
% 2022-09-28
[aa, aa_ind] = find( abs(diffSpectrum) > 3 * EdgeStd );
diffSpectrum(aa) = 0;
%
EdgesMin = min( diffSpectrum );
EdgesMax = max( diffSpectrum );
% default
% level = 0.3
%NBins = 20
% NBins = 40
noise = 0
%
StepBins = (EdgesMax - EdgesMin) / (NBins);
Edges = EdgesMin : StepBins : EdgesMax;
[ HistdiffSpectrum, idx ] =  histc(diffSpectrum, Edges);
%
[maxHistdiffSpectrum maxHistdiffSpectrumind] = max(HistdiffSpectrum);
%
% figure, bar(Edges, HistdiffSpectrum)
%
midEdges = (Edges(maxHistdiffSpectrumind) + Edges(maxHistdiffSpectrumind+1))/2;
midEdges = max(abs(Edges(maxHistdiffSpectrumind)), abs(Edges(maxHistdiffSpectrumind+1)));
%
if maxHistdiffSpectrum / numel(diffSpectrum) > level
  noise = abs(midEdges);
end
endfunction

##figure
##hold on
##plot(diffSpectrum)
##plot(aa, diffSpectrum(aa), '.r')
##
##diffSpectrum(aa) = 0;
##figure
##hold on
##plot(diffSpectrum)
