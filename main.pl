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

% Busca un préstamo hasta que coincidan los ids entregados.
buscarPrestamo(Biblioteca, IdUsuario, IdLibro, PrestamoEncontrado):-
  getPrestamosBiblioteca(BIn, ListaPrestamos),
  member(PrestamoEncontrado, ListaPrestamos),
  getIdUsuarioPrestamo(PrestamoEncontrado, U), U == IdUsuario,
  getIdLibroPrestamo(PrestamoEncontrado, L), L == IdLibro.

% Cambia el estado del usuario si es que excedió el límite de deuda.
% Caso 1: Excede el límite, suspende.
determinarNuevoEstado(Deuda, Limite, EstadoActual, true):-
 Deuda > Limite.
% Caso 2: No excede el límite, mantiene su estado actual.
determinarNuevoEstado(Deuda, Limite, EstadoActual, EstadoActual):-
 Deuda =< Limite.

% Actualiza un usuario de la biblioteca.
actualizarUsuario(BIn, IdUsuario, NuevoUsuario, BOut):-
 obtenerUsuario(BIn, IdUsuario, UsuarioViejo),
 getUsuariosBiblioteca(BIn, Usuarios),
 select(UsuarioViejo, Usuarios, RestoUsuarios),
 setUsuariosBiblioteca([NuevoUsuario|RestoUsuarios], BIn, BOut).

% Actualiza un prestamo de la biblioteca.
actualizarPrestamo(BIn, Prestamo, NuevoPrestamo, BOut):-
 getPrestamosBiblioteca(BIn, ListaPrestamos),
 select(Prestamo, ListaPrestamos, RestoPrestamos),
 setPrestamosBiblioteca([NuevoPrestamo|RestoPrestamos], BIn, BOut).

 % Recursivamente va construyendo el string de prestamos.
 % Caso Base: Lista vacía, devuelve string vacío.
 construirStringPrestamos([], "").

 % Caso Recursivo: Formatea la cabeza, procesa la cola y une todo (PARA HISTORIAL USUARIO).
 construirStringPrestamos([Prestamo|Resto], "u", StrFinal):-
  formatearPrestamo(Prestamo, "u", StrP),
  construirStringPrestamos(Resto, StrResto),
  string_concat(StrP, StrResto, StrFinal).

 % Caso Recursivo: Formatea la cabeza, procesa la cola y une todo (PARA HISTORIAL BIBLIOTECA).
 construirStringPrestamos([Prestamo|Resto], "b", StrFinal):-
  formatearPrestamo(Prestamo, "b", StrP),
  construirStringPrestamos(Resto, StrResto),
  string_concat(StrP, StrResto, StrFinal).

 % Formatea un prestamo en su fecha de vencimiento, fecha de inicio y libro prestado (PARA HISTORIAL USUARIO).
 formatearPrestamo(Prestamo, "u", Str):-
  getIdPrestamo(Prestamo, IdP),
  getIdLibroPrestamo(Prestamo, IdL),
  getFechaPrestamo(Prestamo, FechaInicio),
  obtenerFechaVencimiento(Prestamo, FechaVenc),
  format(string(Str), "Prestamo #~w - Libro ~w - Prestado: ~w - Vence: ~w~n", [IdP, IdL, FechaInicio, FechaVenc]).

% Lo mismo, pero con el id del usuario y días solicitados (PARA HISTORIAL BIBLIOTECA).
  formatearPrestamo(Prestamo, "b", Str):-
  getIdPrestamo(Prestamo, IdP),
  getIdaUsuarioPrestamo(Prestamo, IdU)
  getIdLibroPrestamo(Prestamo, IdL),
  getFechaPrestamo(Prestamo, FechaInicio),
  getDiasSolicitadosPrestamo(Prestamo, DiasSoli)
  obtenerFechaVencimiento(Prestamo, FechaVenc),
  format(string(Str), "Prestamo #~w - Usuario ~w - Libro ~w - Fecha: ~w - Dias: ~w~n", [IdP, IdU, IdL, FechaInicio, DiasSoli]).
 
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
 Estado == true.

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
 actualizarPrestamosUsuario(UsuariosBibTemp1, IdUsuario, NuevoPrestamo, UsuariosMod),
 setUsuariosBiblioteca(UsuariosMod, BTemp1, BTemp2),

 getPrestamosBiblioteca(BTemp2, PrestamosBibTemp2),
 append(PrestamosBibTemp2, [NuevoPretamo], PrestamosMod),
 setPrestamosBiblioteca(PrestamosMod, BTemp2, BOut).

% RF19
% Dom -> biblioteca (Biblioteca), id-usuario (int), id-libro (int), fecha-actual (string), biblioteca (Biblioteca)
devolverLibro(BIn, IdUsuario, IdLibro, FechaActual, BOut):-
 getTasaMultaDiariaBiblioteca(BIn, TasaMultaDiaria),
 getLimiteDeudaBiblioteca(BIn, LimiteDeuda),
 buscarPrestamo(BIn, IdUsuario, IdLibro, Prestamo),
 
 calcularMulta(Prestamo, FechaActual, TasaMultaDiaria, Multa),
 obtenerUsuario(BIn, IdUsuario, Usuario),
 getDeudaUsuario(Usuario, DeudaActual),
 NuevaDeuda is DeudaActual + Multa,

 getSuspendidoUsuario(Usuario, EstadoActual),
 determinarNuevoEstado(DeudaActual, LimiteDeuda, EstadoActual, NuevoEstado),
 setSuspendidoUsuario(Usuario, NuevoEstado, UsuarioMod),
 setDeudaUsuario(NuevaDeuda, UsuarioMod, UsuarioMod2)
 actualizarUsuario(BIn, IdUsuario, UsuarioMod2, BTemp),

 getLibrosBiblioteca(BTemp1, ListaLibros),
 actualizarLibro(ListaLibros, IdLibro, true, LibrosMod),
 setLibrosBiblioteca(LibrosMod, BTemp, BOut).

% RF20
% Dom -> biblioteca (Biblioteca), id-usuario (int), fecha-actual (string)
% Criterio 1: Excede el limite de deuda?
debeSuspenderse(BIn, IdUsuario, _),
 obtenerUsuario(BIn, IdUsuario, Usuario),
 getLimiteDeudaBiblioteca(BIn, LimiteDeuda),
 getDeudaUsuario(Usuario, Deuda),
 Deuda > LimiteDeuda.

% Criterio 2: Alguno de sus prestamos excede el limite de retraso?
debeSuspenderse(BIn, IdUsuario, FechaActual):-
 obtenerUsuario(BIn, IdUsuario, Usuario),
 getDiasMaxRetrasoBiblioteca(BIn, MaxRetraso),
 getPrestamosUsuario(Usuario, ListaPrestamos),

 member(Prestamo, ListaPrestamos),
 obtenerFechaVencimiento(Prestamo, FechaVencimiento),
 calcularDiasRetraso(FechaVencimiento, FechaActual, DiasRetraso),
 DiasRetraso > MaxRetraso.

% RF21
% Dom -> biblioteca (Biblioteca), idUsuario (int), biblioteca (Biblioteca)
suspenderUsuario(BIn, IdUsuario, BOut):-
 obtenerUsuario(Bin, IdUsuario, Usuario),
 setSuspendidoUsuario(Usuario, true, UsuarioMod)
 getUsuariosBiblioteca(BIn, ListaUsuarios),
 actualizarUsuario(ListaUsuarios, IdUsuario, UsuarioMod, ListaUsuariosMod),
 setUsuariosBiblioteca(ListaUsuariosMod, BIn, BOut).

% RF22
% Dom -> biblioteca (Biblioteca), id-prestamo (int), dias-extra (int), fecha-actual (string), biblioteca (Biblioteca)
renovarPrestamo(BIn, IdPrestamo, DiasExtra, FechaActual, BOut):-
 getPrestamosBiblioteca(BIn, ListaPrestamos),
 member(PrestamoEncontrado, ListaPrestamos), getIdPrestamo(PrestamoEncontrado, Id), Id == IdPrestamo,!,
 
 % Condición 1: Préstamo existente y activo.
 getIdLibroPrestamo(PrestamoEncontrado, IdLibro),
 not(isLibroDisponible(BIn, IdLibro)),
 % Condición 2: Usuario no suspendido.
 getIdUsuarioPrestamo(PrestamoEncontrado, IdUsuario),
 obtenerUsuario(BIn, IdUsuario, Usuario),
 not(isUsuarioSuspendido(Usuario)),
 % Condición 3: No hay retraso.
 obtenerFechaVencimiento(PrestamoEncontrado, FechaVencimiento),
 calcularDiasRetraso(FechaVencimiento, FechaActual, DiasRetraso),
 DiasRetraso == 0,
 % Condición 4: Días totales no exceden el máximo.
 getDiasMaxPrestamoBiblioteca(BIn, DiasMax),
 getDiasSolicitadosPrestamo(PrestamoEncontrado, DiasSoli),
 DiasMax >= DiasSoli + DiasExtra,
 NuevosDias is DiasSoli + DiasExtra,

 setDiasSolicitadosPrestamo(NuevosDias, PrestamoEncontrado, PrestamoMod),
 actualizarPrestamo(BIn, PrestamoEncontrado, PrestamoMod, BOut).

% RF23
% Dom -> biblioteca (Biblioteca), id-usuario (int), monto (int), biblioteca (Biblioteca)
% Caso 1: El usuario paga toda su deuda, se reactiva.
pagarDeuda(BIn, IdUsuario, Monto, BOut):-
 obtenerUsuario(BIn, IdUsuario, Usuario),
 getDeudaUsuario(Usuario, Deuda),
 NuevaDeuda is Deuda - Monto,
 NuevaDeuda == 0,
 setDeudaUsuario(NuevaDeuda, Usuario, UsuarioMod),
 setSuspendidoUsuario(Usuario, false, UsuarioMod2),
 actualizarUsuario(BIn, IdUsuario, UsuarioMod2, BOut).

% Caso 2: El usuario paga parte de la deuda, solo actualiza su deuda actual.
pagarDeuda(BIn, IdUsuario, Monto, BOut):-
 obtenerUsuario(BIn, IdUsuario, Usuario),
 getDeudaUsuario(Usuario, Deuda),
 NuevaDeuda is Deuda - Monto,
 setDeudaUsuario(NuevaDeuda, Usuario, UsuarioMod),
 actualizarUsuario(BIn, IdUsuario, UsuarioMod, BOut).

% RF24
% Dom -> biblioteca (Biblioteca), IdUsuario (int), str (String)
% Caso 1: El usuario no existe.
historialPrestamosUsuario(BIn, IdUsuario, ""):-
 not(obtenerUsuario(BIn, IdUsuario, _)).

% Caso 2: El usuario si existe.
historialPrestamosUsuario(BIn, IdUsuario, Str):-
 obtenerUsuario(BIn, IdUsuario, Usuario),
 getPrestamosUsuario(Usuario, ListaPrestamos),
 construirStringPrestamos(ListaPrestamos, "u", CuerpoString),
 format(string(Cabeza), "Historial Usuario ~d:~n", [IdUsuario]),
 string_concat(Cabeza, CuerpoString, Str).

% RF25
% Dom -> biblioteca (Biblioteca), str (String)
historialPrestamosSistema(Biblioteca, Str):-
 getPrestamosBiblioteca(Biblioteca, ListaPrestamos)
 construirStringPrestamos(ListaPrestamos, "b", Str).

% RF26
% Dom -> biblioteca (Biblioteca), biblioteca (Biblioteca)
procesarDia(BIn, BOut):-
  


 
 


 
 




 
 
 
 



























