:- use_module(tda-usuario).
:- use_module(tda-libros).
:- use_module(tda-prestamos).
:- use_module(tda-biblioteca).

% RF02
% Dom -> int id, string nombre, Usuario usuario
crearUsuario(Id, Nombre, U):- initUsuario(Id, Nombre, U).

% RF03
% Dom -> int id, string título, string autor, Libro libro
crearLibro(Id, Titulo, Autor, L):- initLibro(Id, Titulo, Autor, L).

% RF04
% Dom -> int id, int id-usuario, ini id-libro, string fecha-prestamo, int dias-solicitados, Prestamo prestamo
crearPrestamo(Id, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, P):- initPrestamo(Id, IdUsuario, IdLibro, FechaPrestamo, DiasSolicitados, P).

% RF05
% Dom -> (lista libro) libros, (lista usuario) usuarios, (lista prestamo) prestamos, int max-libros-usuario, int dias-max-prestamo, 
% int tasa-multa-diaria, int limite-deuda-max, int dias-max-retraso, string fecha-inicial, Biblioteca biblioteca
 crearBiblioteca(Libros, Usuarios, Prestamos, MaxLibrosUsuario, DiasMaxPrestamo, TasaMultaDiaria, LimiteDeudaMax, DiasMaxRetraso, FechaInicial, B):-
   initBiblioteca(Libros, Usuarios, Prestamos, MaxLibrosUsuario, DiasMaxPrestamo, TasaMultaDiaria, LimiteDeudaMax, DiasMaxRetraso, FechaInicial, B).

% RF06
% Dom -> (Biblioteca) biblioteca, (Libro) libro, (Biblioteca) biblioteca

% Caso 1: YA EXISTE el libro, retorna la misma biblioteca entrante.
agregarLibro(BIn, NuevoLibro, BIn):-
  getIdLibro(NuevoLibro, IdLibro),
  getLibrosBiblioteca(BIn, Libros),
  member([IdLibro, _, _], Libros).

agregarLibro(BIn, NuevoLibro, BOut):-
  getIdLibro(NuevoLibro, IdLibro),
  getLibrosBiblioteca(BIn, Libros),
  not(member([IdLibro, _, _], Libros)),
  

















