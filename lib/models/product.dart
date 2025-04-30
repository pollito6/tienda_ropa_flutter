class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final String subcategory;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.subcategory,
    this.description = '',
  });
}

final List<Product> demoProducts = [
  // Ropa - Blusas
  Product(
    name: 'Blusa Manga Larga Escote Cuadrado',
    price: 29.99,
    imageUrl: 'Blusa Manga Larga Escote Cuadrado.png',
    category: 'Ropa',
    subcategory: 'blusas',
    description: 'Elegante blusa manga larga con escote cuadrado',
  ),
  Product(
    name: 'Blusa Sin Hombros Slim Top',
    price: 24.99,
    imageUrl: 'Blusa Sin Hombros Slim Top.png',
    category: 'Ropa',
    subcategory: 'blusas',
    description: 'Blusa ajustada sin hombros',
  ),
  Product(
    name: 'Blusa manga larga Corte Princesa',
    price: 34.99,
    imageUrl: 'Blusa manga larga Corte Princesa.png',
    category: 'Ropa',
    subcategory: 'blusas',
    description: 'Blusa elegante con corte princesa',
  ),
  Product(
    name: 'Top Camisola de Encaje Liso',
    price: 27.99,
    imageUrl: 'Top Camisola de Encaje Liso.png',
    category: 'Ropa',
    subcategory: 'blusas',
    description: 'Top de encaje con diseño liso',
  ),

  // Ropa - Calcetines
  Product(
    name: 'Calcetines Japoneses Estampados',
    price: 9.99,
    imageUrl: 'Calcetines Japoneses Estampados.png',
    category: 'Ropa',
    subcategory: 'calcetines',
    description: 'Calcetines con diseños japoneses',
  ),
  Product(
    name: 'Calcetines con volantes',
    price: 8.99,
    imageUrl: 'Calcetines con volantes.png',
    category: 'Ropa',
    subcategory: 'calcetines',
    description: 'Calcetines decorados con volantes',
  ),
  Product(
    name: 'Calcetines de Encaje con Lazo',
    price: 11.99,
    imageUrl: 'Calcetines de Encaje con Lazo.png',
    category: 'Ropa',
    subcategory: 'calcetines',
    description: 'Calcetines elegantes con encaje y lazo',
  ),
  Product(
    name: 'Calcetines Encaje con Moño',
    price: 10.99,
    imageUrl: 'Calcetines Encaje con Moño.png',
    category: 'Ropa',
    subcategory: 'calcetines',
    description: 'Calcetines decorados con encaje y moño',
  ),

  // Ropa - Conjuntos
  Product(
    name: 'Set Tank Top y Minishort',
    price: 39.99,
    imageUrl: 'Set Tank Top y Minishort.png',
    category: 'Ropa',
    subcategory: 'conjuntos',
    description: 'Conjunto deportivo cómodo',
  ),
  Product(
    name: 'Top Deportivo a rayas con Minifalda',
    price: 44.99,
    imageUrl: 'Top Deportivo a rayas con Cuello en V  manga corta y Minifalda Plisada Lisa de Cintura Alta.png',
    category: 'Ropa',
    subcategory: 'conjuntos',
    description: 'Conjunto deportivo con top a rayas y minifalda plisada',
  ),
  Product(
    name: 'Top camisola a cuadros con minifalda',
    price: 42.99,
    imageUrl: 'Top camisola a cuadros cárdigan ligero y minifalda.png',
    category: 'Ropa',
    subcategory: 'conjuntos',
    description: 'Conjunto casual con top a cuadros y minifalda',
  ),
  Product(
    name: 'Cárdigan con Camisola Halter',
    price: 49.99,
    imageUrl: 'Cárdigan de Manga Larga con Ribete Fruncido y Camisola con Cuello Halter.png',
    category: 'Ropa',
    subcategory: 'conjuntos',
    description: 'Conjunto elegante de cárdigan y camisola',
  ),

  // Ropa - Faldas
  Product(
    name: 'Falda Drapeada BabyBlue',
    price: 34.99,
    imageUrl: 'Falda Drapeada BabyBlue.png',
    category: 'Ropa',
    subcategory: 'faldas',
    description: 'Falda drapeada en tono azul bebé',
  ),
  Product(
    name: 'Falda Encaje Negra',
    price: 39.99,
    imageUrl: 'Falda Encaje Negra.png',
    category: 'Ropa',
    subcategory: 'faldas',
    description: 'Falda negra con detalles de encaje',
  ),
  Product(
    name: 'Falda Tableada con Moño Gris',
    price: 36.99,
    imageUrl: 'Falda Tableada con Moño Gris.png',
    category: 'Ropa',
    subcategory: 'faldas',
    description: 'Falda tableada gris con moño decorativo',
  ),
  Product(
    name: 'Mini Falda Patoles con Listones',
    price: 32.99,
    imageUrl: 'Mini Falda Patoles con Listones Gris.png',
    category: 'Ropa',
    subcategory: 'faldas',
    description: 'Mini falda con patoles y listones decorativos',
  ),

  // Ropa - Lenceria
  Product(
    name: 'Conjunto de Lencería Babydoll',
    price: 29.99,
    imageUrl: 'Conjunto de Lencería Babydoll con Lazo Recortado y Tanga.png',
    category: 'Ropa',
    subcategory: 'lenceria',
    description: 'Conjunto de lencería elegante',
  ),
  Product(
    name: 'Sujetador con Lazo y Pantalones Cortos',
    price: 27.99,
    imageUrl: 'Sujetador con Lazo Frontal y Pantalones Cortos con Ribete de Encaje.png',
    category: 'Ropa',
    subcategory: 'lenceria',
    description: 'Conjunto de sujetador con lazo y shorts',
  ),
  Product(
    name: 'Sujetador y Braga sin aros',
    price: 24.99,
    imageUrl: 'Sujetador y Braga sin aros y con tiras.png',
    category: 'Ropa',
    subcategory: 'lenceria',
    description: 'Conjunto cómodo sin aros',
  ),
  Product(
    name: 'Top Sujetador Fruncido con Shorts',
    price: 26.99,
    imageUrl: 'Top Sujetador Fruncido con Ribete de Encaje y Pantalones Cortos.png',
    category: 'Ropa',
    subcategory: 'lenceria',
    description: 'Conjunto de top fruncido y shorts',
  ),

  // Ropa - Pantalones
  Product(
    name: 'Pantalones Lisos de Tiro Medio',
    price: 44.99,
    imageUrl: 'Pantalones Lisos de Tiro Medio y Pierna Ancha.png',
    category: 'Ropa',
    subcategory: 'pantalones',
    description: 'Pantalones cómodos de pierna ancha',
  ),
  Product(
    name: 'Pantalones Cargo Capri',
    price: 49.99,
    imageUrl: 'Pantalones Cargo Capri de Pierna Ancha con Estampado de Camuflaje yTtiro Medio.png',
    category: 'Ropa',
    subcategory: 'pantalones',
    description: 'Pantalones cargo con estampado de camuflaje',
  ),
  Product(
    name: 'Pantalones Deportivos Holgados',
    price: 39.99,
    imageUrl: 'Pantalones Deportivos Holgados de Pierna Ancha con Bordados y Cintura Baja.png',
    category: 'Ropa',
    subcategory: 'pantalones',
    description: 'Pantalones deportivos con bordados',
  ),
  Product(
    name: 'Pantalones Deportivos Dos Tonos',
    price: 42.99,
    imageUrl: 'Pantalones Deportivos de Pierna Ancha en Dos Tonos con Cintura con Cordón.png',
    category: 'Ropa',
    subcategory: 'pantalones',
    description: 'Pantalones deportivos en dos colores',
  ),

  // Ropa - Pijamas
  Product(
    name: 'Conjunto de Pijama de Algodón',
    price: 49.99,
    imageUrl: 'Conjunto de Pijama de Algodón de Manga Larga y Manga Corta.png',
    category: 'Ropa',
    subcategory: 'pijamas',
    description: 'Pijama de algodón con manga larga y corta',
  ),
  Product(
    name: 'Pijama Set Top con Cuello Cuadrado',
    price: 45.99,
    imageUrl: 'Pijama Set Top de manga larga con Cuello Cuadrado Lazo con Volantes y Pantalón Recto.png',
    category: 'Ropa',
    subcategory: 'pijamas',
    description: 'Set de pijama con top y pantalón recto',
  ),
  Product(
    name: 'Vestido de Dormir con Volantes',
    price: 39.99,
    imageUrl: 'Vestido de Dormir de Manga Corta con Volantes y Cuello de Lazo.png',
    category: 'Ropa',
    subcategory: 'pijamas',
    description: 'Vestido de dormir con volantes y lazo',
  ),
  Product(
    name: 'Conjunto de Pijama con Encaje',
    price: 47.99,
    imageUrl: 'Conjunto de Pijama de Algodón de Manga Larga y Manga Corta.png',
    category: 'Ropa',
    subcategory: 'pijamas',
    description: 'Pijama con detalles de encaje',
  ),

  // Ropa - Shorts
  Product(
    name: 'Mini Shorts de Cintura Baja',
    price: 24.99,
    imageUrl: 'Mini Shorts de Cintura Baja con Cordón Ajustable y Dobladillo Abullonado.png',
    category: 'Ropa',
    subcategory: 'shorts',
    description: 'Mini shorts con cordón ajustable',
  ),
  Product(
    name: 'Shorts Vaqueros de Tiro Bajo',
    price: 29.99,
    imageUrl: 'Shorts Vaqueros de Tiro Bajo con Paneles Lavados y Estampado de Leopardo.png',
    category: 'Ropa',
    subcategory: 'shorts',
    description: 'Shorts vaqueros con estampado de leopardo',
  ),
  Product(
    name: 'Mini Shorts Deportivos',
    price: 22.99,
    imageUrl: 'Mini Shorts de Cintura Baja con Cordón Ajustable y Dobladillo Abullonado.png',
    category: 'Ropa',
    subcategory: 'shorts',
    description: 'Shorts deportivos con dobladillo abullonado',
  ),
  Product(
    name: 'Shorts Vaqueros con Estampado',
    price: 27.99,
    imageUrl: 'Shorts Vaqueros de Tiro Bajo con Paneles Lavados y Estampado de Leopardo.png',
    category: 'Ropa',
    subcategory: 'shorts',
    description: 'Shorts vaqueros con paneles lavados',
  ),

  // Ropa - Vestidos
  Product(
    name: 'Vestido Mini de Corte A con Lazo',
    price: 54.99,
    imageUrl: 'Vestido Mini de Corte A con Lazo floral y Mangas Abullonadas.png',
    category: 'Ropa',
    subcategory: 'vestidos',
    description: 'Vestido mini con lazo floral',
  ),
  Product(
    name: 'Vestido Midi de Corte A',
    price: 59.99,
    imageUrl: 'Vestido Midi de Corte A con Lazo Liso y Mangas Cortas.png',
    category: 'Ropa',
    subcategory: 'vestidos',
    description: 'Vestido midi con lazo y mangas cortas',
  ),
  Product(
    name: 'Vestido Mini con Lunares',
    price: 49.99,
    imageUrl: 'Vestido Mini de Corte A Entallado con Lunares y Tirantes Finos.png',
    category: 'Ropa',
    subcategory: 'vestidos',
    description: 'Vestido mini con estampado de lunares',
  ),
  Product(
    name: 'Vestido Mini Plisado',
    price: 52.99,
    imageUrl: 'Vestido Mini Plisado de Corte A con Mangas Abullonadas y Detalle de Botones.png',
    category: 'Ropa',
    subcategory: 'vestidos',
    description: 'Vestido mini plisado con botones',
  ),
  // Ropa - Blusas
  Product(
    name: 'Blusa Manga Larga Escote Cuadrado',
    price: 29.99,
    imageUrl: 'Blusa Manga Larga Escote Cuadrado.png',
    category: 'Ropa',
    subcategory: 'blusas',
    description: 'Elegante blusa manga larga con escote cuadrado',
  ),
  // Ropa - Calcetines
  Product(
    name: 'Calcetines Japoneses Estampados',
    price: 9.99,
    imageUrl: 'Calcetines Japoneses Estampados.png',
    category: 'Ropa',
    subcategory: 'calcetines',
    description: 'Calcetines con diseños japoneses',
  ),
  // Ropa - Conjuntos
  Product(
    name: 'Set Tank Top y Minishort',
    price: 39.99,
    imageUrl: 'Set Tank Top y Minishort.png',
    category: 'Ropa',
    subcategory: 'conjuntos',
    description: 'Conjunto deportivo cómodo',
  ),
  // Ropa - Faldas
  Product(
    name: 'Falda Drapeada BabyBlue',
    price: 34.99,
    imageUrl: 'Falda Drapeada BabyBlue.png',
    category: 'Ropa',
    subcategory: 'faldas',
    description: 'Falda drapeada en tono azul bebé',
  ),
  // Ropa - Lenceria
  Product(
    name: 'Conjunto de Lencería Babydoll',
    price: 29.99,
    imageUrl: 'Conjunto de Lencería Babydoll con Lazo Recortado y Tanga.png',
    category: 'Ropa',
    subcategory: 'lenceria',
    description: 'Conjunto de lencería elegante',
  ),
  // Ropa - Pantalones
  Product(
    name: 'Pantalones Lisos de Tiro Medio',
    price: 44.99,
    imageUrl: 'Pantalones Lisos de Tiro Medio y Pierna Ancha.png',
    category: 'Ropa',
    subcategory: 'pantalones',
    description: 'Pantalones cómodos de pierna ancha',
  ),
  // Ropa - Pijamas
  Product(
    name: 'Conjunto de Pijama de Algodón',
    price: 49.99,
    imageUrl: 'Conjunto de Pijama de Algodón de Manga Larga y Manga Corta.png',
    category: 'Ropa',
    subcategory: 'pijamas',
    description: 'Pijama de algodón con manga larga y corta',
  ),
  Product(
    name: 'Pijama Set Top con Cuello Cuadrado',
    price: 45.99,
    imageUrl: 'Pijama Set Top de manga larga con Cuello Cuadrado Lazo con Volantes y Pantalón Recto.png',
    category: 'Ropa',
    subcategory: 'pijamas',
    description: 'Set de pijama con top y pantalón recto',
  ),
  // Ropa - Shorts
  Product(
    name: 'Mini Shorts de Cintura Baja',
    price: 24.99,
    imageUrl: 'Mini Shorts de Cintura Baja con Cordón Ajustable y Dobladillo Abullonado.png',
    category: 'Ropa',
    subcategory: 'shorts',
    description: 'Mini shorts con cordón ajustable',
  ),
  Product(
    name: 'Shorts Vaqueros de Tiro Bajo',
    price: 29.99,
    imageUrl: 'Shorts Vaqueros de Tiro Bajo con Paneles Lavados y Estampado de Leopardo.png',
    category: 'Ropa',
    subcategory: 'shorts',
    description: 'Shorts vaqueros con estampado de leopardo',
  ),
  // Ropa - Vestidos
  Product(
    name: 'Vestido Mini de Corte A con Lazo',
    price: 54.99,
    imageUrl: 'Vestido Mini de Corte A con Lazo floral y Mangas Abullonadas.png',
    category: 'Ropa',
    subcategory: 'vestidos',
    description: 'Vestido mini con lazo floral',
  ),
  Product(
    name: 'Vestido Midi de Corte A',
    price: 59.99,
    imageUrl: 'Vestido Midi de Corte A con Lazo Liso y Mangas Cortas.png',
    category: 'Ropa',
    subcategory: 'vestidos',
    description: 'Vestido midi con lazo y mangas cortas',
  ),
  Product(
    name: 'Vestido Mini con Lunares',
    price: 49.99,
    imageUrl: 'Vestido Mini de Corte A Entallado con Lunares y Tirantes Finos.png',
    category: 'Ropa',
    subcategory: 'vestidos',
    description: 'Vestido mini con estampado de lunares',
  ),
  Product(
    name: 'Vestido Mini Plisado',
    price: 52.99,
    imageUrl: 'Vestido Mini Plisado de Corte A con Mangas Abullonadas y Detalle de Botones.png',
    category: 'Ropa',
    subcategory: 'vestidos',
    description: 'Vestido mini plisado con botones',
  ),
];
