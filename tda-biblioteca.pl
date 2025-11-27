%---------------------------------
%-------TDA de Bibliotecas--------
%---------------------------------

%---------REPRESENTACIÓN----------

% Biblioteca: libros, usuarios, prestamos, 
%           max-libros-usuario, dias-max-prestamo,
%           tasa-multa-diaria, limite-deuda,
%           dias-max-retraso y fecha-inicial

%  libros -> lista libro
%  usuarios -> lista usuario
%  prestamos -> lista prestamo
%  max-libros-usuario -> numero
%  dias-max-prestamo -> numero
%  tasa-multa-diaria -> numero
%  limite-deuda -> numero
%  dias-max-retraso -> numero
%  fecha-inicial -> string

%---------------------------------
%---------------------------------


% =================================
% ======== Predicado Aux ==========
% =================================

modificar_posicion(Indice, NuevoValor, Lista, ListaModificada):-
  nth0(Indice, Lista, _, Resto),
  nth0(Indice, ListaModificada, NuevoValor, Resto).

% =================================
% =================================


% Constructores
initBiblioteca(Libros, Usuarios, Prestamos, MaxLibrosUsuario, DiasMaxPrestamo, TasaMultaDiaria, LimiteDeuda, DiasMaxRetraso, FechaInicial, B):-
  B = [Libros, Usuarios, Prestamos, MaxLibrosUsuario, DiasMaxPrestamo, TasaMultaDiaria, LimiteDeuda, DiasMaxRetraso, FechaInicial].

% Predicado de pertenencia
esBiblioteca([Libros, Usuarios, Prestamos, MaxLibrosUsuario, DiasMaxPrestamo, TasaMultaDiaria, LimiteDeuda, DiasMaxRetraso, FechaInicial]):-
  is_list(Libros),
  is_list(Usuarios),
  is_list(Prestamos),
  integer(MaxLibrosUsuario),
  integer(DiasMaxPrestamo),
  integer(TasaMultaDiaria),
  integer(LimiteDeuda),
  integer(DiasMaxRetraso),
  string(FechaInicial).

% Selectores
getLibrosBiblioteca([Libros, _, _, _, _, _, _, _, _], Libros).
getUsuariosBiblioteca([_, Usuarios, _, _, _, _, _, _, _], Usuarios).
getPrestamosBiblioteca([_, _, Prestamos, _, _, _, _, _, _], Prestamos).
getMaxLibrosUsuarioBiblioteca([_, _, _, MaxLibrosUsuario, _, _, _, _, _], MaxLibrosUsuario).
getDiasMaxPrestamoBiblioteca([_, _, _, _, DiasMaxPrestamo, _, _, _, _], DiasMaxPrestamo).
getTasaMultaDiariaBiblioteca([_, _, _, _, _, TasaMultaDiaria, _, _, _], TasaMultaDiaria).
getLimiteDeudaBiblioteca([_, _, _, _, _, _, LimiteDeuda, _, _], LimiteDeuda).
getDiasMaxRetrasoBiblioteca([_, _, _, _, _, _, _, DiasMaxRetraso, _], DiasMaxRetraso).
getFechaInicialBiblioteca([_, _, _, _, _, _, _, _, FechaInicial], FechaInicial).

% Modificadores
setLibrosBiblioteca(NuevosLibros, Biblioteca, BibliotecaMod):-
  modificar_posicion(0, NUevosLibros, Biblioteca, BibliotecaMod).
setUsuariosBiblioteca(NuevosUsuarios, Biblioteca, BibliotecaMod):-
  modificar_posicion(1, NUevosUsuarios, Biblioteca, BibliotecaMod).
setPrestamosBiblioteca(NuevosPrestamos, Biblioteca, BibliotecaMod):-
  modificar_posicion(2, NuevosPrestamos, Biblioteca, BibliotecaMod).
setMaxLibrosUsuarioBiblioteca(NuevoMaxLibrosUsuario, Biblioteca, BibliotecaMod):-
  modificar_posicion(3, NuevoMaxLibrosUsuario, Biblioteca, BibliotecaMod).
setDiasMaxPrestamoBiblioteca(NuevosDiasMaxPrestamo, Biblioteca, BibliotecaMod):-
  modificar_posicion(4, NuevosDiasMaxPrestamo, Biblioteca, BibliotecaMod).
setTasaMultaDiariaBiblioteca(NuevaTasaMultaDiaria, Biblioteca, BibliotecaMod):-
  modificar_posicion(5, NuevaTasaMultaDiaria, Biblioteca, BibliotecaMod).
setLimiteDeudaBiblioteca(NuevoLimiteDeuda, Biblioteca, BibliotecaMod):-
  modificar_posicion(6, NuevoLimiteDeuda, Biblioteca, BibliotecaMod).
setDiasMaxRetrasoBiblioteca(NuevosDiasMaxRetraso, Biblioteca, BibliotecaMod):-
  modificar_posicion(7, NuevosDiasMaxRetraso, Biblioteca, BibliotecaMod).
setFechaInicialBiblioteca(NuevaFechaInicial, Biblioteca, BibliotecaMod):-
  modificar_posicion(8, NuevaFechaInicial, Biblioteca, BibliotecaMod).

  




























