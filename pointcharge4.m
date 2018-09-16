% Limpa tudo:
clear
clc

% Constantes: %%%%%%%%%%%%%%%%%%%%%%%
% Raio fundamental (em m):
R0 = 1;
% Constante do v�cuo (N*m^2/C^2) (N�o usado por problemas de escala)
% (O programa simula apenas a depend�ncia funcional do inverso
% do quadrado da dist�ncia).
% k0 = 9 * 10^9; 
k0 = 1;
% Carga fundamental (em Coulomb):
Q0 = 1;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Vari�veis %%%%%%%%%%%%%%%%%%%%%%%%%
% Raio vari�vel inicializado com R0:
R = R0;
% Carga vari�vel inicializada com Q0:
Q = Q0;
% Campo El�trico (em N/C)
% (Precisa ser reescalado dentro do loop):
% E = k0*Q/R;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Loop para desenhar v�rios gr�ficos:
NumFrames = 60;
step = 0.05;
for i = 1:1:NumFrames
    % Escala para o raio R em fun��o do �ndice i:
    j(i) = (step)*i;
    % Atualiza o raio:
    R = R0*j(i);
    % Atualiza o Campo El�trico (em N/C):
    E = k0*Q/R^2;
    % Escala o campo para visualizar muito pr�ximo da carga:
    E = E/2;
    % Gr�fico %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % VERIFICAR e IMPLEMENTAR: help do "writeVideo"
    % tem exemplo de gerar figura s� substituindo a
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
%     % Mant�m a raz�o de aspecto entre os eixos:
%     axis square;
    % Mant�m a superf�cie (para acrescentar o campo):
%    hold on;
    % Propriedades da superf�cie:
    S1.EdgeColor = [0.90 0.90 0.90];
    S1.LineWidth = 0.5;
    S1.FaceColor = [0.85 0.85 0.85];
    % S1.FaceAlpha = 0.15;
    % Obtendo as normais � superf�cie:
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
    % Mant�m a raz�o de aspecto entre os eixos:
    axis square;
    % Propriedades dos vetores:
    Field.Color = 'black';
    Field.AutoScale = 'off';
    
    % Captura um frame:
    Movie(i) = getframe;

    % "Liberta" as figuras (para n�o sobrepor � pr�xima):
    hold off;
    % Espera:
    % Espera = waitforbuttonpress;
end

%Invertendo o v�deo
for k = 1:1:NumFrames
    m = NumFrames +1 - k;
    Movie2(k) = Movie(m);
end
% Preparando arquivo que armazena o v�deo:
video = VideoWriter('pointcharge','MPEG-4');
open(video);
% Grava frame no arquivo de v�deo
writeVideo(video,Movie2);
% Fecha arquivo de v�deo:
close(video);