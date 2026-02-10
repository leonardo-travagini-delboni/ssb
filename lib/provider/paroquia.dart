import 'package:flutter/material.dart';
import 'package:ssb/config/func.dart';

class ParoquiaProvider with ChangeNotifier {
  String _categoria = '';

  String get categoria => _categoria;

  static Map<String, Map<String, dynamic>> categoriasMap = {
    'missas': {
      'title': 'Missas',
      'subtitle': 'Horários e dias das missas',
      'icon': Icons.church,
    },
    'confissoes': {
      'title': 'Confissões',
      'subtitle': 'Horários e dias das confissões',
      'icon': Icons.person_3,
    },
    'doacoes': {
      'title': 'Doações via PIX',
      'subtitle': 'Como doar para a paróquia',
      'icon': Icons.pix,
    },
    'atendimento': {
      'title': 'Atendimento',
      'subtitle': 'Horários e dias de atendimento paroquial',
      'icon': Icons.support_agent,
    },
    'igrejas': {
      'title': 'Igrejas',
      'subtitle': 'Informações sobre as igrejas da paróquia',
      'icon': Icons.church,
    },
    'pastorais': {
      'title': 'Pastorais',
      'subtitle': 'Informações sobre as pastorais da paróquia',
      'icon': Icons.group,
    },
    'padres': {
      'title': 'Padres',
      'subtitle': 'Informações sobre os padres da paróquia',
      'icon': Icons.person,
    },
    'historia': {
      'title': 'História',
      'subtitle': 'Informações sobre a história da paróquia',
      'icon': Icons.history,
    },
    'padroeiro': {
      'title': 'Padroeiro',
      'subtitle': 'Informações sobre o padroeiro da paróquia',
      'icon': Icons.star,
    },
  };

  static Map<String, Map<String, String>> missasMap = {
    "Quarta-feira": {
      "19h30": "Capela Nossa Senhora do Perpétuo Socorro (Missa e Novena)",
    },
    "Quinta-feira": {"19h00": "Matriz de São Sebastião"},
    "1a Sexta-feira": {
      "19h30": "Matriz de São Sebastião (Sagrado Coração de Jesus)",
    },
    "2a Sexta-feira": {"20h00": "Capela Rural (Pau d'Alho)"},
    "4a Sexta-feira": {"19h30": "Capela Rural (Bairro do Gonçalves)"},
    "Sábado": {
      "17h30": "Capela São Benedito",
      "19h30": "Capela São Francisco de Assis",
    },
    "Domingo": {
      "07h30": "Capela Nossa Senhora Aparecida",
      "09h30": "Capela Nossa Senhora do Perpétuo Socorro",
      "17h30": "Capela Nossa Senhora da Cabeça",
      "19h30": "Matriz de São Sebastião",
    },
  };

  static Map<String, Map<String, String>> confissoesMap = {
    "Quarta-feira": {"09h30 - 11h30": "Paróquia São Sebastião"},
    "Quinta-feira": {"15h00 - 17h00": "Paróquia São Sebastião"},
    "Sexta-feira": {"09h30 - 11h30": "Paróquia São Sebastião"},
    "Sábado": {"09h30 - 11h30": "Paróquia São Sebastião"},
  };

  static Map<String, String> pixMap = {
    "pix_tipo_chave": "CNPJ",
    "pix_chave": "03.707.358/0033-24",
    "pix_recebedor": "PAROQUIA DE SAO SEBASTIAO",
    "pix_banco": "CAIXA ECONOMICA FEDERAL",
  };

  static Map<String, Map<String, String>> atendimentoMap = {
    "Segunda-feira": {
      "08h00 - 11h00 (manhã)": "Secretaria Paroquial",
      "13h00 - 17h00 (tarde)": "Secretaria Paroquial",
    },
    "Terça-feira": {
      "08h00 - 11h00 (manhã)": "Secretaria Paroquial",
      "13h00 - 17h00 (tarde)": "Secretaria Paroquial",
    },
    "Quarta-feira": {
      "08h00 - 11h00 (manhã)": "Secretaria Paroquial",
      "13h00 - 17h00 (tarde)": "Secretaria Paroquial",
    },
    "Quinta-feira": {
      "08h00 - 11h00 (manhã)": "Secretaria Paroquial",
      "13h00 - 17h00 (tarde)": "Secretaria Paroquial",
    },
    "Sexta-feira": {
      "08h00 - 11h00 (manhã)": "Secretaria Paroquial",
      "13h00 - 17h00 (tarde)": "Secretaria Paroquial",
    },
    "Sábado": {"08h00 - 12h00 (manhã)": "Secretaria Paroquial"},
  };

  static List<Map<String, String>> pastoraisMap = [
    {
      "nome": "Apostolado da Oração",
      "descricao":
          "Junte-se a nós na oração diária pela cidade, pela igreja e pelo mundo.",
      "imagem": "assets/img/pastorais/apostolado_oracao.png",
      "telefone": "(17) 99219-9433",
      "responsavel": "Lucia",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517992199433",
    },
    {
      "nome": "Pastoral da Sobriedade",
      "descricao":
          "Com a graça de Deus, recuperação e amor na luta contra o vício.",
      "imagem": "assets/img/pastorais/sobriedade.png",
      "telefone": "(17) 99257-2226",
      "responsavel": "Mario",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517992572226",
    },
    {
      "nome": "Pastoral do Batismo",
      "descricao":
          "Um começo abençoado na jornada de fé. Siga pelo caminho de Luz.",
      "imagem": "assets/img/pastorais/batismo.png",
      "telefone": "(17) 99163-5643",
      "responsavel": "Mara",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517991635643",
    },
    {
      "nome": "Pastoral da Acolhida",
      "descricao": "Seja bem-vindo! Encontre amor e comunidade aqui.",
      "imagem": "assets/img/pastorais/acolhida.png",
      "telefone": "(17) 99164-3944",
      "responsavel": "Irma Reame",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517991643944",
    },
    {
      "nome": "Catequese 1º Eucaristia",
      "descricao": "Preparação amorosa para o sacramento da Comunhão.",
      "imagem": "assets/img/pastorais/catequese.png",
      "telefone": "(17) 99768-5957",
      "responsavel": "Vanessa Cosmo",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517997685957",
    },
    {
      "nome": "Pastoral da Crisma",
      "descricao": "Crescimento espiritual na fé e confirmação junto a Cristo.",
      "imagem": "assets/img/pastorais/crisma.jpg",
      "telefone": "(17) 99728-6082",
      "responsavel": "Maria Joana",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517997286082",
    },
    {
      "nome": "Pastoral do Dízimo",
      "descricao":
          "Generosidade e partilha no corpo de Cristo e na Santa Igreja.",
      "imagem": "assets/img/pastorais/dizimo.png",
      "telefone": "(17) 99184-0364",
      "responsavel": "Marli",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517991840364",
    },
    {
      "nome": "Pastoral do Matrimônio",
      "descricao": "Orientação e apoio para uma vida conjugal abençoada.",
      "imagem": "assets/img/pastorais/matrimonio.jpg",
      "telefone": "(17) 99737-5670",
      "responsavel": "Marcelo",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517997375670",
    },
    {
      "nome": "Pastoral da Comunicação",
      "descricao": "Comunicação, divulgação e evangelização na era digital.",
      "imagem": "assets/img/pastorais/pascom.jpg",
      "telefone": "(17) 99131-1567",
      "responsavel": "Helga",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517991311567",
    },
    {
      "nome": "Ministério da Eucaristia",
      "descricao": "Operários de Cristo dedicados à celebração da Eucaristia.",
      "imagem": "assets/img/pastorais/eucaristia.png",
      "telefone": "(17) 99731-6483",
      "responsavel": "Rinaldo",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517997316483",
    },
    {
      "nome": "Pastoral Litúrgica",
      "descricao":
          "Celebração da fé através da beleza do ritual da Santa Missa.",
      "imagem": "assets/img/pastorais/liturgia.png",
      "telefone": "(17) 99129-2896",
      "responsavel": "Ronaldo",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517991292896",
    },
    {
      "nome": "Pastoral dos Acólitos e Coroinhas",
      "descricao": "Auxiliando o altar em honra a Deus durante a Santa Missa.",
      "imagem": "assets/img/pastorais/acolitos2.jpg",
      "telefone": "(17) 99100-4069",
      "responsavel": "Rafael Gotardo",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517991004069",
    },
    {
      "nome": "Pastoral dos Jovens",
      "descricao": "Juventude engajada na fé em Cristo e na comunidade.",
      "imagem": "assets/img/pastorais/juventude.jpg",
      "telefone": "(17) 99165-1232",
      "responsavel": "Priscila",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517991651232",
    },
    {
      "nome": "Pastoral da Família",
      "descricao": "Apoio e orientação para a vida familiar cristã católica.",
      "imagem": "assets/img/pastorais/familia.jpg",
      "telefone": "(17) 99711-9829",
      "responsavel": "Viviane",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517997119829",
    },
    {
      "nome": "Renovação Carismática Católica (RCC)",
      "descricao": "Unidade e fé moldam nossa missão. Viva o Espírito!",
      "imagem": "assets/img/pastorais/rcc.jpg",
      "telefone": "(17) 98804-1746",
      "responsavel": "Glaucia",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517988041746",
    },
    {
      "nome": "Conselho Paroquial Pastoral (CPP)",
      "descricao": "Planejamento, avaliação e execução de projetos paroquiais.",
      "imagem": "assets/img/pastorais/cpp.png",
      "telefone": "(17) 99184-0364",
      "responsavel": "Marli",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517991840364",
    },
    {
      "nome": "Conselho Paroquial Administrativo (CPA)",
      "descricao": "Análise e direção contábil para a comunidade paroquial.",
      "imagem": "assets/img/pastorais/cpa.png",
      "telefone": "(17) 99654-7477",
      "responsavel": "Juliane Soares",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517996547477",
    },
  ];

  static List<Map<String, dynamic>> igrejasMap = [
    {
      "nome": "São Sebastião",
      "endereco": "Rua São Sebastião, 335",
      "bairro": "Vila Baumann",
      "cidade": "Novo Horizonte",
      "estado": "SP",
      "cep": "14962-404",
      "foto": "assets/img/igrejas/ssb1.png",
      "carousel": [
        "assets/img/igrejas/ssb1.png",
        "assets/img/igrejas/ssb2.png",
        "assets/img/igrejas/ssb3.png",
        "assets/img/igrejas/ssb4.png",
        "assets/img/igrejas/ssb5.png",
        "assets/img/igrejas/ssb6.png",
        "assets/img/igrejas/ssb7.png",
        "assets/img/igrejas/ssb8.png",
        "assets/img/igrejas/ssb9.png",
        "assets/img/igrejas/ssb10.png",
      ],
      "responsavel": "Renata",
      "telefone": "(17) 99747-9104",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517997479104",
      "missas": {
        "Quinta-feira": "19h00",
        "1a Sexta-feira": "19h30 (Sagrado Coração de Jesus)",
        "Domingo": "19h30",
      },
    },
    {
      "nome": "São Benedito",
      "endereco": "Av. Antônio Pedro Tomitão, 561",
      "bairro": "São Benedito",
      "cidade": "Novo Horizonte",
      "estado": "SP",
      "cep": "14965-280",
      "foto": "assets/img/igrejas/sao_benedito1.png",
      "carousel": [
        "assets/img/igrejas/sao_benedito1.png",
        "assets/img/igrejas/sao_benedito2.png",
      ],
      "responsavel": "Alice",
      "telefone": "(17) 99212-0286",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517992120286",
      "missas": {"Sábado": "17h30"},
    },
    {
      "nome": "São Francisco",
      "endereco": "Rua Ubaldino Antunes de Oliveira, 583",
      "bairro": "São Benedito",
      "cidade": "Novo Horizonte",
      "estado": "SP",
      "cep": "14967-004",
      "foto": "assets/img/igrejas/sao_francisco.png",
      "carousel": ["assets/img/igrejas/sao_francisco.png"],
      "responsavel": "Fatima",
      "telefone": "(17) 99651-4967",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517996514967",
      "missas": {"Sábado": "19h30"},
    },
    {
      "nome": "Nossa Senhora do Perpétuo Socorro",
      "endereco": "Próx. Vicinal Salatiel Costa Pereira",
      "bairro": "São Benedito",
      "cidade": "Novo Horizonte",
      "estado": "SP",
      "cep": "14960-000",
      "foto": "assets/img/na.png",
      "carousel": ["assets/img/na.png"],
      "responsavel": "Cidinha",
      "telefone": "(17) 99109-7384",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517991097384",
      "missas": {"Quarta-feira": "19h30 (Missa e Novena)", "Domingo": "09h30"},
    },
    {
      "nome": "Nossa Senhora da Cabeça",
      "endereco": "Cruz. R. Luis Biela com R. Antenor Mestriner",
      "bairro": "São José",
      "cidade": "Novo Horizonte",
      "estado": "SP",
      "cep": "14966-040",
      "foto": "assets/img/igrejas/nsa_cabeca1.png",
      "carousel": [
        "assets/img/igrejas/nsa_cabeca1.png",
        "assets/img/igrejas/nsa_cabeca2.png",
      ],
      "responsavel": "Marlon",
      "telefone": "(17) 99185-7238",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517991857238",
      "missas": {"Domingo": "17h30"},
    },
    {
      "nome": "Nossa Senhora Aparecida",
      "endereco": "Rua Araguaia, 161",
      "bairro": "Manga Larga",
      "cidade": "Novo Horizonte",
      "estado": "SP",
      "cep": "14967-004",
      "foto": "assets/img/igrejas/nsa_aparecida1.png",
      "carousel": [
        "assets/img/igrejas/nsa_aparecida1.png",
        "assets/img/igrejas/nsa_aparecida2.png",
      ],
      "responsavel": "Cleonice",
      "telefone": "(17) 99712-4764",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517997124764",
      "missas": {"Domingo": "07h30"},
    },
    {
      "nome": "N.S. Aparecida (Gonçalves)",
      "endereco": "",
      "bairro": "",
      "cidade": "Novo Horizonte",
      "estado": "SP",
      "cep": "14967-004",
      "foto": "assets/img/igrejas/goncalves1.png",
      "carousel": ["assets/img/igrejas/goncalves1.png"],
      "responsavel": "Jerson",
      "telefone": "(17) 99777-6484",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517997776484",
      "missas": {"4a Sexta-feira": "19h30"},
    },
    {
      "nome": "Santa Luzia",
      "endereco": "Sítio Santa Luzia",
      "bairro": "Pau d'Alho",
      "cidade": "Novo Horizonte",
      "estado": "SP",
      "cep": "14960-000",
      "foto": "assets/img/igrejas/sta_luzia.png",
      "carousel": ["assets/img/igrejas/sta_luzia.png"],
      "responsavel": "Juliane",
      "telefone": "(17) 99654-7477",
      "whatsapp": "https://api.whatsapp.com/send/?phone=5517996547477",
      "missas": {"2a Sexta-feira": "20h00"},
    },
  ];

  static List<Map<String, String>> padresMap = [
    {
      "apelido": "Pe. Carlos",
      "nome": "Pe. Carlos Umberto Franquin",
      "periodo": "2008 - 2012",
      "imagem": "assets/img/padres/pe_carlos.png",
    },
    {
      "apelido": "Pe. Eduardo",
      "nome": "Pe. Carlos Eduardo Cristófaro",
      "periodo": "2012 - 2021",
      "imagem": "assets/img/padres/pe_eduardo.png",
    },
    {
      "apelido": "Pe. Raphael",
      "nome": "Pe. Raphael Marchi Farias",
      "periodo": "2021 - 2023",
      "imagem": "assets/img/padres/pe_raphael.png",
    },
    {
      "apelido": "Pe. Eugênio",
      "nome": "Padre Eugênio Pessato",
      "periodo": "2023 - atualmente",
      "imagem": "assets/img/padres/pe_eugenio.png",
    },
  ];

  ParoquiaProvider() {
    initProvider();
  }

  void initProvider() {
    dp('ParoquiaProvider: Initializing');
    _categoria = '';
  }

  void setCategoria(String newCategoria) {
    dp('ParoquiaProvider: Setting categoria to $newCategoria');
    _categoria = newCategoria;
    notifyListeners();
  }

  void clearAll() {
    dp('ParoquiaProvider: Clearing all state');
    _categoria = '';
    notifyListeners();
  }
}
