/* Progetto di Programmazione Logica e Funzionale a.a. 2021/2022
Docente: prof. Marco Bernardo
Studenti: Giacomo Di Fabrizio, 301591; Matteo Marco Montanari, 299166.
Linguaggio Prolog
*/

main :- write('Programma Prolog per effettuare le seguenti operazioni su insiemi di numeri interi:'),nl,
        write('1) Dati due insiemi di numeri interi, verifica ricorsivamente se un insieme è sottoinsieme dell altro.'),nl,
        write('2) Dati due insiemi di numeri interi, verifica se i due insiemi sono uguali.'),nl,
        write('3) Dato un insieme di numeri interi, calcola ricorsivamente l insieme delle parti.'),nl,
        write('4) Dato un insieme di numeri interi, calcola ricorsivamente la somma dei numeri pari all interno dell insieme.'),nl,
        write('5) Dato un insieme di numeri interi, calcola ricorsivamente la somma dei numeri dispari all interno dell insieme.'),nl,
        write('Inserire il primo insieme di numeri interi racchiuso tra parentesi quadre e terminato da punto:'),nl,
        read(I1), interi_non_duplicati(I1, AS),
        write('>> Primo insieme privo di eventuali elementi ripetuti: '),
        write(AS), nl,
        write('Inserire il secondo insieme di numeri interi racchiuso tra parentesi quadre e terminato da punto:'),nl,
        read(I2), interi_non_duplicati(I2, BS),
        write('>> Secondo insieme privo di eventuali elementi ripetuti: '),
        write(BS),nl,
        write('Il primo insieme e sottoinsieme del secondo? '),
        risultato_sottoinsieme(AS, BS, R1), write(R1), nl,
        write('Il secondo insieme e sottoinsieme del primo? '),
        risultato_sottoinsieme(BS, AS, R2), write(R2), nl,
        write('I due insiemi sono uguali? '),
        risultato_uguali(AS, BS, R3), write(R3), nl,
        write('Insieme delle parti del primo insieme: '),
        stampa_insieme_parti(AS), nl,
        write('Insieme delle parti del secondo insieme: '),
        stampa_insieme_parti(BS), nl,
        write('Somma dei numeri pari del primo insieme: '),
        somma_valori_pari(AS, R4), write(R4), nl,
        write('Somma dei numeri pari del secondo insieme: '),
        somma_valori_pari(BS, R5), write(R5), nl,
        write('Somma dei numeri dispari del primo insieme: '),
        somma_valori_dispari(AS, R6), write(R6), nl,
        write('Somma dei numeri dispari del secondo insieme: '),
        somma_valori_dispari(BS, R7), write(R7), nl.

		
/* Il predicato interi_non_duplicati rimuove i valori duplicati all'interno di un insieme:
- il primo argomento e' l'insieme del quale si vogliono eliminare i valori duplicati;
- il secondo argomento corrisponde al primo insieme privato dei duplicati.
L'uso del predicato rimuovi_elem  rimuove tutte le occorrenze di un elemento da un insieme */			
						 
interi_non_duplicati([], []).
interi_non_duplicati([X | Xs], [X | L]) :- integer(X),
                                           rimuovi_elem(X, Xs, XsNoX),
                                           interi_non_duplicati(XsNoX, L).
			
/* Il predicato rimuovi_elem elimina tutte le occorrenze di un elemento da un insieme:
- il primo argomento e' l'elemento da rimuovere;
- il secondo argomento e' l'insieme da cui rimuovere l'elemento specificato;
- il terzo argomento e' il risultato di tale operazione di rimozione. */

rimuovi_elem(_, [], []).
rimuovi_elem(X, [X | L], LNoX) 	     :- rimuovi_elem(X, L, LNoX).
rimuovi_elem(X, [Y | L], [Y | LNoX]) :- X \== Y, 
                                        rimuovi_elem(X, L, LNoX).

/* Il predicato sottoinsieme verifica se un insieme e' sottoinsieme di un altro insieme:
- il primo argomento e' il primo dei due insiemi;
- il secondo argomento e' il secondo dei due insiemi. */
		
sottoinsieme([], _).
sottoinsieme([X | Xs], Y) :- membro(X, Y),
                           	 sottoinsieme(Xs, Y).
		
/* il predicato risultato_sottoinsieme permette di stampare il risultato del predicato sottoinsieme tramite l'utilizzo del predicato if_then_else:
- il primo argomento e' il primo dei due insiemi;
- il secondo argomento e' il secondo dei due insiemi;
- il terzo argomento e' il risultato. */

risultato_sottoinsieme(X, Y, R) :- if_then_else(sottoinsieme(X, Y), 
                                                R is 1, 
                                                R is 0).
		
/* il predicato if_then_else implementa il costrutto di selezione in linguaggio prolog:
- il primo argomento e' la condizione dell'if;
- il secondo argomento e' il predicato da eseguire se la condizione è verificata;
- il terzo argomento e' il predicato da eseguire se la condizione non è verificata. */
		
if_then_else(I, T, _) :- I, !, T.
if_then_else(I, _, E) :- \+(I), !, E.

/* predicato per stabilire se un elemento appartiene ad una lista:
- Il primo argomento e' l'elemento di cui stabilire l'appartenenza;
- il secondo  argomento e' la lista in cui stabilire l'appartenenza. */
		
membro(X, [X | _]).
membro(X, [Y | Ys]) :- X \== Y,
                       membro(X, Ys).
		
/* Il predicato uguali verifica l'ugualianza tra due insiemi:
- il primo argomento e' il primo dei due insiemi;
- il secondo argomento e' il secondo dei due insiemi. 
L'uso di sottoinsieme consente di verificare se gli insiemi sono rispettivamente l'uno il sottoinsieme dell'altro. */
		
uguali([], []).
uguali([X | Xs], [Y | Ys]) :- sottoinsieme([X | Xs], [Y | Ys]),
                              sottoinsieme([Y | Ys], [X | Xs]).
		
/* il predicato risultato_uguali permette di stampare il risultato del predicato uguali tramite l'utilizzo del predicato if_then_else:
- il primo argomento e' il primo dei due insiemi;
- il secondo argomento e' il secondo dei due insiemi;
- il terzo argomento e' il risultato. */
		
risultato_uguali(X, Y, R) :- if_then_else(uguali(X, Y), 
                                          R is 1, 
                                          R is 0).
		
/* Il predicato insieme_delle_parti calcola l'insieme delle parti di un insieme:
- il primo argomento e' l'insieme del quale si vuole calcolare l'insieme delle parti;
- il secondo argomento e' l'insieme delle parti. */
		
insieme_delle_parti([], []).
insieme_delle_parti([X | Xs], [X | PXs]) :- insieme_delle_parti(Xs, PXs).
insieme_delle_parti([_ | Xs], PXs) 		 :- insieme_delle_parti(Xs, PXs).									
		
/* il predicato stampa_insieme_parti permette di stampare il risultato del predicato insieme_delle_parti tramite l'utilizzo del predicato setof:
- il primo e unico argomento e' l'insieme del quale si vuole calcolare l'insieme delle parti. */
		
stampa_insieme_parti(X) :- setof(PX, 
                                 insieme_delle_parti(X, PX), 
                                 L),
                           write(L).
		
/* Il predicato pari verifica se un valore e' pari:
- il primo e unico argomento e' il valore del quale si vuole verificare se sia pari. */
		
pari(X) :- Y is mod(X, 2),
           Y =:= 0.
		
/* Il predicato dispari verifica se un valore e' dispari:
- il primo e unico argomento e' il valore del quale si vuole verificare se sia dispari.
L'uso di pari viene utilizzato per verificare se il valore dispari preso in considerazione sommato a uno risulta pari. */
		
dispari(X) :- Y is X + 1,
              pari(Y).
		
/* Il predicato somma_valori_pari calcola la somma dei valori pari all'interno di un insieme:
- il primo argomento e' l'insieme di cui si vuole calcolare la somma dei numeri pari al suo interno;
- il secondo argomento e' la somma dei valori pari all'interno dell'insieme.
L'uso di pari consente di verificare se il termine del predicato e' pari.
L'uso di dispari consente di verificare se il termine del predicato e' dispari */
		
somma_valori_pari([], 0).
somma_valori_pari([X | Xs], P) :- pari(X),
                                  somma_valori_pari(Xs, SP),
                                  P is X + SP.
somma_valori_pari([X | Xs], P) :- dispari(X),
                                  somma_valori_pari(Xs, P).
		
/* Il predicato somma_valori_dispari calcola la somma dei valori dispari all'interno di un insieme:
- il primo argomento e' l'insieme di cui si vuole calcolare la somma dei numeri dispari al suo interno;
- il secondo argomento e' la somma dei valori dispari all'interno dell'insieme.
L'uso di dispari consente di verificare se il termine del predicato e' dispari.
L'uso di pari consente di verificare se il termine del predicato e' pari */
		
somma_valori_dispari([], 0).
somma_valori_dispari([X | Xs], D) :- dispari(X),
                                     somma_valori_dispari(Xs, SD),
                                     D is X + SD.		
somma_valori_dispari([X | Xs], D) :- pari(X),
                                     somma_valori_dispari(Xs, D).