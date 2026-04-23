//! Structural design pattern
//! Proxy
//! Movie

// this pattern is used when you want to provide a substitute or placeholder for another object.
// the proxy controls access to the original object, allowing you to do something
// either before or after the request reaches the original object.
// in other words, you interact with the proxy as if it were the real object,
// but the proxy adds an extra layer of logic around the real operation.

// a real life example
// think of a credit card as a proxy for your bank account.
// when you pay at a store, you hand over the card — not your entire bank account.
// the card (proxy) verifies the transaction, checks funds, and then delegates
// the actual payment to the real bank account behind the scenes.

// in this example i use a movie streaming service
// we have a RealMovieService that can play movies freely.
// however, we want to restrict access based on whether the user has an active subscription.
// instead of changing the real service, we introduce MovieProxy that wraps it.
// MovieProxy checks the subscription status before delegating the play() call to RealMovieService.
// the client code only talks to MovieProxy through the shared MovieService interface,
// unaware of the access control logic happening behind the scenes.

// Differnce between it and the facade
// the facade provides a simplified interface to a complex system of classes
// the proxy provides a substitute or placeholder for another object

//! pitfalls
// 1. the response from the real service might be delayed if the proxy performs heavy checks (e.g., network calls).
// 2. adding too many responsibilities to a proxy can violate the Single Responsibility Principle.

// the subject interface that both the real service and proxy must implement
// both RealMovieService and MovieProxy must conform to this contract,
// so the client code can use either one interchangeably
abstract class MovieService {
  void play();
}

// the real object that contains the actual business logic
// it simply plays the movie without any access control
class RealMovieService extends MovieService {
  @override
  void play() {
    print('Playing movie...');
  }
}

// the proxy that controls access to RealMovieService
// it holds a reference to the real service and an extra piece of state (_hasSubscription)
// that determines whether the client is allowed to use the real service
class MovieProxy extends MovieService {
  // a reference to the real object the proxy delegates work to
  final RealMovieService _realMovieService;

  // the access-control condition — only active subscribers can play movies
  final bool _hasSubscription;

  // the proxy is constructed with both the real service and the subscription status
  MovieProxy(this._realMovieService, this._hasSubscription);

  @override
  void play() {
    // access control: check the subscription before delegating to the real service
    if (!_hasSubscription) {
      // block access and inform the client without touching the real service
      print('Your subscription is no longer active!');
    } else {
      // subscription is valid — delegate the actual work to the real service
      _realMovieService.play();
    }
  }
}

void main() {
  // create the real service object
  RealMovieService realMovieService = RealMovieService();

  // simulate a user without an active subscription
  bool hasSubscription = false;

  // the client only interacts with the proxy, not the real service directly
  MovieProxy movieProxy = MovieProxy(realMovieService, hasSubscription);

  // the proxy intercepts the call and blocks it due to missing subscription
  movieProxy.play();
}
