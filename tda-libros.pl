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

% Constructores
initLibro(Id, Titulo, Autor, Libro):-
  string_lower(Titulo),
  string_lower(Autor),
  Libro = [Id, Titulo, Autor, true].

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

















