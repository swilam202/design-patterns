//! Behavioral design pattern
//! interpreter
//! calculator

// the interpreter pattern is used parse raw data into meaningful data
// its made of 2 main parts
// 1. terminal expression
// 2. non-terminal expression

// in this example i have a simple calculator which can parse raw data
// like '2 + 3' and interpret it into a number
// the pattern is used to evaluate expressions
// it is used in natural language processing, regex, sql parsers

// it has the context which is the raw data
// it has the expression interface for each operation
// it has the terminal expression which is the number expression
// it has the non-terminal expression which is the sum and subtract expressions

// it takes the the raw data and make it as tokens with the tokenizer function
// then it parse the tokens etc(2, +, 3) and make it as expressions objects
// then it interpret the expressions and make it as a number

//! pitfalls
// 1. Each grammar rule usually requires a separate class.
// 2. Poor Performance for Complex Languages

// the expression interface
abstract class Expression {
  // interpret the expression means return the value of the expression
  double interpret();
}

// the terminal expression
class NumberExpression implements Expression {
  // the number which is the value of the expression
  String number;
  NumberExpression(this.number);

  // because its terminal expression it just return its value
  @override
  double interpret() {
    return double.parse(number);
  }
}

// the non-terminal expression
class SumExpression implements Expression {
  // the left and right expressions
  // which are the 2 numbers or expressions to be added
  Expression left;
  Expression right;

  SumExpression(this.left, this.right);

  // here is how the sum expression handles the 2 values
  // it calls the interpret method on the left and right expressions
  // and returns the sum of the two values
  @override
  double interpret() {
    return left.interpret() + right.interpret();
  }
}

// the non-terminal expression
class SubtractExpression implements Expression {
  // the left and right expressions
  // which are the 2 numbers or expressions to be subtracted
  Expression left;
  Expression right;

  SubtractExpression(this.left, this.right);

  // here is how the subtract expression handles the 2 values
  // it calls the interpret method on the left and right expressions
  // and returns the difference of the two values
  @override
  double interpret() {
    return left.interpret() - right.interpret();
  }
}

// the tokenizer function which splits the context by space into tokens etc(2, +, 3)
List<String> tokenizer(String context) => context.split(' ');

// the parse function which parses the context into executable expression
Expression parse(String context) {
  // the list of tokens obtained form the tokenizer function
  List<String> tokens = tokenizer(context);

  // initially give the current expression the first token as a number expression
  Expression current = NumberExpression(tokens[0]);

  // we start from the second token
  // because the first token is already a number expression in the current expression
  int i = 1;

  // we loop until we reach the end of the tokens

  while (i < tokens.length) {
    // we have 3 tokens in this example (2, +, 3)
    // we have already took the first token (2) in the current
    // so the operator takes the second token which is the operator (+)

    String operator = tokens[i];
    // and the next number which is the third token (3)

    String nextNumber = tokens[i + 1];

    // note that there is rules for this calculator here
    // 1. the first token is always a number
    // 2. the operator is always the second token
    // 3. the next number is always the third token
    // 4. the operator is always followed by a number
    // 5. the number is always followed by an operator
    // 6. the number is always followed by an operator

    // so we know for sure that every operator has a number before it
    // and a number after it
    // so we can take the operator and the next number
    // and make it as an expression
    // and then add it to the current expression
    // and then move to the next operator
    // and so on

    // here we check the operator and make it as an expression

    switch (operator) {
      // here we override the current expression (which held the value of 2 )
      // with the new expression
      // which is the sum of the (current expression) and the next number expression
      case '+':
        current = SumExpression(current, NumberExpression(nextNumber));

      case '-':
        current = SubtractExpression(current, NumberExpression(nextNumber));
    }
    // and every time we increment i by 2
    // because we took the operator and the next number

    i += 2;
  }

  // think of it as recursive function
  // we store each token inside expression
  // one by one you get an expression made of other expressions
  // until you get the final expression
  // which is the sum of all the expressions

  return current;
}

void main() {
  // the context which is the raw data
  String context = '2 + 3';

  // parse the context into executable expression
  Expression result = parse(context);

  // execute the expression to see the result
  print('$context = ${result.interpret()}');
}
