% ---------------------------------
% ---------TDA de Préstamos--------
% ---------------------------------

% ---------REPRESENTACIÓN----------

% Préstamos: id, id-usuario, 
%     id-libro, fecha-préstamo y
%     días-solicitados

%  id -> numero
%  id-usuario -> numero
%  id-libro -> numero
%  fecha-préstamo -> string
%  días-solicitados -> numero

% ---------------------------------
% ---------------------------------

% Constructores
initPrestamo(Id, IdUsuario, IdLibro, FechaPrstamo, DiasSolicitados, [Id, IdUsuario, IdLibro, FechaPrstamo, DiasSolicitados]).

% Predicado de pertenencia
esPrestamo([Id, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados]):-
  integer(Id),
  integer(IdUsuario),
  integer(IdLibro),
  string(FechaPrestamo),
  integer(DiasSolicitados).

% Selectores
getIdPrestamo([Id, _, _, _, _], Id).












