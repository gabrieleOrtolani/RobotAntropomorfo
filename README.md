# RobotAntropomorfo
PRIMA PARTE (MANIPOLATORI)
Utilizzando Processing, disegnare un robot ANTROPOMORFO operato in CINEMATICA INVERSA. Il valore desiderato (xd,yd,zd) per la posizione della pinza e il suo orientamento devono essere modificabili da tastiera. 
In particolare, per quanto riguarda la posizione della pinza, le coordinate xd, yd e zd possono essere modificate nel seguente modo: con x minuscolo si diminuisce la coordinata xd, con X maiuscolo la si aumenta. Analogamente si possono usare le lettere y e z per le coordinate yd e zd.
Per quanto riguarda l'orientamento desiderato della pinza, e cioè la matrice Re, procedere come segue. Individuare l'asse z6 della pinza mediante gli angoli di azimuth α e di elevazione β rispetto al sistema di base (x0,y0,z0) (fare riferimento a questa figura), e definire x6 e y6 facendo seguire una rotazione di un angolo θ intorno all'asse z6.
Questo si può dimostrare corrisponde a una parametrizzazione di tipo ZYZ della matrice di rotazione desiderata Re, con angoli (α,90o-β,θ), coincidente quindi con l'espressione della matrice R36 del polso sferico in cui occorre sostituire α al posto di θ4, 90o-β al posto di θ5 e θ al posto di θ6. 
Per cambiare l'orientamento della pinza sarà quindi sufficiente agire sulle variabili α, β e θ mediante la pressione per esempio dei seguenti tasti: a minuscolo per diminuire α e A maiuscolo per aumentarlo, b minuscolo per diminuire β e B maiuscolo per aumentarlo, t minuscolo per diminuire θ e T maiuscolo per aumentarlo.
Scrivere lo sketch tenendo inoltre conto delle seguenti specifiche:
Durante tutta l'esecuzione del programma deve essere riportato a schermo il valore delle coordinate desiderate (xd,yd,zd) per la posizione della pinza e quello (in gradi) degli angoli (α,β,θ) che definiscono l'orientamento della pinza. Le coordinate della pinza vanno scritte SCEGLIENDO COME TERNA DI RIFERIMENTO (x0,y0,z0) 
DI BASE QUELLA CONSIDERATA A LEZIONE (e non quella utilizzata da Processing).
Scrivere a schermo anche la matrice Re desiderata con le colonne di TRE COLORI DIVERSI.
DISEGNARE sia la TERNA (x0,y0,z0) della BASE sia quella (x6,y6,z6) della PINZA utilizzando per i tre assi x, y e z gli STESSI COLORI usati per le colonne di Re (cioè l'asse x va disegnato dello stesso colore della prima colonna di Re,
l'asse y dello stesso colore della seconda colonna e l'asse z come la terza colonna). Per semplicità gli assi possono essere disegnati senza frecce.
TRASCURARE per semplicità il problema delle COLLISIONI tra i vari link del robot.
Per semplicità la PINZA può essere rappresentata come un semplice PARALLELEPIPEDO.
Prevedere la possibilità da tastiera (per esempio con i tasti '+' e '-') di passare dalla soluzione GOMITO ALTO a quella GOMITO BASSO. Fissare invece arbitrariamente la soluzione per il polso sferico.
Includere le funzionalità (già implementate nei vari sketch visti a lezione) che permettono: 1) di modificare l'altezza della vista, 2) di modificare il valore della costante Kp della legge di controllo, 3) di spostare la base del robot con un click di mouse.
Questo sketch contiene alcune funzioni di calcolo matriciale (prodotto e somma tra matrici, calcolo dell'inversa, calcolo della trasposta, ecc.) che possono essere utili per risolvere la cinematica inversa del robot.
