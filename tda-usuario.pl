% --------------------------
% -------TDA Usuarios-------

% ------REPRESENTACIÓN------

% Usuario: id, nombre, deuda,
%         activo y prestamos

%  id -> numero
%  nombre -> string
%  deuda -> numero
%  activo -> booleano 
%  prestamos -> lista

% Constructores
initUsuario(Id, Nombre, [Id, Nombre, 0, [], false]).
