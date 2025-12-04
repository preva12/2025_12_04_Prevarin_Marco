import 'package:flutter/material.dart';

class Review { //definisco la classe e gli elementi popolanti essa
  String title; //titolo stringa
  String? comment; //commento opzionale quindi string?
  int rating; //recensione da 1 a 5

  Review({
    required this.title,
    this.comment,
    required this.rating,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 41, 104, 62)),
      ),
      home: const HomeScreen(), // qui aggiungo il widget principale alla mia MyApp quindi costruisco un widget sopra
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // Costruttore del widget con chiave opzionale

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // Crea lo stato associato a questo widget
}

class _HomeScreenState extends State<HomeScreen> {
  List<Review> reviews = [];// Lista che conterrà tutte le recensioni
  

  Future<void> _openForm({Review? review, int? index}) async { // Funzione asincrona che apre un form per creare o modificare una review
  final data = await showDialog<Map<String , dynamic>>(
    context: context,
    builder: (_) => AlertDialog( // Costruisce un AlertDialog 
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.maxFinite,
        child: ReviewFormScreen(existing: review),
      ),
    ),
  );
// Controlla se i dati restituiti dal dialog non sono null
  if (data != null) {
    Review newReview = Review(
      title: data['title'], // Imposta il titolo della review
      comment: data['comment'], //imposta il commento della review
      rating: data['rating'], //imposta rating 
    );

    setState(() {
      if (review == null) { // Se 'review' è null, significa che stiamo creando una nuova review
        reviews.add(newReview); // Aggiunge la nuova review alla lista delle recensioni
      } else {
        reviews[index!] = newReview; // Sovrascrive la review all'indice specificato
      }
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Struttura principale della schermata
      appBar: AppBar(title: const Text("MyFork")), // Titolo della barra superiore
      body: ListView.builder( // costruisce lista di elementi
        itemCount: reviews.length, // Numero di elementi nella lista basato sul numero di review
        itemBuilder: (context, i) { // Costruisce ogni elemento che creiamo 
          return ListTile( // Widget singolo per ogni review che creiamo su home page
            title: Text(reviews[i].title), //mostra titolo sulla home page 
              trailing: IconButton(
              icon: const Icon(Icons.edit), //icona per la modifica
              onPressed: () => _openForm(review: reviews[i], index: i),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton( // Al click apre il form per aggiungere una nuova review (bottone in basso a SX)
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Form per inserimento/modifica recensione
class ReviewFormScreen extends StatefulWidget { // Widget per il form di inserimento o modifica di una recensione
  final Review? existing;

  const ReviewFormScreen({super.key, this.existing});

  @override
  State<ReviewFormScreen> createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends State<ReviewFormScreen> { //gestire lo stato del form
  late TextEditingController _titleController; //permette di leggere questi due campi affiche possa mostrarli nella home
  late TextEditingController _commentController;
  int _rating = 1;

  @override
  void initState() { 
    super.initState(); 
    _titleController =
        TextEditingController(text: widget.existing?.title ?? ''); //Un controller per un campo di testo modificabile.
    _commentController =
        TextEditingController(text: widget.existing?.comment ?? ''); //Ogni volta che l'utente modifica un campo di testo con un TextEditingController associato , il campo di testo aggiorna il valore e il controller invia una notifica ai suoi listener. I listener possono quindi leggere il testo e le proprietà di selezione per sapere cosa ha digitato l'utente o come è stata aggiornata la selezione.
    _rating = widget.existing?.rating ?? 1;
  }



 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20.10), //modificabile UI
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'), //inserisce come titoletto nella barra 'title' 
            ),
            TextFormField(
              controller: _commentController,
              decoration: const InputDecoration(labelText: 'Comment'),//inserisce come titoletto nella barra 'Comment'
            ),
            DropdownButtonFormField<int>(
              items: List.generate( // genera una lista di 5 item 
                5,
                (index) => DropdownMenuItem(
                  value: index + 1,     // Imposta il valore del singolo elemento della tendina (da 1 a 5)
                  child: Text('${index + 1}'), // Mostra il numero come testo nella tendina ed è cliccabile 
                ),
              ),
              onChanged: (value) => setState(() {
                _rating = value!; // Aggiorna la variabile _rating con il valore selezionato ( sulla tendina)
              }),
              decoration: const InputDecoration(labelText: 'Rating'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {     // riscrive i dati se si clicca si save 
                Navigator.pop(context, {
                  'title': _titleController.text,
                  'comment': _commentController.text,
                  'rating': _rating,
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    ),
  );
}}