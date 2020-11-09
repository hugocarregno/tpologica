/* Realizado por Carreño Hugo
Segundo Trabajo Práctico Obligatorio

TRABAJADORES
Se cuenta con la siguiente base de conocimiento.
%% tarea(descripcion, complejidad).
%% trabajo(trabajador, tarea).
%% poder(trabajador, poder).
%% partido(trabajador, partido).
Donde, los poderes son: judicial, legislativo, ejecutivo y prensa. El
resto de los individuos los puede definir según su preferencia.


*/

/* 1. Defina al menos 5 hechos para: tarea, trabajo, poder y partido. Use
estos hechos para testear los predicados pedidos en los puntos siguientes.*/

trabajador(luis).
trabajador(brisa).
trabajador(marcos).
trabajador(raul).
trabajador(rocio).
trabajador(clara).

tarea(reportes, 3).
tarea(entrevistas, 4).
tarea(planificar, 6).
tarea(relevamiento, 7).
tarea(mantenimiento, 8).
tarea(edicion, 5).

trabajo(luis, reportes).
trabajo(rocio, entrevistas).
trabajo(brisa, planificar).
trabajo(marcos, relevamiento).
trabajo(raul, mantenimiento).
trabajo(clara, edicion).
trabajo(clara, entrevistas).

poder(luis, judicial).
poder(rocio, prensa).
poder(brisa, ejecutivo).
poder(marcos, legislativo).
poder(raul, legislativo).
poder(clara, prensa).

partido(luis, justicialista).
partido(rocio, frenteparatodos).
partido(brisa, mujeres).
partido(marcos, cambiemos).
partido(raul, radical).
partido(clara, mujeres).

/* 2.Conocer todas las tareas estresantes. Se considera una tarea estresante
si su complejidad mayor a 5. */

tareaEstresante(T):- tarea(T, N), N>5.

/* 3. Se quiere conocer a todas las personas que están estresadas. Se considera a una persona estresada si realiza al menos una tarea estresante o si pertenece al
poder ejecutivo. */

personaEstresada(X):- trabajo(X,T), tareaEstresante(T).
personaEstresada(X):- poder(X,Y),Y == ejecutivo.

/* 4. Se quiere conocer si un trabajador se encuentra en
peligro, teniendo en cuenta que todas las personas estresadas que no
pertenecen al poder legislativo se encuentran en peligro como así
también todas las que trabajan en la prensa.
*/

personaEnPeligro(X):- poder(X,Y),personaEstresada(X), Y \= legislativo.
personaEnPeligro(X):- poder(X,Y), Y == prensa.

/* 5. Los trabajadores tienen enemigos natos. Estos están dados por
los poderes en los que trabaja cada uno. Desarrollar una solución
teniendo en cuenta que :
  a. Los trabajadores del poder judicial son enemigos de los del poder
  ejecutivo.
  b. Los trabajadores del poder legislativo
    i. son enemigos de los del poder judicial.
    ii. son enemigos de los legisladores de otros partidos.
  c. Los trabajadores de la prensa son enemigos de todos(menos de si
  mismos).
  Se desea todas las personas enemigas entre si.  */

sonEnemigos(X,Y) :- poder(X,P), poder(Y,Q), P == ejecutivo, Q == judicial.
sonEnemigos(X,Y) :- poder(X,P), poder(Y,Q), P == judicial, Q == ejecutivo.

sonEnemigos2(X,Y) :- poder(X,legislativo), poder(Y,judicial).
sonEnemigos2(X,Y) :- poder(X,judicial), poder(Y,legislativo).
sonEnemigos2(X,Y) :- poder(X,legislativo), poder(Y,legislativo), partido(X,P), partido(X,Q), P\=Q.


sonEnemigos3(X,Y) :- poder(X, prensa), poder(Y, _), X\=Y.
sonEnemigos3(X,Y) :- poder(X, _), poder(Y, prensa), X\=Y.

/* 6. Encontrar el trabajador que tiene la tarea con mayor complejidad. */


trabajadorTareaCompleja(X) :- findall(N, tarea(T, N), Tarea), max_member(N,Tarea), trabajo(X, T), tarea(T, M), N == M.

/* 7. Encontrar a todos los trabajadores que tienen una única tarea. */

unaTarea(P) :- trabajo(P, _), findall(Tarea, trabajo(P, Tarea), Lista), length(Lista, Cant), Cant == 1.



