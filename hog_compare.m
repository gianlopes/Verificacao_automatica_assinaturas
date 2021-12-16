function [resultado] = hog_compare(IDpessoa, file)
%% Comparacao de HOG features
% Indica se uma assinatura pertence a pessoa identificada.
% Para isso, calcula a distancia euclidiana das features obtidas pelo
% Histogram of Oriented Gradients (HOG), entre uma assinatura fornecida 
% e as assinaturas armazenadas no banco correspondentes ao codigo de
% identificacao da pessoa dado.
% Caso pelo menos metade das assinaturas estejam dentro de uma threshold
% definida manual e empiricamente, a assinatura sera validada.

% IDpessoa e a identificacao do suposto autor da assinatura.
% file e o nome do arquivo da assinatura para verificacao.


%% Parametros

% Vetor de thresholds para cada uma das 54 assinaturas do banco.
% Os  limiares  a  serem  utilizados  na  comparacao  final  
% foram calculados  baseando-se  na  media das distancias euclidianas
% imagens  originais.  Caso  uma  outra  figura  seja  adicionadaao  
% banco  de  assinaturas,  esta  ter ́a  um  limiar  padrao,  
% pre-defindo, de 6.5.
thresholds = [6.694,6.1214,6.4315,5.5363,7.4651,7.5195,5.8048,8.7941,6.289,6.4895,7.4158,7.1146,6.5907,8.2219,6.3917,5.7819,6.5971,7.0616,6.9205,7.4052,5.7741,6.769,6.9403,7.4069,6.7287,5.4879,8.2103,6.6401,5.1044,5.7307,7.0533,6.3456,6.4356,6.741,6.4153,6.5286,5.4083,5.8355,8.0119,7.0379,7.7222,7.2588,8.0588,6.8288,8.0169,6.0055,7.1869,5.7732,5.5147,7.7065,6.4362,6.9348,6.3139,6.9932,6.3043];

% Numero de features (depende da CellSize da funcao extractHOGFeatures.
% Para as configuracoes escolhidas, e igual a 2916 (padrao).
Nfeatures = 2916;


%% Assinaturas armazenadas

% Numero de assinaturas cadastradas da pessoa.
Npsign = 10;

% Criando matriz com o numero de assinaturas pelas features, para armazenar
% os valores das HOG features.
X = zeros(Npsign, Nfeatures);

for i = 1:Npsign
    % Escreve em uma string o nome do arquivo da assinatura i da pessoa
    % correspondente ao id.
    baseFileName = sprintf('original_%d_%d.png', IDpessoa, i);
    
    % Armazenando as features em uma linha da matriz.
    X(i, :) = hog_features(baseFileName);
end


%% Assinatura fornecida

% Criando um vetor para armazenar os coeficientes HOG.
R = zeros(1, Nfeatures);

% Calculo da transformada.

baseFileName = convertCharsToStrings(file);

R(1, :) = hog_features(baseFileName);


%% Calculo das distancias euclidianas.

% Matriz para armazenar as distancias euclidianas.
Dists = zeros(Npsign, 1);

% Calculando as distancias euclidianas.
for i = 1:Npsign
    V = X(i,:) - R;
    Dists(i,:) = sqrt(V * V');
end


%% Validacao

% Obtendo os indices abaixo do threshold.
if IDpessoa > size(thresholds)
    % Caso mais assinaturas tenham sido adicionadas e o threshold nao tenha
    % sido calculado.
    indices = Dists < 6.5;
else
    indices = Dists < thresholds(IDpessoa);
end

% Pelo menos metade das assinaturas tem que ser compativeis.
if sum(indices) > Npsign/2
    % Assinatura validada.
    resultado = 1;
else
    % Assinatura incompativel.
    resultado = 0;
end

end