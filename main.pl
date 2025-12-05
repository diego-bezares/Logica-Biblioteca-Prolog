:- use_module(tda-usuario).
:- use_module(tda-libros).
:- use_module(tda-prestamos).
:- use_module(tda-biblioteca).


==============================================
============== PREDICADOS AUX ================
==============================================

% Convierte el string "DD/MM" a un entero con los dias totales.
fechaToDias(Fecha, DiasTotales):-
 split_string(Fecha, "/", "", [DiasStr, MesStr]),
 number_string(Dia, DiaStr),
 number:string(Mes, MesStr),
 DiasTotales is ((Mes - 1) * 30) + Dias.

% Convierte un entero con los dias totales a un string "DD/MM".
diasToFecha(DiasTotales, Fecha):-
 Mes is ((DiasTotales - 1) // 30) + 1
 Dias is ((DiasTotales - 1) mod 30) + 1
 format(string(Fecha), "~|~`0t~d~2+/~|~`0t~d~2+", [Dia, Mes]).

% Actualiza un libro de una lista de libros y lo deja en la misma posición.
% Caso Base: Una lista vacía, devuelve la lista vacía.
actualizarLibro([], _, _, []).
% Caso 1: Encuentra el libro y se modifica.
actualizarLibro([LibroActual|Cola], IdBuscado, NuevoEstado, [LibroMod|Cola]):-
 getIdLibro(LibroActual, Id),
 Id == IdBuscado,!,
 setDisponibilidadLibro(LibroActual, NuevoEstado, LibroMod).
% Caso 2: No es el libro, guardamos en su posición y buscamos en la cola.
actualizarLibro([LibroActual|Cola], IdBuscado, NuevoEstado, [LibroActual|ColaMod]):-
 actualizarLibro(Cola, IdBuscado, NuevoEstado, ColaMod).

% Actualiza un usuario de una lista de usuarios y lo deja en la misma posición.
% Caso Base: Una lista vacía, devuelve la lista vacía.
actualizarPrestamosUsuario([], _, _, []).
% Caso 1: Encuentra el usuario y se modifica.
actualizarPrestamosUsuario([UsuarioActual|Cola], IdBuscado, NuevoPrestamo, [UsuarioMod|Cola]):-
 getIdUsuario(UsuarioActual, Id),
 Id == IdBuscado,!,
 getPrestamosUsuario(Usuario, Prestamos),
 append(Prestamos, [NuevoPrestamo], PrestamosMod),
 setPrestamosUsuario(PrestamosMod, Usuario, UsuarioMod).
% Caso 2: No es el usuario, guardamos en su posición y buscamos en la cola.
actualizarPrestamosUsuario([UsuarioActual|Cola], IdBuscado, NuevoPrestamo, [UsuarioActual|ColaMod]):-
 actualizarPrestamosUsuario(Cola, IdBuscado, NuevoPrestamo, ColaMod). 
 
 =============================================
 =============================================
 =============================================
 


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
% Caso 1: YA EXISTE el libro, devuelve la misma biblioteca entrante.
agregarLibro(BIn, NuevoLibro, BIn):-
  getIdLibro(NuevoLibro, IdLibro),
  getLibrosBiblioteca(BIn, Libros),
  member([IdLibro, _, _, _], Libros).

% Caso 2: NO EXISTE el libro, devuelve una nueva lista con el libro agregado al final.
agregarLibro(BIn, NuevoLibro, BOut):-
  getIdLibro(NuevoLibro, IdLibro),
  getLibrosBiblioteca(BIn, Libros),
  not(member([IdLibro, _, _, _], Libros)),
  append(Libros, [NuevoLibro], NuevosLibros),
  setLibrosBiblioteca(NuevosLibros, BIn, BOut).

% RF07
% Dom -> (Biblioteca) biblioteca, (Usuario) usuario, (Biblioteca) biblioteca
% Caso 1: YA EXISTE el usuario, devuelve la lista sin cambios.
registrarUsuario(BIn, NuevoUsuario, BIn):-
 getIdUsuario(NuevoUsuario, IdUsuario),
  getUsuariosBiblioteca(BIn, Usuarios),
  not(member([IdUsuario, _, _, _, _], Usuarios)).

% Caso 2: NO EXISTE el usuario, devuelve una nueva lista con el usuario agregado al final.
 registrarUsuario(BIn, NuevoUsuario, BIn):-
  getIdUsuario(NuevoUsuario, IdUsuario),
  getUsuariosBiblioteca(BIn, Usuarios),
  member([IdUsuario, _, _, _, _], Usuarios),
  append(Usuarios, [NuevoUsuario], NuevosUsuarios),
  setUsuariosBiblioteca(NuevosUsuarios, BIn, BOut).

% RF08
% Dom -> (Biblioteca) biblioteca, int id, (Usuario) usuario o false.
obtenerUsuario(BIn, IdBuscado, UsuarioEncontado):-
 getUsuariosBiblioteca(BIn, ListaUsuarios),
 member(UsuarioEncontrado, ListaUsuarios),
 getIdUsuario(UsuarioEncontrado, IdEncontrado),
 IdEncontado = IdBuscado.

% RF09
% Dom -> (Biblioteca) biblioteca, string criterio, (string/int) valor, (Libro) o false.
% Caso 1: Cuando el criterio es el string "id".
buscarLibro(Biblioteca, "id", IdBuscado, LibroEncontrado):-
 getLibrosBiblioteca(Biblioteca, ListaLibros),
 member(LibroEncontrado, ListaLibros),
 getIdLibro(LibroEncontrado, IdEncontrado),
 IdEncontrado = IdBuscado,!.

% Caso 2: Cuando el criterio es el string "titulo".
buscarLibro(Biblioteca, "titulo", ValorBuscado, LibroEncontrado):-
 getLibrosBiblioteca(Biblioteca, ListaLibros),
 string_lower(ValorBuscado, BuscMin),
 member(LibroEncontrado, ListaLibros),
 getTituloLibro(LibroEncontrado, TituloEncontrado),
 sub_string(TituloEncontrado, _, _, _, BuscMin),!.

% Caso 3: Cuando el criterio es el string "autor".
buscarLibro(Biblioteca, "autor", ValorBuscado, LibroEncontrado):-
 getLibrosBiblioteca(Biblioteca, ListaLibros),
 string_lower(ValorBuscado, BuscMin),
 member(LibroEncontrado, ListaLibros),
 getAutorLibro(LibroEncontrado, AutorEncontrado),
 sub_string(AutorEncontrado, _, _, _, BuscMin),!.

% RF10
% Dom -> (Libro) libro, int id
getLibroId(Libro, IdLibro):- getIdLibro(Libro, IdLibro).

% RF11
% Dom -> (Biblioteca) biblioteca, string fecha
getFecha(Biblioteca, Fecha):- getFechaInicialBiblioteca(Biblioteca, Fecha).

% RF12
% Dom -> (Biblioteca) biblioteca, int id-libro
isLibroDisponible(Biblioteca, IdLibro):-
 buscarLibro(Biblioteca, "id", IdLibro, Libro),
 getDisponibilidadLibro(Libro, Disponibilidad),
 Disponibilidad == true.

% RF13
% Dom -> (Usuario) usuario
isUsuarioSuspendido(Usuario):-
 getSuspendidoUsuario(Usuario, Estado),
 Estado == false.

% RF14
% Dom -> (Usuario) usuario, int deuda
obtenerDeuda(Usuario, Deuda):- getDeudaUsuario(Usuario, Deuda).

% RF15
% Dom -> (Prestamo) prestamo, string fecha
obtenerFechaVencimiento(Prestamo, Fecha):- 
 getFechaPrestamo(Prestamo, FechaPrestamo),
 getDiasSolicitadosPrestamo(Prestamo, DiasSoli),
 fechaToDias(FechaPrestamo, DiasFecha),
 DiasVencimiento is DiasFecha + DiasSoli,
 diasToFecha(DiasVencimiento, Fecha).

% RF16
% Dom -> string fecha-vencimiento, string fecha-actual, int dias-retraso
% Caso 1: La fecha de vencimiento excede la fecha actual.
calcularDiasRetraso(FechaVencimiento, FechaActual, 0):-
 fechaToDias(FechaVencimiento, DiasVencimiento),
 fechaToDias(FechaActual, DiasActual),
 DiasActual =< DiasVencimiento.

% Caso 2: La fecha actual excede la fecha de vencimiento.
calcularDiasRetraso(FechaVencimiento, FechaActual, DiasRetraso):-
 fechaToDias(FechaVencimiento, DiasVencimiento),
 fechaToDias(FechaActual, DiasActual),
 DiasActual > DiasVencimiento,
 DiasRetraso is DiasActual - DiasVencimiento.

% RF17
% Dom -> (Prestamo) prestamo, string fecha-actual, int tasa-multa-diaria, int multa
calcularMulta(Prestamo, FechaActual, TasaMultaDiaria, Multa):-
 obtenerFechaVencimiento(Prestamo, FechaVencimiento),
 calcularDiasRetraso(FechaVencimiento, FechaActual, DiasRetraso),
 Multa is TasaMultaDiaria * DiasRetraso.

% RF18
% Dom -> (Biblioteca) biblioteca, int id-usuario, int id-libro, int dias-solicitados, string fecha-actual, (Biblioteca) biblioteca
tomarPrestamo(BIn, Idusuario, IdLibro, DisSolicitados, FechaActual, BOut):-
 obtenerUsuario(BIn, IdUsuario, Usuario),
 buscarLibro(BIn, "id", IdLibro, Libro),

 getMaxLibrosUsuarioBiblioteca(BIn, MaxLibrosUsuario),
 getDiasMaxPrestamoBiblioteca(BIn, DiasMaxPrestamo),
 getLimiteDeudaBiblioteca(BIn, LimiteDeuda),

 % Condición 1: libro disponible.
 isLibroDisponible(BIn, IdLibro),
 % Condición 2: usuario no suspendido.
 not(isUsuarioSuspendido(Usuario)),
 % Condición 3: no excede límite de libros.
 getPrestamosUsuario(Usuario, PrestamosUsuario),
 length(PrestamosUsuario, CantActual),
 CantActual < MaxLibrosUsuario,
 % Condición 4: días solicitados no exceden el máximo.
 DisSolicitados < DiasMaxPrestamo,
 % Condición 5: deuda no excede el límite.
 getDeudaUsuario(Usuario, DeudaActual),
 DeudaActual < LimiteDeuda,

 getPrestamosBiblioteca(BIn, PrestamosBib),
 length(PrestamosBib, CantActualBib),
 NuevoIdPrestamo is CantActualBib + 1,

 crearPrestamo(NuevoIdPrestamo, IdUsuario, IdLibro, FechaActual, DisSolicitados, NuevoPrestamo),

 % Actualizar Entidades.
 getLibrosBiblioteca(BIn, LibrosBib),
 actualizarLibro(LibrosBib, IdLibro, false, LibrosMod),
 setLibrosBiblioteca(LibrosMod, BIn, BTemp1),

 getUsuariosBiblioteca(BTemp1, UsuariosBibTemp1),
 actualizarPrestamosUsuario(UsuariosBibTemp1, )

 
 




 
 
 
 



























