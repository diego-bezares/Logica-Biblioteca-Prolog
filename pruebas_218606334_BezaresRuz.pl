:- consult('main.pl').

test :-
    % Configuración de visualización
    set_prolog_flag(answer_write_options, [max_depth(0)]),

    write('=== INICIO SCRIPT DE PRUEBA ==='), nl, nl,

    write('1. Creando usuarios y libros...'), nl,
    crearUsuario(1, "Jose", U1),
    crearUsuario(2, "Carlos", U2),
    
    crearLibro(101, "El Hobbit", "J.R.R. Tolkien", L1),
    crearLibro(102, "1984", "George Orwell", L2),
    crearLibro(103, "La vuelta a Chile en Bicicleta", "Régine Bienvenue", L3),
    
    FechaInicio = "01/01",
    write('2. Inicializando Biblioteca con fecha '), write(FechaInicio), nl,
    write('3. Agregando libros y usuarios al sistema...'), nl,
    
    agregarLibro(B1, L1, B2),   
    agregarLibro(B2, L2, B3),   
    registrarUsuario(B3, U1, B4), 
    registrarUsuario(B4, U2, B5),

    write('Sistema configurado: 2 libros, 2 usuarios'), nl,
    write('Configuración: máx 3 dias préstamo, multa 100/dia, suspensión tras 1 dia retraso'), nl, nl,
    
    % === DÍA 01/01 ===
    getFecha(B5, F_Actual_1),
    write('=== DIA '), write(F_Actual_1), write(' ==='), nl,
    write('Jose toma prestado "El Hobbit" por 3 dias'), nl,
    
    tomarPrestamo(B5, 1, 101, 3, F_Actual_1, B6),
    write('Préstamo realizado exitosamente (Debe devolver el 04/01)'), nl, nl,

    % === AVANZAR DÍA 1 (pasa al 02/01) ===
    write('=== PROCESAR DIA ==='), nl,
    procesarDia(B6, B7),
    getFecha(B7, F_Actual_2),
    write('Fecha actual: '), write(F_Actual_2), nl, nl,

    % === AVANZAR DÍA 2 (pasa al 03/01) ===
    write('=== PROCESAR DIA ==='), nl,
    procesarDia(B7, B8),
    getFecha(B8, F_Actual_3),
    write('Fecha actual: '), write(F_Actual_3), nl, nl,

    write('Carlos intenta tomar "El Hobbit" que tiene Jose...'), nl,
    ( \+ tomarPrestamo(B8, 2, 101, 2, F_Actual_3, _) -> 
        write('EXITO: No pudo tomarlo (Libro ocupado)') 
    ; 
        write('ERROR: Carlos pudo tomar un libro ocupado') 
    ), nl, nl,

    % === AVANZAR DÍA 3 (pasa al 04/01 - Vencimiento) ===
    write('=== PROCESAR DIA ==='), nl,
    procesarDia(B8, B9),
    getFecha(B9, F_Actual_4),
    write('Fecha actual: '), write(F_Actual_4), nl,
    write('INFO: Hoy vence el prestamo de Jose'), nl, nl,

    % === AVANZAR DÍA 4 (pasa al 05/01 - 1 día retraso) ===
    write('=== PROCESAR DIA ==='), nl,
    procesarDia(B9, B10),
    getFecha(B10, F_Actual_5),
    write('Fecha actual: '), write(F_Actual_5), nl,
    write('INFO: Jose tiene 1 dia de retraso. Multa esperada: 100'), nl, nl,

    % === AVANZAR DÍA 5 (pasa al 06/01 - 2 días retraso) ===
    write('=== PROCESAR DIA ==='), nl,
    procesarDia(B10, B11),
    getFecha(B11, F_Actual_6),
    write('Fecha actual: '), write(F_Actual_6), nl,
    write('INFO: Jose tiene 2 dias de retraso. Multa acumulada esperada: 200'), nl, nl,

    write('=== JOSE DEVUELVE EL LIBRO ==='), nl,
    devolverLibro(B11, 1, 101, F_Actual_6, B12),
    write('Libro devuelto.'), nl,

    obtenerUsuario(B12, 1, JoseDeudor),
    obtenerDeuda(JoseDeudor, DeudaJose),
    isUsuarioSuspendido(JoseDeudor),
    write('Deuda de Jose: '), write(DeudaJose), nl,
    write('¿Suspendido? TRUE (Excedio dias de retraso permitido)'), nl, nl,

    write('=== INTENTO DE PAGO PARCIAL ==='), nl,
    write('Jose paga 50...'), nl,
    pagarDeuda(B12, 1, 50, B13),
    
    obtenerUsuario(B13, 1, JoseParcial),
    obtenerDeuda(JoseParcial, DeudaRestante),
    write('Deuda restante: '), write(DeudaRestante), nl,
    
    write('¿Sigue suspendido? '), 
    ( isUsuarioSuspendido(JoseParcial) -> write('SI') ; write('NO') ),
    write(' (Correcto, debe pagar todo para reactivarse)'), nl, nl,

    write('=== JOSE SUSPENDIDO INTENTA TOMAR LIBRO ==='), nl,
    write('Jose intenta tomar "1984"...'), nl,
    ( \+ tomarPrestamo(B13, 1, 102, 2, F_Actual_6, _) ->
        write('EXITO: No puede tomarlo, esta suspendido.')
    ;
        write('ERROR: Jose suspendido pudo tomar un libro.')
    ), nl, nl,

    write('=== CARLOS TOMA EL LIBRO DEVUELTO ==='), nl,
    write('Carlos toma "El Hobbit" (ahora disponible)...'), nl,
    tomarPrestamo(B13, 2, 101, 3, F_Actual_6, B14),
    write('Prestamo exitoso para Carlos.'), nl, nl,

    write('=== JOSE PAGA TODA SU DEUDA ==='), nl,
    write('Jose paga los 150 restantes...'), nl,
    pagarDeuda(B14, 1, 150, B15),

    obtenerUsuario(B15, 1, JoseLibre),
    obtenerDeuda(JoseLibre, DeudaFinal),
    write('Deuda Final: '), write(DeudaFinal), nl,
    
    write('¿Suspendido? '),
    ( \+ isUsuarioSuspendido(JoseLibre) -> write('NO') ; write('SI (Error)') ),
    write(' (Jose activo nuevamente)'), nl, nl,

    write('=== JOSE REACTIVADO TOMA LIBRO ==='), nl,
    write('Jose toma "1984"...'), nl,
    tomarPrestamo(B15, 1, 102, 3, F_Actual_6, _BFinal),
    write('Prestamo exitoso.'), nl, nl,

    write('===== FIN DEL SCRIPT ====='), nl.

































