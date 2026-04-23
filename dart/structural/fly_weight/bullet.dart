//! Structural design pattern
//! Flyweight
//! Bullet

// this pattern is used when you need to create a very large number of similar objects
// that would otherwise consume a huge amount of memory.
// the idea is to share the common, repeating state (intrinsic state) among multiple objects
// instead of storing it separately in each one.
// each object only keeps the state that is unique to it (extrinsic state).

// a real life example
// think of characters in a word processor like Microsoft Word.
// the letter 'A' might appear thousands of times in a document,
// but the font, size, and style data for 'A' is stored only once and shared.
// each occurrence of 'A' only keeps its position on the page (the unique/extrinsic state).

// in this example i use a bullet system in a shooting game
// in a game, thousands of bullets can be fired at the same time.
// each bullet has a unique position (x, y) on screen — that is the extrinsic state.
// but all bullets of the same type share the same size, damage, and speed — that is the intrinsic state.
// instead of storing size, damage, and speed in every single Bullet object,
// we extract that shared data into a BulletType object (the flyweight).
// the BulletFactory ensures that each unique BulletType is created only once and reused,
// so thousands of bullets share a handful of BulletType objects instead of duplicating data.

//! pitfalls
// 1. the pattern introduces complexity: you must carefully separate intrinsic from extrinsic state.
// 2. if most objects are unique, the pattern provides no benefit and only adds overhead.

// the flyweight object — holds only the shared (intrinsic) state
// size, damage, and speed are the same for all bullets of the same type,
// so they are stored here once and shared across many Bullet instances
class BulletType {
  // intrinsic state: shared across all bullets of this type
  final String size;
  final double damage;
  final String speed;

  BulletType(this.size, this.damage, this.speed);
}

// the context object — holds the unique (extrinsic) state per bullet instance
// x and y are the position on screen, which differ for every bullet
// it references a shared BulletType instead of duplicating its data
class Bullet {
  // extrinsic state: unique to each individual bullet
  final int x;
  final int y;

  // reference to the shared flyweight object
  final BulletType type;

  Bullet(this.x, this.y, this.type);

  // renders the bullet using both its own position and the shared type data
  void render() {
    print(
      'Bullet at ($x,$y) with size ${type.size}, damage ${type.damage}, speed ${type.speed}',
    );
  }
}

// the flyweight factory — responsible for creating and caching BulletType objects
// it ensures each unique combination of size, damage, and speed is only created once
class BulletFactory {
  // the cache that stores already-created BulletType objects, keyed by their combined properties
  static Map<String, BulletType> _types = {};

  // returns an existing BulletType from the cache if it already exists,
  // otherwise creates a new one, stores it, and then returns it
  static BulletType getBulletType(String size, double damage, String speed) {
    // build a unique key from the combination of all intrinsic properties
    final String key = '$size-$damage-$speed';

    if (_types.containsKey(key)) {
      // reuse the existing flyweight — no new object is created
      return _types[key]!;
    } else {
      // first time this type is requested — create, cache, and return it
      return _types[key] = BulletType(size, damage, speed);
    }
  }
}

void main() {
  // use the factory to get shared BulletType flyweights
  // pistolBullet and rifleBullet will each be created only once
  final pistolBullet = BulletFactory.getBulletType('5.56×45mm', 20, '80 KM/H');
  final rifleBullet = BulletFactory.getBulletType('7.62×39mm', 60, '120 KM/H');

  // create many Bullet instances — each only stores its unique position (x, y)
  // and a reference to a shared BulletType, not a copy of it
  List<Bullet> bullets = [
    Bullet(1, 2, pistolBullet),
    Bullet(3, 4, rifleBullet),
    Bullet(5, 6, pistolBullet), // reuses the same pistolBullet flyweight
    Bullet(7, 8, rifleBullet), // reuses the same rifleBullet flyweight
  ];

  // render all bullets — each combines its own position with the shared type data
  for (var bullet in bullets) {
    bullet.render();
  }
}
