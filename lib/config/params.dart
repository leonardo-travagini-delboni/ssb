String appName = 'Paróquia São Sebastião';
String appVersion = 'v1.2.0';
int releaseVersion = 6;
String releaseDate = DateTime.now()
    .subtract(Duration(hours: 3))
    .toString()
    .split(' ')[0];
bool showDebugBanner = false;
bool enableDebugPrint = true;
bool enableCronograma = true;
String cronogramaFile = 'cronograma_fev26.pdf';
bool enableGame = false;
bool enableIA = true;
String aiWhatsapp = "https://api.whatsapp.com/send/?phone=18888186248";
bool enableDiocese = false;
bool enableSocial = true;
bool enableCreditos = true;
