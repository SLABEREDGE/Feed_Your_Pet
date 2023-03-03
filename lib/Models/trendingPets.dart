import 'package:flutter/material.dart';

class Trending {
  late final String image, name , description;

  Trending({required this.image , required this.name , required this.description, } );

}

List<Trending> trending = [
  Trending(image : "assets/pets/cats/catHome.png" , name : "Cat", description : "Cute & small"),
  Trending(image : "assets/pets/dogs/dogHome.png", name :"Dog", description : "Loyal to owners"),
  Trending(image : "assets/pets/rabbits/rabbitHome.png", name :"Rabbit", description :"Cute & shy"),
  Trending(image : "assets/pets/tortoise/tortoiseHome.png", name :"Tortoise", description :"Slow"),
  Trending(image : "assets/pets/bird.png", name :"Birds", description :"small but noisy"),
  Trending(image : "assets/pets/snake.png", name :"Snakes", description :"sometimes scary"),
  Trending(image : "assets/pets/fish.png", name :"Fish", description :"hard to manage"),
];

class Pets {
  late final String type,image, description,difficulty,life,color,height,weight,origin,temperament;

  Pets({required this.image, required this.type, required this.description, required this.difficulty, required this.life,required this.height,required this.color, required this.temperament,required this.weight,required this.origin});

}
List<Pets> dogs = [
  Pets(
      image : "assets/pets/dogs/BassetHound1.png",
      type : "Basset Hound",
      description : "The Basset Hound is a short-legged breed of dog in the hound family. The Basset is a scent hound that was originally bred for the purpose of hunting hare. Their sense of smell and ability to ground-scent is second only to the Bloodhound. Basset Hounds are one of six recognized 'basset'-type breeds in France.",
      height : "Female: 28–36 cm, Male: 30–38 cm",
      difficulty: '5 5 5',
      life: '10 – 12 years',
      color: 'Black & Brown, Lemon & White, Black & White, Tri-color, White & Chocolate, Red & White',
      temperament: 'Sweet-Tempered, Tenacious, Devoted, Friendly, Affectionate, Gentle',
      weight: 'Female: 20–29 kg, Male: 25–34 kg',
      origin: 'France, Great Britain'
  ),
  Pets(
      image : "assets/pets/dogs/Bulldog1.png",
      type :"Bulldog",
      height : "Female: 31–40 cm, Male: 31–40 cm",
      difficulty: '1 1 1 1',
      life: '8 – 10 years',
      origin: 'United Kingdom, England',
      color: 'White, Fawn, Piebald, Fawn & White, Brindle & White, Red & White, Red Brindle, Red',
      temperament: 'Willful, Docile, Friendly, Gregarious',
      weight: 'Female: 18–23 kg, Male: 23–25 kg',
      description : "The Bulldog is a British breed of dog of mastiff type. It may also be known as the English Bulldog or British Bulldog. It is a medium sized, muscular dog of around 40–55 lb. They have large heads with a thick folds of skin around the face and shoulders, and a relatively flat face with a protruding lower jaw."),
  Pets(
      image : "assets/pets/dogs/GermanShepherd.png",
      type :"German Shepherd",
      height : "Height: Male: 60–65 cm, Female: 55–60 cm",
      difficulty: '1 1 1 1 1',
      life: '9 – 13 years',
      origin: 'Germany',
      color: 'Black, White, Black & Tan, Black & Silver, Sable, Red & Black, Grey',
      temperament: 'Stubborn, Intelligent, Curious, Loyal, Alert, Confident, Obedient, Protective, Watchful, Courageous, Brave',
      weight: 'Male: 30–40 kg, Female: 22–32 kg',
      description :"SThe German Shepherd or Alsatian is a German breed of working dog of medium to large size. The breed was developed by Max von Stephanitz using various traditional German herding dogs from 1899. It was originally bred as a herding dog, for herding sheep."),
  Pets(
      image : "assets/pets/dogs/GoldenRetriever1.png",
      type :"Golden Retriever",
      height : "Female: 51–56 cm, Male: 56–61 cm",
      difficulty: '1 1 1 1',
      life: '10 – 12 years',
      origin: 'United Kingdom, England, Scotland',
      color: 'Dark Golden, Light Golden, Cream, Golden',
      temperament: 'Intelligent, Kind, Friendly, Reliable, Trustworthy, Confident',
      weight: 'Female: 25–32 kg, Male: 30–34 kg',
      description :"The Golden Retriever is a Scottish breed of retriever dog of medium size. It is characterised by a gentle and affectionate nature and a striking golden coat. It is commonly kept as a pet and is among the most frequently registered breeds in several Western countries."),
  Pets(
      image : "assets/pets/dogs/havanese1.png",
      type :"Havanese",
      height : "23 – 27 cm (Adult, At the withers)",
      difficulty: '3 3',
      life: '14 – 16 years',
      origin: 'Origin: Cuba',
      color: 'Black, White, Havana Brown, Mahogany, Fawn, Tobacco',
      temperament: 'Playful, Affectionate, Intelligent, Companionable, Responsive, Gentle',
      weight: 'Weight: 4.5 – 7.3 kg',
      description :"The Havanese, a bichon-type dog, is the national dog of Cuba, developed from the now extinct Blanquito de la Habana. The Blanquito descended from the also now-extinct Bichón Tenerife"),
  Pets(
      image : "assets/pets/dogs/Labrador1.png",
      type :"Labrador",
      height : "Male: 57–62 cm, Female: 55–60 cm",
      difficulty: '3 3 3',
      life: '10 – 12 years',
      origin: 'Newfoundland',
      color: 'Black, Chocolate, Yellow',
      temperament: 'Temperament: Intelligent, Even Tempered, Kind, Outgoing, Agile, Trusting, Gentle',
      weight: 'Male: 29–36 kg, Female: 25–32 kg',
      description :"The Labrador Retriever or simply Labrador is a British breed of retriever gun dog. It was developed in the United Kingdom from fishing dogs imported from the colony of Newfoundland, and was named after the Labrador region of that colony."),
  Pets(
      image : "assets/pets/dogs/PembrokeWelshCorgi1.png",
      type :"Pembroke Welsh Corgi",
      height : "Male: 25–30 cm, Female: 25–30 cm",
      difficulty: '3 3',
      life: '12 – 15 years',
      origin: 'Pembrokeshire',
      color: 'Fawn, Black & Tan, Black & White, Sable, Red',
      temperament: 'Tenacious, Friendly, Bold, Outgoing, Protective, Playful',
      weight: 'Male: 10–14 kg, Female: 10–13 kg',
      description :"The Pembroke Welsh Corgi is a cattle herding dog breed that originated in Pembrokeshire, Wales. It is one of two breeds known as a Welsh Corgi. Pembroke Welsh Corgis descended from the Spitz family of dogs."),
  Pets(
      image : "assets/pets/dogs/Poodle1.png",
      type :"Poodle",
      height : "Toy Poodle: 24 – 28 cm, Miniature Poodle: 28 – 35 cm, Standard Poodle: 45 – 60 cm, Medium Poodle: 35 – 45 cm",
      difficulty: '1',
      life: '12 – 15 years',
      origin: 'France, Germany',
      color: 'Black, White, Apricot, Cream, Black & White, Sable, Brown, Blue, Silver, Grey, Red',
      temperament: 'Intelligent, Alert, Active, Instinctual, Faithful, Trainable',
      weight: 'an adult male Poodle is 60 to 70 pounds while an adult female Poodle weighs between 40 and 50 pounds.',
      description :"The Poodle, called the Pudel in German and the Caniche in French, is a breed of water dog. The breed is divided into four varieties based on size, the Standard Poodle, Medium Poodle, Miniature Poodle and Toy Poodle, although the Medium Poodle is not universally recognised"),
  Pets(
      image : "assets/pets/dogs/Rottweiler1.png",
      type :"Rottweiler",
      height : "Female: 56–63 cm, Male: 61–69 cm",
      difficulty: '3 3 3',
      life: '8 – 10 years',
      origin: 'Germany',
      color: 'Black, Mahogany, Tan',
      temperament: 'calm and confident, courageous but not unduly aggressive',
      weight: 'Female: 35–48 kg, Male: 50–60 kg',
      description :"The Rottweiler is a breed of domestic dog, regarded as medium-to-large or large. The dogs were known in German as Rottweiler Metzgerhund, meaning Rottweil butchers' dogs, because their main use was to herd livestock and pull carts laden with butchered meat to market"),
  Pets(
      image : "assets/pets/dogs/ShibaInu1.png",
      type :"Shiba Inu",
      height : "Male: 35–43 cm, Female: 33–41 cm",
      difficulty: '1 3 4 ',
      life: '12 – 15 years',
      origin: 'Japan',
      color: 'Red Sesame, Black Sesame, Black & Tan, Cream, Sesame, Red',
      temperament: 'Charming, Keen, Alert, Confident, Fearless, Faithful',
      weight: 'Male: 8–11 kg, Female: 6.8–9 kg',
      description :"The Shiba Inu is a breed of hunting dog from Japan. A small-to-medium breed, it is the smallest of the six original and distinct spitz breeds of dog native to Japan. Its name literally translates to 'brushwood dog', as it is used to flush game"),
  Pets(
      image : "assets/pets/dogs/ShihTzu1.png",
      type :"Shih Tzu",
      height : "Female: 20 – 28 cm , Male: 20 – 28 cm ",
      difficulty: '3 4 5',
      life: 'Life expectancy: 10 – 16 years',
      origin: 'China, Tibet',
      color: 'Black, White, Brindle, Liver & White, Light Brown, Liver, Dark Brown, Black & White, Blue, Gold',
      temperament: 'Playful, Clever, Intelligent, Lively, Friendly, MORE',
      weight: 'Female : 4 – 7.2 kg, Male :4 – 7.2 kg',
      description :"The Shih Tzu is a toy dog breed originating from Tibet and was bred from the Pekingese and the Lhasa Apso. Shih Tzus are known for their short snouts and large round eyes, as well as their long coat, floppy ears, and short and stout posture"),
  Pets(
      image : "assets/pets/dogs/SiberianHusky1.png",
      type :"Siberian Husky",
      height : "Female: 51–56 cm, Male: 53–60 cm",
      difficulty: '4 5 5 5 5',
      life: '12 – 15 years',
      origin: 'Siberia',
      color: 'White, Black, Black & Tan, Silver-gray, Gray & White, Black & White, Sable & White, Red & White, Grey',
      temperament: 'Intelligent, Friendly, Outgoing, Alert, Gentle',
      weight: 'Female: 16–23 kg, Male: 20–27 kg',
      description :"The Siberian Husky is a medium-sized working sled dog breed. The breed belongs to the Spitz genetic family. It is recognizable by its thickly furred double coat, erect triangular ears, and distinctive markings, and is smaller than the similar-looking Alaskan Malamute."),
  Pets(
      image : "assets/pets/dogs/St.Bernard1.png",
      type :"St. Bernard",
      height : "Height: Male: 70–90 cm, Female: 65–80 cm",
      difficulty: '4 2 3',
      life: 'Life expectancy: 8 – 10 years',
      origin: 'Origin: Switzerland',
      color: 'Colors: Brownish-yellow, Red & White, Reddish-brown Brindle, Reddish-brown Splash, Reddish-brown Mantle',
      temperament: 'Temperament: Lively, Friendly, Gentle, Watchful, Calm',
      weight: 'Male: 64 – 82 kg, Female: 54 – 64 kg',
      description :"The St. Bernard or Saint Bernard is a breed of very large working dog from the Western Alps in Italy and Switzerland. They were originally bred for rescue work by the hospice of the Great St Bernard Pass on the Italian-Swiss border"),
];

List<Pets> cats = [
  Pets(
      type: 'American Shorthair',
      image: 'assets/pets/cats/AmericanShorthair.png',
      color: 'white, blue, black, cream, red, silver, golden, cameo',
      height: '14 inches',
      weight: 'Males are usually larger than females, averaging 11 to 15 pounds, while females may weigh 6 to 12 pounds.',
      temperament: 'friendly, playful, and accepting of other pets and people',
      life: 'Around 15 years',
      origin: 'Origin: Europe, North America',
      description: 'The American Shorthair is a breed of domestic cat believed to be descended from European cats brought to North America by early settlers to protect valuable cargo from mice and rats. According to the Cat Fanciers\' Association, in 2020, it was the eighth most popular pedigreed cat in the world',
      difficulty: '2 3 4'
  ),
  Pets(
      type: 'Birman',
      image: 'assets/pets/cats/Birman.png',
      color: 'white, blue, black, cream, red, silver, golden, cameo',
      height: '14 inches',
      weight: 'Female: 3.2 to 5.4 kg, Male: 4.1 to 7.7 kg',
      temperament: 'affectionate, friendly, gentle, and curious',
      life: 'Around 15 years',
      origin: 'Myanmar (Burma), France',
      description: 'The Birman, also called the "Sacred Cat of Burma", is a domestic cat breed. The Birman is a long-haired, colour-pointed cat distinguished by a silky coat, deep blue eyes, and contrasting white "gloves" on each paw. The breed name is derived from Birmanie, the French form of Burma.',
      difficulty: '1 2'
  ),
  Pets(
      type: 'British Longhair',
      image: 'assets/pets/cats/BritishLonghair.png',
      color: 'white, blue, black, cream, red, silver, golden, cameo',
      height: '14 inches',
      weight: 'Female: 3.2 to 5.4 kg, Male: 4.1 to 7.7 kg',
      temperament: ' mild, calm demeanor and tolerant attitude',
      life: '3 3 3',
      origin: 'Great Britain',
      description: 'The British Longhair is a medium-sized, semi-long-haired breed of domestic cat, originating in Great Britain.',
      difficulty: '1 2'
  ),
  Pets(
      type: 'British Shorthair',
      image: 'assets/pets/cats/BritishShorthair.png',
      color: 'white black,ebony: red,orange, blue,gray cream, beige,tan chocolate,brown,sable cinnamon fawn lilac',
      height: '14 inches',
      weight: 'Female: 3.2 to 5.4 kg, Male: 4.1 to 7.7 kg',
      temperament: '4 4 4 4 4',
      life: '14 to 20 years',
      origin: 'Great Britain',
      description: 'The British Shorthair is the pedigreed version of the traditional British domestic cat, with a distinctively stocky body, dense coat, and broad face. The most familiar colour variant is the "British Blue", with a solid grey-blue coat, orange eyes, and a medium-sized tail.',
      difficulty: '4 5 3'
  ),
  Pets(
      type: 'Chartreux',
      image: 'assets/pets/cats/Chartreux.png',
      color: 'white, blue, black, cream, red, silver, golden, cameo',
      height: '14 inches',
      weight: 'Male: 5.9 – 8.2 kg, Female: 3.6 – 5.4 kg',
      temperament: 'sweet and gentle personality, quiet, calm and friendly, and are affectionate without being demanding',
      life: '12–16 years',
      origin: 'France, Syria',
      description: 'The Chartreux is a rare breed of cat from France, and is recognised by a number of registries around the world. The Chartreux is large and muscular with relatively short, fine-boned limbs, and very fast reflexes.',
      difficulty: '4 4 4 4'
  ),
  Pets(
      type: 'Exotic Shorthair',
      image: 'assets/pets/cats/ExoticShorthair.png',
      color: 'white, blue, black, red, and lilac',
      height: '14 inches',
      weight: 'Male: 5.9 – 8.2 kg, Female: 3.6 – 5.4 kg',
      temperament: 'friendly, playful, and accepting of other pets and people',
      life: '12–16 years',
      origin: 'United States',
      description: 'The Exotic Shorthair is a breed of cat developed as a short-haired version of the Persian. The Exotic is similar to the Persian in many ways, including temperament and conformation, a flat nose and face with the exceptions of the short dense coat.',
      difficulty: '3 4 4 5'
  ),
  Pets(
      type: 'Himalayan cat',
      image: 'assets/pets/cats/Himalayancat.png',
      color: 'white or cream, but the points come in many different colors: Seal (or Black), Blue, Lilac, Chocolate, Red (Flame), and Cream.',
      height: '14 inches',
      weight: 'Female : 4 to 6kg, Male: 5 to 8kg',
      temperament: 'Himalayans are remarkably pleasant. They are smart, affectionate, and devoted.',
      life: '12–16 years',
      origin: 'Iran, United States, Thailand',
      description: 'The Himalayan, is a breed or sub-breed of long-haired cat similar in type to the Persian, with the exception of its blue eyes and its point colouration, which were derived from crossing the Persian with the Siamese.',
      difficulty: '1 1'
  ),
  Pets(
      type: 'Korat',
      image: 'assets/pets/cats/Korat.png',
      color: 'hite, blue, black, red, and lilac',
      height: '20 – 25 cm',
      weight: '',
      temperament: 'A deeply intelligent cat, the Korat is also a very thoughtful family member.',
      life: '12–16 years',
      origin: 'Thailand',
      description: 'The Korat cat is a silver-tipped blue-grey, short-haired breed of domestic cat with a small to medium build and a low percentage of body fat. Its body is semi-cobby, and unusually heavy for its size.',
      difficulty: '1 '
  ),
  Pets(
      type: 'Maine Coon',
      image: 'assets/pets/cats/MaineCoon.png',
      color: 'Maine coons come in a variety of colors and patterns. You can find solid white, cream, red, blue, and black Maine coons, as well as tabby, bi-color, particolor, tortoiseshell, shaded, and calico Maine coons',
      height: '48 – 100 cm',
      weight: 'Male: 5.9 – 8.2 kg, Female: 3.6 – 5.4 kg',
      temperament: 'friendly, playful, and accepting of other pets and people',
      life: '12–16 years',
      origin: 'Maine, United States',
      description: 'The Maine Coon is a large domesticated cat breed. It is one of the oldest natural breeds in North America. The breed originated in the U.S. state of Maine, where it is the official state cat.',
      difficulty: '4 5 6 7 6'
  ),
  Pets(
      type: 'Manx Cat',
      image: 'assets/pets/cats/ManxCat.png',
      color: 'hite, blue, black, red, and lilac',
      height: '20 – 25 cm',
      weight: 'Manx cats typically weigh 8-14 pounds',
      temperament: 'social and gregarious cat, and very attached to humans, but also shy of strangers',
      life: '12–16 years',
      origin: 'Isle of Man',
      description: 'The Manx cat is a breed of domestic cat originating on the Isle of Man, with a naturally occurring mutation that shortens the tail.',
      difficulty: '2 2 2'
  ),
  Pets(
      type: 'Persian cat',
      image: 'assets/pets/cats/Persian.png',
      color: 'hite, blue, black, red, and lilac',
      height: '48 – 100 cm',
      weight: 'Female: 10 and 15 pounds, Male : Around 20 pounds',
      temperament: 'friendly, playful, and accepting of other pets and people',
      life: '12 – 17 years',
      origin: 'Iran',
      description: 'The Persian cat, also known as the Persian longhair, is a long-haired breed of cat characterized by a round face and short muzzle. The first documented ancestors of Persian cats were imported into Italy from Persia around 1620.',
      difficulty: '3 4 5 6'
  ),
  Pets(
      type: 'Ragamuffin cat',
      image: 'assets/pets/cats/Ragamuffincat.png',
      color: 'white, blue, black, cream, red, silver, golden, cameo',
      height: '10–15 inches',
      weight: 'Female: 10 and 15 pounds, Male : Around 20 pounds',
      temperament: 'affectionate',
      life: '12–16 years',
      origin: 'California',
      description: 'The Ragamuffin is a breed of domestic cat. It was once considered to be a variant of the Ragdoll cat but was established as a separate breed in 1994. Ragamuffins are notable for their friendly personalities and thick fur. ',
      difficulty: '4 5'
  ),
  Pets(
      type: 'Siamese cat',
      image: 'assets/pets/cats/Siamesecat.png',
      color: 'hite, blue, black, red, and lilac',
      height: '14 inches',
      weight: 'Females: 8 to 12 pounds, Male: 11 to 15 pounds',
      temperament: 'Siamese Cats are highly intelligent, talkative and sociable. They have a deep, loud voice and enjoy “chatting” with their owners.',
      life: '12–16 years',
      origin: 'Thailand',
      description: 'The Siamese cat is one of the first distinctly recognized breeds of Asian cat. Derived from the Wichianmat landrace, one of several varieties of cat native to Thailand, the original Siamese became one of the most popular breeds in Europe and North America in the 19th century.',
      difficulty: '4 2 1'
  ),
  Pets(
      type: 'Siberian cat',
      image: 'assets/pets/cats/Siberiancat.png',
      color: 'white, blue, black, cream, red, silver, golden, cameo',
      height: '17 to 25 inches long',
      weight: 'an average of 15 to 20 pounds.',
      temperament: 'Siberian cats have gentle, loving nature and well rounded personality. They adore children, readily accept the other household pets and get along great with the whole family',
      life: '12–16 years',
      origin: 'Russia',
      description: 'The Siberian is a centuries-old landrace of domestic cat in Russia and recently developed as a formal breed with standards promulgated the world over since the late 1980s. The formal name of the breed is Siberian Forest Cat, but it is typically referred to as the Siberian or Siberian cat. ',
      difficulty: '1 3 4 5 6'
  ),
  Pets(
      type: 'Somali cat',
      image: 'assets/pets/cats/Somalicat.png',
      color: 'ruddy, red, blue, and fawn',
      height: '20 – 25 cm',
      weight: '6–10 pounds',
      temperament: 'active, playful,social,enjoys interacting with people and other cats.',
      life: '12–16 years',
      origin: 'United States',
      description: 'The Somali cat is genetically similar to the Abyssinian. Due to inheriting 2 copies of the recessive gene for long hair, they have a characteristic luscious coat, unlike their cousin, the Abyssinian cat. ',
      difficulty: '1 3'
  ),
];


class Birds {
  late final String type, size, description;

  Birds({required this.type, required this.size, required this.description});

}
List<Trending> birds = [
  Trending(image : "assets/pets/cats/catHome.png" , name : "Cat", description : "Small And easy to manage"),
  Trending(image : "assets/pets/dogs/dogHome.png", name :"Dog", description : "Small And easy to manage"),
  Trending(image : "assets/pets/rabbits/rabbitHome.png", name :"Rabbit", description :"Small And easy to manage"),
  Trending(image : "assets/pets/tortoise/tortoiseHome.png", name :"Tortoise", description :"Small And easy to manage"),
];

class Fish {
  late final String type, size, description;

  Fish({required this.type, required this.size, required this.description});

}
List<Trending> fish = [
  Trending(image : "assets/pets/cats/catHome.png" , name : "Cat", description : "Small And easy to manage"),
  Trending(image : "assets/pets/dogs/dogHome.png", name :"Dog", description : "Small And easy to manage"),
  Trending(image : "assets/pets/rabbits/rabbitHome.png", name :"Rabbit", description :"Small And easy to manage"),
  Trending(image : "assets/pets/tortoise/tortoiseHome.png", name :"Tortoise", description :"Small And easy to manage"),
];

class Tips {
  late final String tips;

  Tips({required this.tips});
}

List<Tips> tips =[
  Tips(tips: "Wow that food was Great !!"),
  Tips(tips: "Delicious!!"),
  Tips(tips: "That taste\'s Great !!"),
  Tips(tips: "Wow, this food is amazing !!"),
  Tips(tips: "Yummy !!"),
  Tips(tips: "Mouth-watering !!"),
  Tips(tips: "Flavorful !!"),
  Tips(tips: "Yuck !!"),
  Tips(tips: "It could use a little Spicy !!"),
  Tips(tips: "You call that food ?"),
];
