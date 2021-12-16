%% Trabalho final de IPI
% Gianlucas dos Santos Lopes - 180041991
% Gustavo Antonio Souza de Barros - 180064487
% Mayara Chew Marinho - 180025210

% Programa testado no Matlab R2018b.
% Toolbox usadas (necessarias):
% Image Processing Toolbox - v10.3
% Computer Vision System Toolbox - v8.2
% Statistics and Machine Learning Toolbox - v11.4

%% Como usar
% Toolbox acima listadas sao necessarias.
% Necessario o arquivo main e das oito funcoes no mesmo diretorio para
% funcionar.
% As assinaturas devem estar na pasta 'signatures' e seus nomes nao podem
% ser alterados do padrao (original_%d_%d.png), uma vez que o programa 
% depende dos ids escritos neles para funcionar corretamente.
% Aperte o botao run apos selecionar o arquivo main.m


%% Sistema de assinaturas escritas a mao - tema 4
% Este arquivo contem apenas o codigo para a interface do sistema. As
% tarefas foram divididas em outros modulos para facilitar a leitura.

% Mensagem introdutoria.
msg = sprintf(['O sistema possui duas funcoes principais:\n\n'...
    'Identificacao: Uma assinatura sera comparada com as outras'...
    ' armazenadas no sistema. O programa vai retornar a identificacao'...
    ' da pessoa cadastrada com maior possibilidade de ser a autora.\n\n'...
    'Validacao: Uma assinatura sera fornecida junto com a'...
    ' identificacao de uma pessoa. O programa vai comparar essa'...
    ' assinatura com as outras cadastradas para a pessoa e entao vai'...
    ' retornar se a assinatura foi considerada valida ou incompativel.'...
    '\n\nOs modos de teste sao feitos para testar as funcoes diversas'...
    ' vezes e obter porcentagens de acerto.']);
h = (msgbox(msg,'Sistema de Assinaturas'));
object_handles = findall(h);
set(h, 'position', [450 350 430 250]);
set(object_handles(3:4), 'FontSize', 12)
set(h,'Resize','on')
uiwait(h);

% Opcoes disponiveis.
while 1
    [indx, tf] = listdlg('ListString', {'identificacao', 'teste_identificacao',...
        'validacao', 'teste_validacao'}, 'SelectionMode', 'Single',...
        'CancelString','Sair','ListSize',[280 100],...
        'PromptString','Escolha um modo:','Name','Sistema de assinaturas');

    if tf == 0
        break
    end
    switch indx
        case 1
            identificacao();
        case 2
            teste_identificacao()
        case 3
            validacao()
        case 4
            teste_validacao()
    end
end
