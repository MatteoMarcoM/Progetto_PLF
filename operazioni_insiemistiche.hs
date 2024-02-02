-- Progetto di Programmazione Logica e Funzionale a.a. 2021/2022
-- Docente: prof. Marco Bernardo
-- Studenti: Giacomo Di Fabrizio, 301591; Matteo Marco Montanari, 299166.
-- Linguaggio Haskell

main :: IO ()
main = do putStrLn "Programma Haskell per effettuare le seguenti operazioni su insiemi di numeri interi:"
          putStrLn "1) Dati due insiemi di numeri interi, verifica ricorsivamente se un insieme è sottoinsieme dell' altro."
          putStrLn "2) Dati due insiemi di numeri interi, verifica se i due insiemi sono uguali."
          putStrLn "3) Dato un insieme di numeri interi, calcola ricorsivamente l'insieme delle parti."
          putStrLn "4) Dato un insieme di numeri interi, calcola ricorsivamente la somma dei numeri pari all'interno dell'insieme."
          putStrLn "5) Dato un insieme di numeri interi, calcola ricorsivamente la somma dei numeri dispari all'interno dell'insieme."
          putStrLn "Inserire il primo insieme di numeri interi racchiuso tra parentesi quadre:"
          i1 <- getLine
          let as = elimina_duplicati (read i1 :: [Int])
          putStr ">> Primo insieme privo di eventuali elementi ripetuti: "
          putStrLn $ show as
          putStrLn "Inserire il secondo insieme di numeri interi racchiuso tra parentesi quadre:"
          i2 <- getLine
          let bs = elimina_duplicati (read i2 :: [Int])
          putStr ">> Secondo insieme privo di eventuali elementi ripetuti: "
          putStrLn $ show bs
          putStr "1) Il primo insieme è sottoinsieme del secondo? "
          putStrLn $ show (sottoinsieme as bs)
          putStr "1) Il secondo insieme è sottoinsieme del primo? "
          putStrLn $ show (sottoinsieme bs as)
          putStr "2) I due insiemi sono uguali? "
          putStrLn $ show (uguali as bs)
          putStr "3) Insieme delle parti del primo insieme: "
          putStrLn $ show (insieme_delle_parti as)
          putStr "3) Insieme delle parti del secondo insieme: "
          putStrLn $ show (insieme_delle_parti bs)
          putStr "4) Somma dei numeri pari del primo insieme: "
          putStrLn $ show (somma_valori_pari as)
          putStr "4) Somma dei numeri pari del secondo insieme: "
          putStrLn $ show (somma_valori_pari bs)
          putStr "5) Somma dei numeri dispari del primo insieme: "
          putStrLn $ show (somma_valori_dispari as)
          putStr "5) Somma dei numeri dispari del secondo insieme: "
          putStrLn $ show (somma_valori_dispari bs)

{- La funzione elimina_duplicati elimina i valori duplicati all'interno in un insieme:
   - il primo e unico argomento della funzione è l'insieme del quale si vogliono eliminare i valori duplicati-}
elimina_duplicati :: [Int] -> [Int]
elimina_duplicati []       = []
elimina_duplicati (x : xs) = x : elimina_duplicati (filter (/= x) xs)          

{- La funzione sottoinsieme verifica se un insieme è sottoinsieme di un altro insieme:
   - il primo argomento è il primo dei due insiemi;
   - il secondo argomento è il secondo dei due insiemi.-}
sottoinsieme :: [Int] -> [Int] -> Bool
sottoinsieme [] _                    = True
sottoinsieme (x : xs) ys | elem x ys = sottoinsieme xs ys
                         | otherwise = False

{- La funzione uguali verifica l'ugualianza tra due insiemi:
   - il primo argomento è il primo dei due insiemi;
   - il secondo argomento è il secondo dei due insiemi. 
   L'uso di sottoinsieme consente di verificare se gli insiemi sono rispettivamente l'uno il sottoinsieme dell'altro
   e l'uso di congiunzione consente di calcolare il valore di verità della congiunzione delle due espressioni logiche risultato della funzione sottoinsieme-}
uguali :: [Int] -> [Int] -> Bool
uguali x y = congiunzione (sottoinsieme x y) (sottoinsieme y x)

{- La funzione congiunzione calcola la congiunzione logica tra due espressioni:
   - il primo argomento è la prima espressione logica;
   - il secondo argomento è la seconda espressione logica. -}
congiunzione :: Bool -> Bool -> Bool
congiunzione False _ = False
congiunzione True x  = x

{- La funzione insieme_delle_parti calcola l'insieme delle parti di un insieme:
   - il primo e unico argomento della funzione è l'insieme del quale si vuole calcolare l'insieme delle parti-}
insieme_delle_parti :: [Int] -> [[Int]]
insieme_delle_parti []       = [[]]
insieme_delle_parti (x : xs) = [zs | ys <- insieme_delle_parti xs, zs <- [ys, (x : ys)] ]

{- La funzione somma_valori_pari calcola la somma dei valori pari all'interno di un insieme:
   - il primo argomento è l'insieme di cui si vuole calcolare la somma dei numeri pari al suo interno. 
   L'uso di even consente di verificare se l'elemento preso in considerazione dalla funzione è pari.-}
somma_valori_pari :: [Int] -> Int
somma_valori_pari []                   = 0
somma_valori_pari (x : xs) | even x    =  x + somma_valori_pari(xs)
                           | otherwise = somma_valori_pari(xs)

{- La funzione somma_valori_dispari calcola la somma dei valori dispari all'interno di un insieme:
   - il primo argomento è l'insieme di cui si vuole calcolare la somma dei numeri dispari al suo interno. 
   L'uso di odd consente di verificare se l'elemento preso in considerazione dalla funzione è dispari. -}
somma_valori_dispari :: [Int] -> Int
somma_valori_dispari []                   = 0
somma_valori_dispari (x : xs) | odd x     = x + somma_valori_dispari(xs)
                              | otherwise = somma_valori_dispari(xs)
