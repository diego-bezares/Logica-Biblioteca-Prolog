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


% =================================
% ======== Predicado Aux ==========
% =================================

modificar_posicion(Indice, NuevoValor, Lista, ListaModificada):-
  nth0(Indice, Lista, _, Resto),
  nth0(Indice, ListaModificada, NuevoValor, Resto).

% =================================
% =================================


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
setIdPrestamo(NuevoId, Prestamo, PrestamoModificado):-
  modificar_posicion(0, NuevoId, Prestamo, PrestamoModificado).
setIdUsuarioPrestamo(NuevoIdUsuario, Prestamo, PrestamoModificado):-
  modificar_posicion(1, NuevoIdUsuario, Prestamo, PrestamoModificado).
setIdLibroPrestamo(NuevoIdLibro, Prestamo, PrestamoModificado):-
  modificar_posicion(2, NuevoIdLibro, Prestamo, PrestamoModificado).
setFechaPrestamo(NuevaFechaPrestamo, Prestamo, PrestamoModificado):-
  modificar_posicion(3, NuevaFechaPrestamo, Prestamo, PrestamoModificado).
setDiasSolicitadosPrestamo(NuevosDiasSolicitados, Prestamo, PrestamoModificado):-
  modificar_posicion(4, NuevosDiasSolicitados, Prestamo, PrestamoModificado).










