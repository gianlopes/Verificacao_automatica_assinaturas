function teste_validacao()
%% Teste da validacao de assinaturas

% Possibilita realizar diversas verificacoes automaticamente, escolhendo
% assinaturas aleatorias do banco de assinaturas e entrega a porcentagem de
% acertos.

% Este teste leva em conta apenas assinaturas diferentes. Quando a
% validacao e feita apenas com conjuntos de assinatura do tipo forgery,
% as porcentagens de acerto caem acentuadamente, chegando a metade das
% obtidas aqui.


%% Input
% Pega a entrada do usuario.
prompt1 = 'Digite quantas pessoas devem ser cadastradas no sistema (1-40):';
prompt2 = 'Digite quantas assinaturas devem ser verificadas aleatoriamente:';
definput = {'40', '100'};
resp = inputdlg({prompt1,prompt2}, 'validacao', [1 35], definput);

% Caso o usuario cancele.
if isempty(resp)
    return
end

msgbox('Aguarde...');

% Numero de pessoas carregadas
Np = str2double(resp{1});

% Numero de assinaturas para testar.
Nsign = str2double(resp{2});


%% Validacao

% O programa escolhe uma assinatura aleatoria e a identificacao de uma
% pessoa para verificar se a assinatura realmente pertence a ela.
% O resultado entregue pelo algoritmo sera avaliado atribuindo um acerto
% ou erro.

erros = 0;
acertos = 0;

for i = 1:Nsign
    
    % Escolhe uma pessoa aleatoria.
    j = randi(Np);
    % Escolhe uma assinatura dessa pessoa.
    k = randi(24); % 24 - numero de assinaturas disponiveis no banco.
    
    % Escolhe a identificacao de uma pessoa para a validacao.
    id = randi(Np);
    
    baseFileName = sprintf('original_%d_%d.png', j, k);
    % Resultado sera a resposta que o programa deu para a validacao.
    resultado = hog_compare(id,baseFileName);
    
    % Esse resultado so vai estar correto caso tenha sido validado (1)
    % quando o autor corresponde ao id fornecido ou quando for
    % incompativel e o autor nao corresponder ao id fornecido.
    if resultado == 1 && id == j || resultado == 0 && id ~= j
        acertos = acertos + 1;
    else
        erros = erros + 1;
    end
end


%% Resultado

TaxaAcerto = acertos / (acertos + erros) * 100;
msg = sprintf('Taxa de acerto da validacao = %.2f%%\n', TaxaAcerto);
uiwait(msgbox(msg, 'replace'));

end