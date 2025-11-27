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
getIdUsuarioPrestamo([_, IdUsuario, _, _, _], IdUsuario).
getIdLibroPrestamo([_, _, IdLibro, _, _], IdLibro).
getFechaPrestamo([_, _, _, FechaPrestamo, _], FechaPrestamo).
getDiasSolicitadosPrestamo([_, _, _, _, DiasSolicitados], DiasSolicitados).

% Modificadores
setIdPrestamo(NuevoId, [Id, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados], [NuevoId, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados]).
setIdUsuarioPrestamo(NuevoIdUsuario, [Id, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados], [Id, NuevoIdUsuario, IdLibro, FechaPrestamo, DiasSolicitados]).
setIdLibroPrestamo(NuevoIdLibro, [Id, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados], [Id, IdUsuario, NuevoIdLibro, FechaPrestamo, DiasSolicitados]).
setFechaPrestamo(NuevaFechaPrestamo, [Id, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados], [Id, IdUsuario, IdLibro, NuevaFechaPrestamo, DiasSolicitados]).
setDiasSolicitadosPrestamo(NuevosDiasSolicitados, [Id, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados], [Id, IdUsuario, IdLibro, FechaPrestamo, NuevosDiasSolicitados]).










