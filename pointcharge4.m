% Limpa tudo:
clear
clc

% Constantes: %%%%%%%%%%%%%%%%%%%%%%%
% Raio fundamental (em m):
R0 = 1;
% Constante do vácuo (N*m^2/C^2) (Não usado por problemas de escala)
% (O programa simula apenas a dependência funcional do inverso
% do quadrado da distância).
% k0 = 9 * 10^9; 
k0 = 1;
% Carga fundamental (em Coulomb):
Q0 = 1;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Variáveis %%%%%%%%%%%%%%%%%%%%%%%%%
% Raio variável inicializado com R0:
R = R0;
% Carga variável inicializada com Q0:
Q = Q0;
% Campo Elétrico (em N/C)
% (Precisa ser reescalado dentro do loop):
% E = k0*Q/R;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Loop para desenhar vários gráficos:
NumFrames = 60;
step = 0.05;
for i = 1:1:NumFrames
    % Escala para o raio R em função do índice i:
    j(i) = (step)*i;
    % Atualiza o raio:
    R = R0*j(i);
    % Atualiza o Campo Elétrico (em N/C):
    E = k0*Q/R^2;
    % Escala o campo para visualizar muito próximo da carga:
    E = E/2;
    % Gráfico %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % VERIFICAR e IMPLEMENTAR: help do "writeVideo"
    % tem exemplo de gerar figura só substituindo a
    % surface no "children" dos current axis
    % ("gca", get current axis).
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Desenha a esfera de raio R:
    [X,Y,Z] = sphere(20);
    X = X.*R;
    Y = Y.*R;
    Z = Z.*R;
    S1=surf(X,Y,Z);
%     % Determina os limites dos eixos:
%     LIM = 3;
%     XMIN = -LIM;
%     XMAX = LIM;
%     YMIN = -LIM;
%     YMAX = LIM;
%     ZMIN = -LIM;
%     ZMAX = LIM;
%     axis([XMIN XMAX YMIN YMAX ZMIN ZMAX])
%     % Mantém a razão de aspecto entre os eixos:
%     axis square;
    % Mantém a superfície (para acrescentar o campo):
%    hold on;
    % Propriedades da superfície:
    S1.EdgeColor = [0.90 0.90 0.90];
    S1.LineWidth = 0.5;
    S1.FaceColor = [0.85 0.85 0.85];
    % S1.FaceAlpha = 0.15;
    % Obtendo as normais à superfície:
    [NX,NY,NZ] = surfnorm(X,Y,Z);
    % Escala os vetores de acordo com o campo:
    NX = NX.*E;
    NY = NY.*E;
    NZ = NZ.*E;
    %Plota os normais escalados pelo campo:
    Field = quiver3(X,Y,Z,NX,NY,NZ);
    % Determina os limites dos eixos:
    LIM = 3;
    XMIN = -LIM;
    XMAX = LIM;
    YMIN = -LIM;
    YMAX = LIM;
    ZMIN = -LIM;
    ZMAX = LIM;
    axis([XMIN XMAX YMIN YMAX ZMIN ZMAX])
    % Mantém a razão de aspecto entre os eixos:
    axis square;
    % Propriedades dos vetores:
    Field.Color = 'black';
    Field.AutoScale = 'off';
    
    % Captura um frame:
    Movie(i) = getframe;

    % "Liberta" as figuras (para não sobrepor à próxima):
    hold off;
    % Espera:
    % Espera = waitforbuttonpress;
end

%Invertendo o vídeo
for k = 1:1:NumFrames
    m = NumFrames +1 - k;
    Movie2(k) = Movie(m);
end
% Preparando arquivo que armazena o vídeo:
video = VideoWriter('pointcharge','MPEG-4');
open(video);
% Grava frame no arquivo de vídeo
writeVideo(video,Movie2);
% Fecha arquivo de vídeo:
close(video);