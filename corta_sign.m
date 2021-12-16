function [Icrop] = corta_sign(Ibin)
% Corta a imagem e deixa somente a area que contem a assinatura.
% Util caso a pessoa tenha desenhado a assinatura um pouco deslocada.

% Usa bwareaopen pra remover noise.
% Deve-se utilizar o negativo da imagem.
Ibinclean = bwareaopen(~Ibin, 6);
Ibinclean = ~Ibinclean;

% Projeções horizontal e vertical.
% Soma de todos os valores brancos na coordenada x, formando uma coluna.
YProj = sum(Ibinclean, 1);

% Soma de todos os valores brancos na coordenada y, formando uma linha.
XProj = sum(Ibinclean, 2);

% Usando as projecoes para encontrar as coordenadas.

% Pontos (xi, yi) que simbolizam o inicio da assinatura.
xi = find(XProj ~= size(Ibinclean, 2), 1);
xf = find(XProj ~= size(Ibinclean,2), 1,'last');

% Pontos (xf, yf) que simbolizam o final da assinatura.
yi = find(YProj ~= size(Ibinclean,1), 1);
yf = find(YProj ~= size(Ibinclean,1), 1,'last');

% Cortando a imagem
Icrop = Ibin(xi-1 + 1:xf, yi-1 + 1:yf);

end

