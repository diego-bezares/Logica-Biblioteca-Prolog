% --------------------------
% -------TDA Usuarios-------

% ------REPRESENTACIÓN------

% Usuario: id, nombre, deuda,
%          prestamos y suspendido

%  id -> numero
%  nombre -> string
%  deuda -> numero
%  prestamos -> lista 
%  suspendido -> booleano

:- module(tda-usuario, [
              initUsuario/3,
              esUsuario/1,
              getIdUsuario/2,
              getNombreUsuario/2,
              getDeudaUsuario/2,
              getPrestamosUsuario/2,
              getSuspendidoUsuario/2,
              setIdUsuario/3,
              setNombreUsuario/3,
              setDeudaUsuario/3,
              setSuspendidoUsuario/3  
          ]).

% Constructores
initUsuario(Id, Nombre, [Id, Nombre, 0, [], false]).

% Predicado de pertenencia
esUsuario([Id, Nombre, Deuda, Prestamos, Suspendido]):-
  integer(Id),
  string(Nombre),
  number(Deuda),
  is_list(Prestamos),
  (Suspendido = true ; Suspendido = false).

% Selectores
getIdUsuario([Id, _, _, _, _], Id).
getNombreUsuario([_, Nombre, _, _, _], Nombre).
getDeudaUsuario([_, _, Deuda, _, _], Deuda).
getPrestamosUsuario([_, _, _, Prestamos, _], Prestamos).
getSuspendidoUsuario([_, _, _, _, Suspendido], Suspendido).

% Modificadores
setIdUsuario(NuevoId, [Id, Nombre, Deuda, Prestamos, Suspendido], [NuevoId, Nombre, Deuda, Prestamos, Suspendido]).
setNombreUsuario(NuevoNombre, [Id, Nombre, Deuda, Prestamos, Suspendido], [Id, NuevoNombre, Deuda, Prestamos, Suspendido]).
setDeudaUsuario(NuevaDeuda, [Id, Nombre, Deuda, Prestamos, Suspendido], [Id, Nombre, NuevaDeuda, Prestamos, Suspendido]).
setSuspendidoUsuario(U, NuevoEstado, NuevoU):-
  getIdUsuario(U, Id),
  getNombreUsuario(U, Nombre),
  getDeudaUsuario(U, Deuda),
  getPrestamosUsuario(U, Prestamos),
  NuevoU = [Id, Nombre, Deuda, Prestamos, NuevoEstado].
  





