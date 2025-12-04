final class Exercise { //definisco classe esercizio
  final String name; //nome 
  final int score ;  //voto
  final DateTime submittedAt; //inviato
  Exercise(this.name, this.score, this.submittedAt); //deve avere per forza questi elementi la lista (required) 

  bool get isPassed {   //funzione per controllare se il punteggio è sufficiente (i.e. maggiore o uguale a 60)
    return score >= 60; 
  }
}
List<Exercise> passedOnly(List<Exercise> list) { //funzione per gli esercizi passati
  List<Exercise> result = [];  // Lista vuota dove salva gli esercizi superati

  // funzione che vede tutti gli esercizi della lista
  for (var i in list) {
    // Se superato lo inserisce nella lista
    if (i.isPassed) {
      result.add(i);
    }
  }
  return result; //ritorna la lista degli esami superati
}
// Funzione miglior studente 
String bestStudent(List<Exercise> list) { //uso string perchè quello che voglio ottenere è un nome ( in quersto caso del miglior studente )
   // Assume che il primo esercizio sia quello col punteggio migliore
  Exercise betterstudent = list[0];
  // vede tutti gli esercizi della lista
  for (var i in list) {
      if (i.score > betterstudent.score) {
      betterstudent = i;
    }
  }
return betterstudent.name ; //ritorna il nome del miglior studente 
}
// scrivi una funzione averageScore che accetta una lista di esercizi e ne calcola il punteggio medio
double averageScore(List<Exercise> list) {  //punteggio medio (funzione duble perche lavoro con la ,)
  int result = 0;  // assegno una variabile per fare il calcolo della media

  // funzione che vede la lista e somma tutti i punteggi 
  for (var i in list) {
    result += i.score;
  }

  // fa la media grazie alla proprietà lenght che calcola quanti elementi cis ono nella lista 
  return result / list.length;
}
