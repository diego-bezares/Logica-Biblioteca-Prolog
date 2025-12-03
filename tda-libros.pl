% ---------------------------------
% ----------TDA de Libros----------
% ---------------------------------

% ---------REPRESENTACIÓN----------

% Libro: id, titulo, autor y 
%        disponibilidad

%  id -> numero
%  titulo -> string en minúscula
%  autor -> string en minúscula
%  disponibilidad -> booleano

% ---------------------------------
% ---------------------------------


:- module(tda-libros, [
              initLibro/4,
              esLibro/1,
              getIdLibro/2,
              getTitulodLibro/2,
              getAutorLibro/2,
              setIdLibro/3,
              setTituloLibro/3,
              setAutorLibro/3,
              setDisponibilidadLibro/3  
          ]).


% Constructores
initLibro(Id, Titulo, Autor, Libro):-
  string_lower(Titulo, TituloMin),
  string_lower(Autor, AutorMin),
  Libro = [Id, TituloMin, AutorMin, true].

% Predicado de pertenencia
esLibro([Id, Titulo, Autor, Disponibilidad]):-
  integer(Id),
  string(Titulo),
  string(Autor),
  (Disponibilidad = true ; Disponibilidad = false).

% Selectores
getIdLibro([Id, _, _, _], Id).
getTitulodLibro([_, Titulo, _, _], Titulo).
getAutorLibro([_, _, Autor, _], Autor).
getDisponibilidadLibro([_, _, _, Disponibilidad], Disponibilidad).

% Modificadores
setIdLibro(NuevoId, [Id, Titulo, Autor, Disponibilidad], [NuevoId, Titulo, Autor, Disponibilidad]).
setTituloLibro(NuevoTitulo, [Id, Titulo, Autor, Disponibilidad], [Id, NuevoTitulo, Autor, Disponibilidad]).
setAutorLibro(NuevoAutor, [Id, Titulo, Autor, Disponibilidad], [Id, Titulo, NuevoAutor, Disponibilidad]).
setDisponibilidadLibro(L, NuevoEstado, NuevoL):-
  getIdLibro(L, Id),
  getTituloLibro(L, Titulo),
  getAutorLibro(L, Autor),
  NuevoL = [Id, Titulo, Autor, NuevoEstado].

















