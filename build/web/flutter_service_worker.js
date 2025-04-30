'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "538a9e01a4c2fff8fda792818aaac59c",
"assets/AssetManifest.bin.json": "d34457ae0ff390267e48397af0f2db1f",
"assets/AssetManifest.json": "f6d904e9cfee8bc9f43910e0581029d3",
"assets/assets/images/Accesorios/Gorros/Gorro%2520Azul%2520Beanie.png": "4b22173582a2d4f63ebd04da0eb20615",
"assets/assets/images/Accesorios/Gorros/Gorro%2520Militar%2520Mezclilla%2520Azul.png": "454926566e3d2ea5e9041d302f496a29",
"assets/assets/images/Accesorios/Gorros/Gorro%2520Orejera%2520Azul%2520Afelpado.png": "96113d6e3b0c9068dabc739a4d7c93b9",
"assets/assets/images/Accesorios/Gorros/Gorro%2520Verde%2520Militar%2520Lino.png": "bd4bf82874bab86175a89fd365ba260c",
"assets/assets/images/Accesorios/Lentes/Lentes%2520Azul%2520Aqua%2520Vintage%2520Cristalinoss.png": "a5d107cde4770afb2f568d9409f14a63",
"assets/assets/images/Accesorios/Lentes/Lentes%2520Cool%2520Verdes.png": "73ff09942b0c747a0c11082d81b81b42",
"assets/assets/images/Accesorios/Lentes/Lentes%2520Naranjas%2520Vintage.png": "9bac1dc424885e8bfaaf011f6ad8ff65",
"assets/assets/images/Accesorios/Lentes/Lentes%2520Negros%2520Mirada%2520Afilada.png": "a83c0d4af974a11d6d9a1e161a47292d",
"assets/assets/images/Accesorios/Lentes/Lentes%2520Vintage%2520Amarillos%2520Redondos.png": "e46a4cf5d879efdaa584783bb2886454",
"assets/assets/images/Accesorios/Sombreros/BucketHat%2520Multicolor.png": "b2bff153cf2eb46507c77ed102ec6815",
"assets/assets/images/Accesorios/Sombreros/Sombrero%2520Bolero%2520Espa%25C3%25B1ol%2520Negro.png": "d72d16fb3e0eee07665896d04532f428",
"assets/assets/images/Accesorios/Sombreros/Sombrero%2520Desgastado%2520Cafe%2520de%2520Vaquero.png": "2900ecd15edb537e726c3ae679426217",
"assets/assets/images/Accesorios/Sombreros/Sombrero%2520Felpado%2520Verde%2520Lima.png": "3d8cd358e2bcfb0f5c04929cd59765cd",
"assets/assets/images/Accesorios/Sombreros/Sombrero%2520tipo%2520Monty%2520Beret%2520Negro.png": "207d1b055214816f9a75cf2093a5df5b",
"assets/assets/images/Bolsos/Bolso%2520Aterciopelado%2520con%2520Correo%2520y%2520Estampado%2520de%2520Estrellas.png": "52248520460614203ee3e2512b44e478",
"assets/assets/images/Bolsos/Bolso%2520Fruncido%2520Flor%2520Negro.png": "191ae5b7566d4aad5cb44de7c54011a9",
"assets/assets/images/Bolsos/Bolso%2520Gato%2520con%2520Mo%25C3%25B1o.png": "fcdeed9072d5c3e11121540d9d5d89a7",
"assets/assets/images/Bolsos/Bolso%2520Rayas%2520Estilo%2520Totebag.png": "b96335ea21cde1ad8413878081634f79",
"assets/assets/images/Bolsos/Mochila%2520Estrella%2520Tela%2520Desgastado%2520Cafe%2520y%2520Verde.png": "26eeaf69548af9eb5547300790a57a74",
"assets/assets/images/Bolsos/Totebag%2520Terciopleo%2520Verde.png": "9c9c7fc677f70b74641d8502045945d6",
"assets/assets/images/Calzado/Botas/Bota%2520Edici%25C3%25B3n%2520Especial%2520Scooby%2520Doo.png": "8bac20181a499d086da4ab85ed87561a",
"assets/assets/images/Calzado/Botas/Botas%2520de%2520Cafe%2520Hongos%2520Flores.png": "3e54ddee9203e7da6e4b10185131e215",
"assets/assets/images/Calzado/Botas/Botas%2520Groovy%2520Psicodelicas%2520Naranjas.png": "4d6b05b7c3cb0c140adbaa90e98a9939",
"assets/assets/images/Calzado/Botas/Botas%2520Mariposa%2520Tierra%2520Jean.png": "4d657833293aa404c76b756b0e51f919",
"assets/assets/images/Calzado/Botas/Botas%2520Pantorrila%2520Flores%2520Hippie.png": "be96e323d9724b02386cc396c73ac496",
"assets/assets/images/Calzado/Botas/Botas%2520Vaqueras%2520Verde%2520Limon%2520Piel.png": "78b4cdb62f94479498d8b288030c7c71",
"assets/assets/images/Calzado/Botas/Botin%2520Verde%2520Piel.png": "7e408043f201f99cbf906290973c5e94",
"assets/assets/images/Calzado/Sandalias/Sandalia%2520con%2520Plataforma%2520Lila.png": "44b403e9dc432d8a980d6e028072da60",
"assets/assets/images/Calzado/Sandalias/Sandalia%2520con%2520Plataforma%2520Negra.png": "49abc6fb0db531597fc1fcb5b1e58d3f",
"assets/assets/images/Calzado/Sandalias/Sandalia%2520Denim%2520Mariposas%2520Colores.png": "ee09b341529d410c4f490031c9b4c575",
"assets/assets/images/Calzado/Sandalias/Sandalia%2520Negra%2520Zapato%2520Florecitas.png": "22d263d49b53a99d734714776de2a7b8",
"assets/assets/images/Calzado/Sandalias/Sandalia%2520Plataforma%2520Naranja%2520Mariposa.png": "773d81b6269abb4e057a000afa5ff110",
"assets/assets/images/Calzado/Zapatillas/Zapatilla%2520Plataforma%2520Roja.png": "fdad8e7e79b025b8bdedab9842dca9fe",
"assets/assets/images/Calzado/Zapatillas/Zapatos%2520Mary%2520Jane%2520con%2520plataforma%2520y%2520cu%25C3%25B1a.png": "dbb77261eeebf06764076b553928df2d",
"assets/assets/images/Calzado/Zapatillas/Zapatos%2520Mary%2520Jane%2520de%2520tac%25C3%25B3n%2520grueso%2520con%2520plataforma%2520de%2520cuero%2520genuino.png": "2851bd6ef722790787eca91592c7a72b",
"assets/assets/images/Calzado/Zapatillas/Zapatos%2520Mary%2520Jane%2520de%2520tac%25C3%25B3n%2520grueso.png": "55c5bcf164c2a09a945d3ffcc9c52464",
"assets/assets/images/Calzado/Zapatillas/Zapatos%2520Mary%2520Jane%2520lisos%2520con%2520plataforma%2520y%2520tac%25C3%25B3n%2520de%2520bloque.png": "7f2570eac633eb5d952d4b699c9b6e77",
"assets/assets/images/momo_isotipo.png": "ea5996f910d03f4b9fb899dc66184634",
"assets/assets/images/momo_logo_4x.png": "71e146f1540461d934a785866dae5b48",
"assets/assets/images/placeholder.png": "68b329da9893e34099c7d8ad5cb9c940",
"assets/assets/images/Ropa/blusas/Blusa%2520manga%2520larga%2520Corte%2520Princesa.png": "f245c951f58fdef42aa0e9111c3a7fd0",
"assets/assets/images/Ropa/blusas/Blusa%2520Manga%2520Larga%2520Escote%2520Cuadrado.png": "86404259f4baf406a783e38e72882dff",
"assets/assets/images/Ropa/blusas/Blusa%2520Sin%2520Hombros%2520Slim%2520Top.png": "4e2440d925409933063aa0e49ae70ef8",
"assets/assets/images/Ropa/blusas/Camiseta%2520Corta%2520sin%2520Mangas%2520con%2520Bordado%2520Floral.png": "fdab0c181760044c922d027c6dfa1e5a",
"assets/assets/images/Ropa/blusas/Tank%2520Top%2520a%2520la%2520Cintura%2520Drapeado.png": "862ff398c629c9dacb6ae1990e89ed07",
"assets/assets/images/Ropa/blusas/Top%2520Camisola%2520de%2520Encaje%2520Liso.png": "7e369be995b8d870f1da2a83ea4fe382",
"assets/assets/images/Ropa/blusas/Top%2520Corto%2520Ajustado%2520con%2520Lazo.png": "12f55c71d421913fe5c0803414cafda7",
"assets/assets/images/Ropa/blusas/Top%2520Corto%2520de%2520Malla%2520Liso%2520con%2520Hombros%2520Descubiertos.png": "954e6f138060373f696955b146388a16",
"assets/assets/images/Ropa/blusas/Top%2520de%2520Tubo%2520Liso.png": "921fd8ac13935e469f6b6251f8239354",
"assets/assets/images/Ropa/blusas/Top%2520Tank%2520Recto%2520Drapeado.png": "dd46c260fc8befe5666b70dd1166c6ea",
"assets/assets/images/Ropa/calcetines/Calceta%2520Encima%2520de%2520la%2520Rodilla%2520Tejida.png": "499eb3bf0907538ab85a88ff882b1572",
"assets/assets/images/Ropa/calcetines/Calcetin%2520Bajo%2520Tobillo%2520Japones.png": "9b9297434898cab61929af460133070d",
"assets/assets/images/Ropa/calcetines/Calcetin%2520doble%2520con%2520Suela%2520Antiderrapante.png": "246e2efdbdc22e4a4e7307ce7550f34a",
"assets/assets/images/Ropa/calcetines/Calcetines%2520Afelpados%2520con%2520Estampado.png": "bf3f2bd694db7bfcae0e7465313cfb69",
"assets/assets/images/Ropa/calcetines/Calcetines%2520con%2520volantes.png": "22d9d8e1d15eb5e89d42914e9b0883ef",
"assets/assets/images/Ropa/calcetines/Calcetines%2520de%2520Canal%25C3%25A9%2520con%2520Bordado%2520de%2520Flores%2520y%2520Borde%2520de%2520Lechuga.png": "94ab33c72283154ae2fe6bf507daa841",
"assets/assets/images/Ropa/calcetines/Calcetines%2520de%2520Encaje%2520con%2520Lazo.png": "83b1f19bbdd3c9bf2399a278a459e2d5",
"assets/assets/images/Ropa/calcetines/Calcetines%2520Encaje%2520con%2520Mo%25C3%25B1o.png": "9f244d13febb81c915bb0cda6e957f6f",
"assets/assets/images/Ropa/calcetines/Calcetines%2520Japoneses%2520Estampados.png": "62eecc4dbf9565655c09519d0f09f080",
"assets/assets/images/Ropa/conjuntos/C%25C3%25A1rdigan%2520de%2520Manga%2520Larga%2520con%2520Ribete%2520Fruncido%2520y%2520Camisola%2520con%2520Cuello%2520Halter.png": "98505e2425a6ca56be6de36f242d4e97",
"assets/assets/images/Ropa/conjuntos/Camiseta%2520con%2520Cuello%2520Alto%2520y%2520Mangas%2520y%2520Pantalones%2520Cortos%2520Deportivos.png": "8725210845efc0ae2c5ef2964bf95ee3",
"assets/assets/images/Ropa/conjuntos/Falda%2520Cintura%2520Alta%2520y%2520Calentadores%2520de%2520Mezclilla.png": "dff8b8b64246f722bfa161b76389ac06",
"assets/assets/images/Ropa/conjuntos/Set%2520Tank%2520Top%2520y%2520Minishort.png": "739ec4e1e3446cd019cd71fd4e237066",
"assets/assets/images/Ropa/conjuntos/Sudadera%2520con%2520Capucha%2520y%2520Pantal%25C3%25B3n%2520deportivo%2520con%2520Cremallera%2520y%2520Cruz%2520de%2520Diamantes%2520de%2520Imitaci%25C3%25B3n.png": "50fa7b64938dd9ea50b1ad28974bea7d",
"assets/assets/images/Ropa/conjuntos/Top%2520camisola%2520a%2520cuadros%2520c%25C3%25A1rdigan%2520ligero%2520y%2520minifalda.png": "9a2fbee0fd4de26e7d529d4ed76e9967",
"assets/assets/images/Ropa/conjuntos/Top%2520Corto%2520Ajustado%2520con%2520Purpurina%2520yMminifalda%2520de%2520Tiro%2520Bajo%2520con%2520Volantes.png": "84103431212f7a1415734f9043fbee24",
"assets/assets/images/Ropa/conjuntos/Top%2520Deportivo%2520a%2520rayas%2520con%2520Cuello%2520en%2520V%2520%2520manga%2520corta%2520y%2520Minifalda%2520Plisada%2520Lisa%2520de%2520Cintura%2520Alta.png": "a4af4e7ca464be9cb6e9bec43f5d6b37",
"assets/assets/images/Ropa/faldas/Falda%2520de%2520Mezclilla%2520tableada%2520con%2520Cinturones.png": "79367c0a1809d0cebd6ef1a488e980f4",
"assets/assets/images/Ropa/faldas/Falda%2520Drapeada%2520BabyBlue.png": "469449cd348ccd8d270b225b1581ba5d",
"assets/assets/images/Ropa/faldas/Falda%2520Encaje%2520Negra.png": "e680bdf91ad3af242421982a0c67d25d",
"assets/assets/images/Ropa/faldas/Falda%2520Negra%2520Tableada%2520con%2520Cinturones%2520y%2520Hebillas%2520de%2520Coraz%25C3%25B3n.png": "c4b4235c3fb03daad0b0e66aa00a322b",
"assets/assets/images/Ropa/faldas/Falda%2520Tableada%2520con%2520Mo%25C3%25B1o%2520Gris.png": "ef94d16cc688704ab51e0211a4f58f43",
"assets/assets/images/Ropa/faldas/Falda%2520Tableada%2520Gris%2520Claro.png": "66631811e167dd007905af85ab9a1509",
"assets/assets/images/Ropa/faldas/Falda%2520Tableada%2520Gris.png": "72c8161caa3671fbd375bcdfc0dfff92",
"assets/assets/images/Ropa/faldas/Mini%2520Falda%2520Patoles%2520con%2520Listones%2520Gris.png": "a5d60cfda0bc35c47f16be7237658adf",
"assets/assets/images/Ropa/faldas/Minifalda%2520Linea%2520A%2520con%2520Tablon%2520y%2520Mo%25C3%25B1os.png": "def07665c58a3d91d6fde3c3a7d2d8f7",
"assets/assets/images/Ropa/faldas/Minifalda%2520Tableada%2520Negra.png": "0568f1d269edc3ed653f38b567ffe612",
"assets/assets/images/Ropa/lenceria/Conjunto%2520de%2520Disfraz%2520de%2520Lencer%25C3%25ADa%2520de%2520Sirvienta.png": "906c1aad46e9f9537d01e7c9688c7234",
"assets/assets/images/Ropa/lenceria/Conjunto%2520de%2520Lencer%25C3%25ADa%2520Babydoll%2520con%2520Lazo%2520Recortado%2520y%2520Tanga.png": "4892642b87d44b55577e1359510872a0",
"assets/assets/images/Ropa/lenceria/Encaje%2520sin%2520Entrepierna%2520Recortado%2520con%2520Correa%2520de%2520Espagueti.png": "6b9a2ad15ec527ce9ea8847ca91476f3",
"assets/assets/images/Ropa/lenceria/Sujetador%2520con%2520Lazo%2520Frontal%2520y%2520Pantalones%2520Cortos%2520con%2520Ribete%2520de%2520Encaje.png": "6cf033cf22ab39f40a7aae3165c3919b",
"assets/assets/images/Ropa/lenceria/Sujetador%2520liso%2520sin%2520costuras%2520y%2520braga.png": "6b3947d80e1dd687be9c2e203e0ac9b4",
"assets/assets/images/Ropa/lenceria/Sujetador%2520y%2520Braga%2520sin%2520aros%2520y%2520con%2520tiras.png": "38cd6350a2b0f9aed79e533697f1256e",
"assets/assets/images/Ropa/lenceria/Top%2520Sujetador%2520Fruncido%2520con%2520Ribete%2520de%2520Encaje%2520y%2520Pantalones%2520Cortos.png": "28cf28e305f3e8e6629b717eaf40bbc8",
"assets/assets/images/Ropa/pantalones/Falda%2520Lisa%2520de%2520Tiro%2520Alto%2520con%2520Pantalones%2520Acampanados%2520Superpuestos.png": "3c40cfb07bb273d7a2699e9aa572587d",
"assets/assets/images/Ropa/pantalones/Pantalones%2520Anchos%2520de%2520Talle%2520Bajo%2520con%2520Detalle%2520de%2520Cremallera%2520y%2520Bloques%2520de%2520Color.png": "ba04dfc6ccd240b6e628643343e06df8",
"assets/assets/images/Ropa/pantalones/Pantalones%2520Cargo%2520Capri%2520de%2520Pierna%2520Ancha%2520con%2520Estampado%2520de%2520Camuflaje%2520yTtiro%2520Medio.png": "fb1b4932a23419e081b9651bbf4b4309",
"assets/assets/images/Ropa/pantalones/Pantalones%2520de%2520Ch%25C3%25A1ndal%2520Holgados%2520con%2520Cintura%2520Baja%2520y%2520Pernera%2520ancha.png": "dd2a7ecc23f3bf07f1bf620bd33d9b69",
"assets/assets/images/Ropa/pantalones/Pantalones%2520de%2520Pierna%2520Ancha.png": "f02e02898201093760bb1572c240dddf",
"assets/assets/images/Ropa/pantalones/Pantalones%2520de%2520Traje%2520Holgados%2520Lisos%2520de%2520Tiro%2520Bajo%2520y%2520Pierna%2520Ancha.png": "9b4c0362cd1eff80db7477ce06b6023f",
"assets/assets/images/Ropa/pantalones/Pantalones%2520Deportivos%2520de%2520Pierna%2520Ancha%2520en%2520Dos%2520Tonos%2520con%2520Cintura%2520con%2520Cord%25C3%25B3n.png": "89190fcb7144554e6681285454365feb",
"assets/assets/images/Ropa/pantalones/Pantalones%2520Deportivos%2520Holgados%2520de%2520Pierna%2520Ancha%2520con%2520Bordados%2520y%2520Cintura%2520Baja.png": "f35431c4b2f9c19ddf4f48d118f484ba",
"assets/assets/images/Ropa/pantalones/Pantalones%2520Lisos%2520de%2520Tiro%2520Medio%2520y%2520Pierna%2520Ancha.png": "0799d9c2198870f0cf69de9a63521d12",
"assets/assets/images/Ropa/pantalones/Vaqueros%2520Desgastados%2520de%2520Tiro%2520Bajo%2520y%2520Pierna%2520Ancha.png": "82626f3883e07fb082592912dd762d79",
"assets/assets/images/Ropa/pijamas/Camisa%2520de%2520Manga%2520Corta%2520con%2520Estampado%2520de%2520Panda%2520y%2520Pantalones%2520Cortos.png": "f8054c45fce9c6bbc5b32f7d4534dfb0",
"assets/assets/images/Ropa/pijamas/Camiseta%2520Acolchada%2520de%2520Manga%2520Corta%2520con%2520Cuello%2520Redondo%2520Estampado%2520de%2520Vaca%2520y%2520Pantal%25C3%25B3n%2520Estampado.png": "9b04c6e77fc995eb545e86ac85377dc6",
"assets/assets/images/Ropa/pijamas/Camisola%2520Corta%2520con%2520Cuello%2520de%2520Muesca%2520Lazo%2520de%2520Lunares%2520Ribete%2520de%2520Encaje%2520Chaqueta%2520y%2520Pantal%25C3%25B3n.png": "c0a50658f175c284c72c6a024f4c6582",
"assets/assets/images/Ropa/pijamas/Conjunto%2520de%2520Pijama%2520de%2520Algod%25C3%25B3n%2520de%2520Manga%2520Larga%2520y%2520Manga%2520Corta.png": "1a950c6d296bb285e8c98a2c85df7c88",
"assets/assets/images/Ropa/pijamas/Pijama%2520Set%2520Top%2520de%2520manga%2520larga%2520con%2520Cuello%2520Cuadrado%2520Lazo%2520con%2520Volantes%2520y%2520Pantal%25C3%25B3n%2520Recto.png": "666f3aea8bd5628d94876df30a78993c",
"assets/assets/images/Ropa/pijamas/Vestido%2520de%2520Dormir%2520de%2520Manga%2520Corta%2520con%2520Volantes%2520y%2520Cuello%2520de%2520Lazo.png": "2171dcc0a280567b7b5b0752ef1f7ff1",
"assets/assets/images/Ropa/shorts/Falda%2520Pantal%25C3%25B3n%2520Lisa%2520con%2520Volantes%2520y%2520Cintura%2520con%2520Cord%25C3%25B3n%2520Ajustable.png": "7c775e169b139ba0c2b8584b962b9e96",
"assets/assets/images/Ropa/shorts/Falda%2520Pantal%25C3%25B3n%2520Plisada%2520Asim%25C3%25A9trica%2520Lisa%2520con%2520Cintura%2520El%25C3%25A1stica%2520y%2520Botones%2520Delanteros.png": "2167e5cdd231071d75e292aafbcc6f51",
"assets/assets/images/Ropa/shorts/Mini%2520Shorts%2520de%2520Cintura%2520Baja%2520con%2520Cord%25C3%25B3n%2520Ajustable%2520y%2520Dobladillo%2520Abullonado.png": "031454a33b702e7314db7a8fcc833ea5",
"assets/assets/images/Ropa/shorts/Minifalda%2520Plisada%2520de%2520Cintura%2520Alta%2520Skort.png": "268f90baf8d7a3f40b4d443737b9d5a5",
"assets/assets/images/Ropa/shorts/Pantalones%2520Cortos%2520de%2520Tiro%2520Medio.png": "9b45dae596e3a2fb34c640ec28b00c92",
"assets/assets/images/Ropa/shorts/Pantalones%2520Cortos%2520Vaqueros%2520Lavados%2520de%2520Tiro%2520Bajo.png": "1d2b81ffe74ad0e21761080952598642",
"assets/assets/images/Ropa/shorts/Shorts%2520Vaqueros%2520de%2520Tiro%2520Bajo%2520con%2520Paneles%2520Lavados%2520y%2520Estampado%2520de%2520Leopardo.png": "32241f528ba46eb3b52cb1b49c6dfb6b",
"assets/assets/images/Ropa/vestidos/Minivestido%2520de%2520Tirantes%2520con%2520Estampado%2520Floral.png": "bd954d54afb962be7fee0010b6fcd572",
"assets/assets/images/Ropa/vestidos/Minivestido%2520Liso%2520con%2520Cuello%2520Halter%2520Mangas%2520de%2520Malla%2520en%2520los%2520Brazos.png": "84b0c3f6f9eb093d92af45a915019306",
"assets/assets/images/Ropa/vestidos/Vestido%2520Mangas%2520Abombadas%2520Verde%2520Mo%25C3%25B1o%2520en%2520el%2520Cuello.png": "e2072ccf42cfb91cd87141c15ea2e138",
"assets/assets/images/Ropa/vestidos/Vestido%2520Midi%2520de%2520Corte%2520A%2520con%2520Lazo%2520Liso%2520y%2520Mangas%2520Cortas.png": "c41611741062ad272e6999f56894d2d8",
"assets/assets/images/Ropa/vestidos/Vestido%2520Mini%2520de%2520Corte%2520A%2520con%2520Lazo%2520floral%2520y%2520Mangas%2520Abullonadas.png": "35c6ab717fbf8a5288aabb90e3e42e4e",
"assets/assets/images/Ropa/vestidos/Vestido%2520Mini%2520de%2520Corte%2520A%2520Entallado%2520con%2520Lunares%2520y%2520Tirantes%2520Finos.png": "3d82dc344dc4a4fb83c1fb6483b8deda",
"assets/assets/images/Ropa/vestidos/Vestido%2520Mini%2520Plisado%2520de%2520Corte%2520A%2520con%2520Mangas%2520Abullonadas%2520y%2520Detalle%2520de%2520Botones.png": "b75d659424ff9a6389cf4272a4679160",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "d66f3b817fc54e037f2866f248c75bc5",
"assets/NOTICES": "f839daba70f871355c4868f3b4c6b83c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "620787cf6ff73bfec39fcee670ec0ca7",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "888a10a224b3bccb3c05f6162096de4a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "860c7a5c4a957203c20125aba976f82a",
"/": "860c7a5c4a957203c20125aba976f82a",
"main.dart.js": "a8404983a1d276214c9e02af05c2749e",
"manifest.json": "d21be23f3b30e5145990b26b0e68ca5d",
"version.json": "0c0e2d39a5c1fcb0f0a32fdafa6aefa7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
