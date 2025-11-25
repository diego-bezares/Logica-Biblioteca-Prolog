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

% Predicado de pertenencia
Usuario?([Id, Nombre, Deuda, Prestamos, Suspendido]):-
  integer(Id),
  string(Nombre),
  number(Deuda),
  is_list(Prestamos),
  (Suspendido = true ; Suspendido = false).
