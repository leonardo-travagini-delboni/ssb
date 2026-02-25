// Main App Release Settings
String appName = 'Paróquia São Sebastião';
String appVersion = 'v1.3.0';
int releaseVersion = 7;
String releaseDate = DateTime.now()
    .subtract(Duration(hours: 3))
    .toString()
    .split(' ')[0];

// Debug Settings
bool showDebugBanner = false;
bool enableDebugPrint = true;

// Cronograma Settings
String pdfsPath = 'assets/pdf';
bool enableCronograma = true;
String cronogramaFile = 'cronograma_fev26.pdf';
String cronogramaTitle = 'Cronograma Mensal Fev/26';

// Paroquia Settings
bool enableParoquia = true;

// Biblia Settings
bool enableBiblia = true;
String bibliaFile = 'biblia.pdf';

// Game Settings
bool enableGame = true;
String gameJson = 'assets/json/quiz.json';

// Magisterium AI Settings
bool enableIA = true;
String aiWhatsapp = "https://api.whatsapp.com/send/?phone=18888186248";

// Diocese Settings
bool enableDiocese = false;

// Caritas Settings
bool enableCaritas = false;
String caritasWhatsapp = "https://api.whatsapp.com/send/?phone=5517991789011";
String caritasEmail = "soscaritasdiocesana@gmail.com";

// Social Media & Contact Settings
bool enableSocial = true;

// Credits Settings
bool enableCreditos = true;
String devWhatsapp = "https://api.whatsapp.com/send/?phone=5511994421880";
