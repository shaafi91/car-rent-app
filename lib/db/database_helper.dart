import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'car_rental.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create Cars Table
    await db.execute('''
      CREATE TABLE cars (
        id TEXT PRIMARY KEY,
        name TEXT,
        price REAL,
        imageUrl TEXT,
        isAvailable INTEGER
      )
    ''');

    // Create Bookings Table
    await db.execute('''
      CREATE TABLE bookings (
        id TEXT PRIMARY KEY,
        userId TEXT,
        carId TEXT,
        startDate TEXT,
        endDate TEXT,
        totalPrice REAL,
        status TEXT
      )
    ''');
  }

  // CRUD Operations for Cars
  Future<void> addCar(Map<String, dynamic> car) async {
    final db = await database;
    await db.insert('cars', car, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getCars() async {
    final db = await database;
    return db.query('cars');
  }

  Future<void> updateCar(Map<String, dynamic> car) async {
    final db = await database;
    await db.update('cars', car, where: 'id = ?', whereArgs: [car['id']]);
  }

  Future<void> deleteCar(String carId) async {
    final db = await database;
    await db.delete('cars', where: 'id = ?', whereArgs: [carId]);
  }

  // CRUD Operations for Bookings
  Future<void> addBooking(Map<String, dynamic> booking) async {
    final db = await database;
    await db.insert('bookings', booking, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getBookings() async {
    final db = await database;
    return db.query('bookings');
  }
}