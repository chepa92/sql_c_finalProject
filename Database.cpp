#include "Database.h"
//#include <iostream>

void clearCin() {
	string temp;
	getline(cin, temp);
}


Database *Database::instance = 0;

Database::Database() : driver(get_driver_instance()) {
	connection_properties["hostName"] = DB_HOST;
	connection_properties["port"] = DB_PORT;
	connection_properties["userName"] = DB_USER;
	connection_properties["password"] = DB_PASS;
	connection_properties["OPT_RECONNECT"] = true;
}
	

Database & Database::getInstance() {
	if (Database::instance == 0) {
		instance = new Database();
	}
	return *instance;
}

Connection * Database::getConnection() {
	try {
		Connection *con = driver->connect(connection_properties);
		con->setSchema(DB_NAME);
		return con;
	}
	catch (SQLException &e) {
		cout << e.what();
	}
	return 0;
}


//Option 1
void Database::showBetweenTwoDates() {
	string temp1, temp2;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT * FROM album where album_startRecDate >= ? AND album_finishRecDate <= ?;");

	cout << endl <<"Please enter date in this pattern YYYY-MM-DD\n" << endl;
	cout << "Please enter from date: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);
	cout << "Please enter to date: ";
	getline(cin, temp2);
	pstmt->setString(2, temp2);
	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "Number of recorded albums between " << temp1 << " and " << temp2 << " is: " << rset->rowsCount() << "." << endl;
	}
	else cout << "Invalid Date or No Orders Found That Where Ordered Between Dates." << endl;


	delete con;
	delete pstmt;
	delete rset;
}

//Option 2
void Database::showSongsBetweenTwoDates() {

	string temp1, temp2, temp3;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT * FROM song INNER JOIN album ON song.album_id = album.album_id INNER JOIN musician ON album.musician_id = musician.musician_id WHERE song.song_date >= ? AND song.song_date <= ? AND musician.musician_name LIKE ?");


	cout << endl << "Please enter date in this pattern YYYY-MM-DD\n" << endl;
	cout << "Please enter from date: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);
	cout << "Please enter to date: ";
	getline(cin, temp2);
	pstmt->setString(2, temp2);
	cout << "Please enter musician Name: ";
	getline(cin, temp3);
	pstmt->setString(3, temp3);

	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "Number of recorded songs of "<< temp3 << " between " << temp1 << " and " << temp2 << " is: " << rset->rowsCount() << "." << endl;
	}
	else cout << "Invalid Date or No Orders Found That Where Ordered Between Dates." << endl;


	delete con;
	delete pstmt;
	delete rset;
}

//Option 3
void Database::showAlbumsBetweenDatesAndComposer() {
	string temp1, temp2, temp3;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT DISTINCT album.album_name FROM song, album INNER JOIN musician ON album.musician_id = musician.musician_id  WHERE song.song_date >= ? AND song.song_date <= ? AND musician.musician_name LIKE ?");


	cout << endl << "Please enter date in this pattern YYYY-MM-DD\n" << endl;
	cout << "Please enter from date: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);
	cout << "Please enter to date: ";
	getline(cin, temp2);
	pstmt->setString(2, temp2);
	cout << "Please enter musician Name: ";
	getline(cin, temp3);
	pstmt->setString(3, temp3);

	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "Number of recorded albums where included " << temp3 << " between " << temp1 << " and " << temp2 << " is: " << rset->rowsCount() << "." << endl;
	}
	else cout << "Invalid Date or No Orders Found That Where Ordered Between Dates." << endl;


	delete con;
	delete pstmt;
	delete rset;
}

//Option 4
void Database::showMostPopularInstrument() {
	Connection *con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement *stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT instrument.instrument_name, COUNT(*) as count FROM song INNER JOIN instrument ON song.instrument_id = instrument.instrument_id GROUP BY instrument_name ORDER BY count DESC LIMIT 1; ");

	rset->beforeFirst();

	if (rset->first()) {
		cout <<"Most used instrument is: "<< rset->getString("instrument_name") <<" appears " << rset->getString("count") << " times." << endl;
	}

	delete con;
	delete stmt;
	delete rset;
}

//Option 5
void Database::instrumentsInAlbum() {
	string temp1;
	int counter = 1;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT DISTINCT instrument.instrument_name FROM album INNER JOIN song ON album.album_id = song.album_id INNER JOIN instrument ON song.instrument_id = instrument.instrument_id WHERE album.album_name = ? ;");

	cout << "Please enter album name: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);

	rset = pstmt->executeQuery();

	if (rset->rowsCount() == 0) {
		cout << "No such album found" << endl;
		return;
	}

	rset->beforeFirst();
	cout << "Instruments that album " << temp1 << " includes are:" << endl;

	while (rset->next()) {
		cout << counter << ") " << rset->getString("instrument_name") << endl;
		++counter;
	}

	delete con;
	delete pstmt;
	delete rset;
}

//Option 6
void Database::releaseMostNumOfAlbums() {
	string temp1, temp2;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT musician.musician_name, COUNT(*) AS count FROM musician INNER JOIN album ON musician.musician_id = album.musician_id WHERE album_startRecDate >= ? AND album_finishRecDate <= ? GROUP BY musician.musician_name ORDER BY count DESC LIMIT 1");

	cout << endl << "Please enter date in this pattern YYYY-MM-DD\n" << endl;
	cout << "Please enter from date: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);
	cout << "Please enter to date: ";
	getline(cin, temp2);
	pstmt->setString(2, temp2);
	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "Most released albums maker is: " << rset->getString("musician_name") << " which released " << rset->getString("count") << " albums." << endl;
	}
	else cout << "Invalid Date or No Orders Found That Where Ordered Between Dates." << endl;

	delete con;
	delete pstmt;
	delete rset;
}

//Option 7
void Database::mostPopularManufacturer() {
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT manufacturer.manufacturer_name, COUNT(*) AS count FROM instrument INNER JOIN manufacturer ON instrument.manufacturer_id = manufacturer.manufacturer_id INNER JOIN song ON song.instrument_id = instrument.instrument_id GROUP BY manufacturer.manufacturer_name ORDER BY count DESC LIMIT 1;");
	int counter = 1;
	rset->beforeFirst();
	cout << "Most:" << endl;

	if (rset->first()) {
		cout << "Most popular manufacturer maker is: " << rset->getString("manufacturer_name") << " which sold " << rset->getString("count") << " instruments." << endl;
	}

	delete con;
	delete stmt;
	delete rset;
	counter = 1;
}

// Option 8
void Database::totalRecordsInMin() {

	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT SUM(song.song_time) / 60 as time FROM song; ");
	rset->beforeFirst();

	if (rset->first()) {
		cout << "Total records time is : " << rset->getString("time") << " mins"<< endl;
	}

	delete con;
	delete stmt;
	delete rset;
}

// Option 9
void Database::mostAssistMusician() {

	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT musician.musician_name,  COUNT(*) AS count FROM song_with INNER JOIN musician ON song_with.musician_id = musician.musician_id GROUP BY musician.musician_name ORDER BY count DESC LIMIT 1;");
	rset->beforeFirst();

	if (rset->first()) {
		cout << "Most assisted musician : " << rset->getString("musician_name") << " with " << rset->getString("count") << " assists" <<endl;
	}

	delete con;
	delete stmt;
	delete rset;
}

// Option 10
void Database::mostPopularGenre() {
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT genre.genre_name, COUNT(*) AS count FROM song INNER JOIN genre ON song.genre_id = genre.genre_id GROUP BY genre.genre_name ORDER BY count DESC LIMIT 1");
	rset->beforeFirst();

	if (rset->first()) {
		cout << "Most popular genre : " << rset->getString("genre_name") << " with " << rset->getString("count") << " songs" << endl;
	}

	delete con;
	delete stmt;
	delete rset;
}

// Option 11 
void Database::bestCustomerDetails() {
	string temp1, temp2;
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	ResultSet* rset;
	PreparedStatement* pstmt = con->prepareStatement("SELECT musician.musician_name, COUNT(song.song_tech_id) AS count FROM musician INNER JOIN song ON musician.musician_id = song.song_tech_id WHERE song.song_date >= ? AND song.song_date <= ? GROUP BY musician.musician_name ORDER BY count DESC;");

	cout << endl << "Please enter date in this pattern YYYY-MM-DD\n" << endl;
	cout << "Please enter from date: ";
	clearCin();
	getline(cin, temp1);
	pstmt->setString(1, temp1);
	cout << "Please enter to date: ";
	getline(cin, temp2);
	pstmt->setString(2, temp2);
	rset = pstmt->executeQuery();

	if (rset->first()) {
		cout << "The technician name is: " << rset->getString("musician_name") << " with records number: " << rset->getString("count") << endl;
	}
	else cout << "Invalid Date or No Orders Found That Where Ordered Between Dates." << endl;


	delete con;
	delete pstmt;
	delete rset;
}

//Option 12
void Database::firstRecAlbum() {
	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT album.album_name, album.album_finishRecDate FROM album ORDER BY album.album_finishRecDate LIMIT 1;");
	rset->beforeFirst();

	if (rset->first()) {
		cout << "First recorded album is: " << rset->getString("album_name") << " at " << rset->getString("album_finishRecDate") << endl;
	}

	delete con;
	delete stmt;
	delete rset;
}

//Option 13
void Database::songsInTwoOrMoreAlbums() {


	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT song.song_id, song.song_name FROM song WHERE song.song_id = song.song_id AND song.album_id != song.album_id;");
	rset->beforeFirst();

	if (rset->first()) {
		cout << "The song id is: " << rset->getString("song_id") << endl;
	}
	else cout << "No duplicate songs found." << endl;

	delete con;
	delete stmt;
	delete rset;
}

//Option 14
void Database::techniciansInWholeAlbum() {

	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT DISTINCT musician.musician_name FROM musician INNER JOIN song ON musician.musician_id = song.song_tech_id INNER JOIN album ON album.album_id = song.album_id;");
	rset->beforeFirst();


	if (rset->first()) {
		cout << "The song id is: " << rset->getString("song_id") << endl;
	}

	delete con;
	delete stmt;
	delete rset;
}

//Option 15
void Database::musicianWithMostGenres() {

	Connection* con = driver->connect(connection_properties);
	con->setSchema(DB_NAME);
	Statement* stmt = con->createStatement();
	ResultSet* rset = stmt->executeQuery("SELECT musician.musician_name, COUNT(musician.musician_name) AS count  FROM genre INNER JOIN song ON genre.genre_id = song.genre_id INNER JOIN album ON song.album_id = album.album_id INNER JOIN musician ON album.musician_id = musician.musician_id GROUP BY musician.musician_name ORDER BY count DESC;");
	rset->beforeFirst();

	if (rset->first()) {
		cout << "Most genres composited: " << rset->getString("musician_name") << " with " << rset->getString("count") << " genres."<< endl;
	}

	delete con;
	delete stmt;
	delete rset;

}