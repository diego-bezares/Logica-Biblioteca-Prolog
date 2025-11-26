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
initLibro(Id, Titulo, Autor, [Id, Titulo, Autor, true]).

% Predicado de pertenencia
esLibro([Id, Titulo, Autor, Disponibilidad]):-
  interger(Id),
  








