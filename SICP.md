# Notas destacadas y ejercicios de "Estructura e Interpretación de Programas de Ordenador"

## Construyendo Abstracciones con Procedimientos
Un proceso computacional es como la magia de un hechicero, no es tangible, pero realiza un trabajo intelectual.

Lisp fue inventado a finales de los 50s para razonar sobre el uso de las ecuaciones recursivas. Fue evolucionando hasta convertirse en una familia de dialectos.

### Los Elementos de la Programación
Cada lenguaje de programación tiene tres mecanismos para lograr ideas complejas a partir de ideas simples:
- Expresiones primitivas.
- Medios de combinación.
- Medios de abstracción.

En la programación tratamos con dos tipos de elementos: *procedimientos* y *datos*.

#### Expresiones
Un tipo de expresión primitiva es un número, como `486`. Si se introduce `486` como expresión en Lisp, el intérprete responderá imprimiendo:

```scheme
486
```

Las expresiones que representan números (como la anterior) pueden ser combinadas con otras expresiones que representen procedimientos (como `+` o `*`) para formar expresiones compuestas que representan la aplicación del procedimiento a esos números:

```scheme
(+ 137 349)
```

```
> 486
```

```scheme
(/ 30 2)
```

```
> 15
```

Esta notación de indicar el operador a la izquierda de los operandos se llama *notación prefija* o notación polaca. Una de sus ventajas es que puede tomar un número arbitrario de argumentos:
```scheme
(- 34 21 4)
```

```
> 9
```

Otra ventaja es que se pueden anidar las combinaciones, y en principio no hay ningún límite sobre la profundidad del anidamiento:

```scheme
(+ (* 3 (- 11 6)) (- 10 6))
```

```
> 19
```

Podemos escribir las expresiones siguiendo uan convención de formato llamada *pretty-printing*, lo que nos facilita a las personas leer mejor la expresión:

```scheme
(+ (* 3
      (- 11 6))
   (- 10 6))
```

El intérprete siempre opera siguiendo un ciclo: *lee* una expresión desde la terminal, evalúa esa expresión e imprime su resultado. Este ciclo se denomina *bucle Lectura-Evaluación-Impresión*, o *REPL* en inglés (Read-Eval-Print-Loop).

#### Nombramiento y Entorno
Un aspecto crítico de un lenguaje de programación son los medios que provee para usar nombres para referirse a objetos computacionales. En Scheme nombramos objetos mediante `define`.

```scheme
(define size 2)
size
```

```
> 2
```

También podemos usar expresiones compuestas:

```scheme
(define var (+ 2 3 (* 9 3)))
var
```

```
> 32
```

Los objetos computacionales suelen tener estructuras muy complejas, y sería inconveniente recordar y repetir todos sus detalles cada vez que los utilizamos. Estos objetos son construídos, paso a paso, mediante otros objetos de complejidad incremental.

Para poder recuperar los valores que guardamos, el intérprete guarda los pares nombre-objeto en un *entorno*.

#### Evaluando Combinaciones
El intérprete sigue el siguiente procedimiento para evaluar una combinación:

1. Evaluar las subexpresiones de la combinación.
2. Aplicar el procedimiento correspondiente del operador (el elemento más a la izquierda) a los operandos (los argumentos).


Esta regla de evaluación no maneja definiciones. Por ejemplo, la evaluación de `(define x 3)` no aplica `define` a dos argumentos, ya que el propósito de `define` es asociar el símbolo `x` con el valor `3`, por lo que esa expresión no es una combinación. Este tipo de excepciones son llamadas *formas especiales*. Cada forma especial tiene su propia regla de evaluación.

#### Procedimientos Compuestos
Los procedimientos compuestos son una poderosa técnica de abstracción por la cual a una operación compuesta se le atribuye un nombre y luego ser referida como una unidad.

La forma general de definir un procedimiento es:

```scheme
(define (<name> <formal parameters>)
    <body>)
```

#### El Modelo de Sustitución para la Aplicación de Procedimientos
Para aplicar un procedimiento compuesto a los argumentos, se evalúa el cuerpo del procedimiento con cada parámetro formal reemplazado por su correspondiente argumento. Por ejemplo, si tenemos una función `(define (square x) (* x x))`, la siguiente expresión sería evaluada de la forma que se muestra a continuación:

```scheme
(square (+ 2 4))
(square 6)
(* 6 6)
36
```

##### Orden aplicativo y orden normal
Existe un método alternativo de evaluación que consiste en sustituir las expresiones de los operandos por parámetros hasta que sea obtenida una expresión compuesta solamente por operadores primitivos, por ejemplo:

```scheme
(square (* 2 5))
(* (* 2 5) (* 2 5))
(* 10 10)
100
```

Este método recibe el nombre de *evaluación de orden normal*. El método visto en el anterior apartado se llama *evaluación de orden aplicativo*.

#### Expresiones condicionales y predicados

Para analizar casos, existe una forma especial en Lisp, llamada `cond`, que nos permite crear procedimientos más poderosos, y se usa de la siguiente manera:

```scheme
(define (abs x)
    (cond ((> x 0) x)
          ((= x 0) 0)
          ((< x 0) (- x))))
```

La forma general de una expresión condicional es:

```scheme
(cond (<p1> <e1>)
      (<p2> <e2>)
      ...
      (<pn> <en>))
```

`<pn>` es un predicado, que se evalúa como verdadero o falso.

Las expresiones condicionales son evaluadas de la siguiente manera: `<p1>` es evaluado primero. Si su valor es falso, se evalúa `<p2>`. Si es falso, se evalúa `<p3>`, y así sucesivamente.

`>`, `<` y `=` son predicados primitivos, que prueban si el primero número es mayor, menor o igual al segundo respectivamente, devolviendo en consecuencia verdadero (`#t` o `true`) o falso (`#f` o `false`).

Existe un símbolo especial, `else`, que se usa en el lugar de una `<p>` en la cláusula final de una condición. Esto causa que `cond` devuelva el valor de la `<e>` de la cláusula final. Además, se podría usar una expresión que fuese evaluada a `true` en vez de `else`.

```scheme
(define (abs x)
    (cond ((< x 0) (-x))
          (else x)))
```

Otra forma de escribirlo es usando `if`:

```scheme

(define (abs x)
    (if (< x 0)
        (- x)
        x))
```

La forma de `if` es `(if <predicado> <consecuente> <alternativa>)`. El intérprete evalúa primero `<predicado>`. Si es evaluado a `true`, entonces se evalúa `<consecuente>` y se devuelve su valor, en otro caso se evalúa `<alternativa>` y se devuelve su valor. Otro apunte es que en `if` no se puede usar una secuencia de expresiones, mientras que en `cond` sí.

Hay otros predicados primitivos (además de `<`, `>` y `=`) que nos permiten formar predicados:

- `and`

```scheme
(and <e1> .. <en>)
```

El intérprete evalúa las expresiones de izquierda a derecha. Si una expresión es falsa, el intérprete deja de evaluarlas, y `and` es falso. Si todas son valores verdaderos, el valor de `and` es el valor de la última expresión.

- `or`

```scheme
(or <e1> ... <en>)
```

El intérprete evalúa las expresiones de izquierda a derecha. Si una expresión se evalúa a un valor verdadero, ese será el valor de `or`, y el intérprete deja de evaluar el resto de expresiones. Si todas son valores falsos, el valor de `or` es falso.

- `not`

```scheme
(not <e>)
```
El valor de `not` es verdadero cuando `<e>` es evaluado a falso, y es falso en otro caso.

#### Ejercicios
##### Ejercicio 1.1

```scheme
10 ; -> 10

(+ 5 3 4) ; -> 12

(- 9 1) ; -> 8

(/ 6 2) ; -> 3

(+ (* 2 4) (- 4 6)) -> 6

(define a 3) -> a

(define b (+ a 1)) ; -> b

(+ a b (* a b)) ; -> 19

(= a b) ; -> #f

(if (and (> b a) (< b (* a b))) ; -> 4
    b
    a)

(cond ((= a 4) 6) ; -> 16
      ((= b 4) (+ 6 7 a))
      (else 25))

(+ 2 (if (> b a) b a)) ; -> 6

(* (cond ((> a b) a) ; -> 16
         ((< a b) b)
         (else -1))
   (+ a 1))
```

##### Ejercicio 1.2

```scheme
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))
```

##### Ejercicio 1.3

```scheme
(define (proc a b c)
    (case ((and (< a b) (< a c)) (+ (* b b) (* c c)))
          ((and (< b a) (< b c)) (+ (* a a) (* c c)))
          (else (+ (* a a) (* b b)))))
```

**CORRECCIÓN**

```scheme
(define (proc a b c)
    (case ((and (<= a b) (<= a c)) (+ (* b b) (* c c)))
          ((and (<= b a) (<= b c)) (+ (* a a) (* c c)))
          (else (+ (* a a) (* b b)))))
```

##### Ejercicio 1.4
Depende del valor de `b`: se efectuará una suma entre `a` y `b` si `b` es mayor a `0`, y una resta en otro caso.

##### Ejercicio 1.5
Cuando el intérprete usa el orden aplicativo, al evaluar `(test 0 (p))`, antes de aplicar el procedimiento `test` evaluará sus argumentos. Al estar `p` definido como `(define (p) (p))`, la evaluación de `(p)` se convierte en un bucle infinito. Si en cambio usa el orden normal, se evaluará `test` primero, resultando en `(if (= 0 0) 0 (p))`. Como `if` es una forma especial primitiva, se procede a evaluar el `if`. Como la condición es cierta, devuelve `0`, y `(p)` no se evalúa.

#### Ejemplo: Raíces Cuadradas por el Método de Newton
En matemáticas nos preocupamos más por las descripciones declaraticas (qué es), mientras que en las ciencias de la computación nos preocupamos más por las descripciones imperativas (cómo).

##### Ejercicio 1.6
Lo que pasará es lo siguiente (suponiendo que el intérprete que usa Alyssa utiliza el orden aplicativo para resolver los procedimientos): el `if`, como es una forma especial, no se evalúa como un procedimiento, en cambio el `new-if` sí. El `new-if`, como cualquier otro procedimiento, evalúa primero sus argumentos. En este caso, al evaluar el segundo, al haber una llamada recursiva al mismo procedimiento, se va a evaluar de nuevo un nuevo `new-if`, y seguirá así en un bucle infinito, ya que en el `new-if`**siempre** se evalúan las dos condiciones.

##### Ejercicio 1.7

```scheme
(define (good-enough? guess x)
    (< (abs (- (improve guess x) guess)) 0.000001))
```

**CORRECCIÓN (aunque es pasable)**

```scheme
(define (good-enough? guess previous-guess)
   (< (abs (- guess previous-guess))
0.001))
```

```scheme
(define (sqrt-iter guess previous-guess x)
   (if (good-enough? guess previous-guess)
       guess
       (sqrt-iter (improve guess x)
                  guess
                  x)))
```

Parece más preciso con números grandes que pequeños

##### Ejercicio 1.8

```scheme
(define (improve guess x)
    (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))
```

#### Procedimientos como Abstracciones de Caja Negra

Obsérvese que el problema de calcular raíces cuadradas se divide en un determinado número de subproblemas, que es realizado por un procedimiento separado. La importancia de esto es que cada procedimiento se dedique a una tarea identificable que pueda ser usada como un módulo en la definición de otro procedimientos. Es decir, una definición de un procedimiento debe permitir suprimir detalles, que carecen de importancia para usarlo.

Solamente la función `sqrt` es importante para los usuarios. El problema reside en que el resto de las funciones que este procedimiento están abiertas para el usuario. La solución es ocultarlos en `sqrt`:

```scheme
(define (sqrt x)
    (define (good-enough? guess x)
        (< (abs (- (square guess) x)) 0.001))
    (define (improve guess x) (average guess (/ x guess)))
    (define (sqrt-iter guess x)
        (if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x)))
    (sqrt-iter 1.0 x))
```

Hay una mejora que consiste en fijarnos que todos los procedimientos dentro de `sqrt` están en el alcance de `x`, por lo que podemos tratar `x` como una variable libre (que no está en sus argumentos) y no pasarla como argumento.

```scheme
(define (sqrt x)
    (define (good-enough? guess)
        (< (abs (- (square guess) x)) 0.001))
    (define (improve guess) (average guess (/ x guess)))
    (define (sqrt-iter guess)
        (if (good-enough? guess)
            guess
            (sqrt-iter (improve guess))))
    (sqrt-iter 1.0 x))
```

Hay que tener en cuenta que las definiciones de procedimientos embebidas deben de estar primero en el cuerpo del procedimiento que las contiene.

### Procedimientos y los Procesos que Generan
Para saber programar de verdad no basta con conocer los elementos de la programación, hay que saber las que métodos son mejores en cada caso y sus consecuencias. En este apartado examinaremos algunos patrones comunes de procesos generados por procedimientos.

#### Recursion lineal e Iteración
Empezaremos considerando la función factorial:

n! = n * (n - 1) * (n - 2) * ... * 3 * 2 * 1.

Podemos computar n! computando (n - 1)! y multiplicándolo por n. Si añadimos que 1! es igual a 1, el procedimiento resultante es:

```scheme
(define (factorial n)
    (if (= n 1)
        1
        (* n (factorial (- n 1)))))
```

Podemos realizar esto desde otra perspectiva: multiplicando 1 por 2, después por 3, así hasta llegar a n:

```scheme
(define (factorial n)
    (define iter product counter)
        (if (> counter n)
            product
            (iter (* counter product)
                  (+ counter 1))))
    (iter 1 1)
```

Debemos diferenciar la noción de *procedimiento recursivo* con la de *proceso recursivo*. Hablamos de cómo evoluciona el proceso, no sobre la sintaxis de cómo está escrito el procedimiento. El segundo proceso no es recursivo, porque cuando en `iter` se devuelve otra llamada a iter, el estado del `iter` anterior no es necesario almacenarlo, y se descarta (a diferencia de otros lenguajes de programación, en el que eso haría que se consumiese más memoria realizando las llamadas).

##### Ejercicio 1.9

```scheme
;; Procedimiento 1
(+ 4 5)
(if (= 4 0) 5 (inc (+ (dec 4) 5)))
(inc (+ (dec 4) 5))
(inc (+ 3 5))
(inc (if (= 3 0) 5 (inc (+ (dec 3) 5))))
(inc (inc (+ (dec 3) 5)))
(inc (inc (+ 2 5)))
(inc (inc (if (= 2 0) 5 (inc (+ (dec 2) 5)))))
(inc (inc (inc (+ (dec 2) 5))))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (if (= 1 0) 5 (inc (+ (dec 1) 5))))))
(inc (inc (inc (inc (+ (dec 1) 5)))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc (if (= 0 0) 5 (inc (+ dec 0) 5))))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9

;; Procedimiento 2
(+ 4 5)
(if (= 4 0) 5 (+ (dec 4) (inc 5)))
(+ (dec 4) (inc 5))
(+ 3 6)
(if (= 3 0) 6 (+ (dec 3) (inc 6)))
(+ (dec 4) (inc 5))
(+ 2 7)
(if (= 2 0) 7 (+ (dec 2) (inc 7)))
(+ (dec 4) (inc 5))
(+ 1 8)
(if (= 1 0) 8 (+ (dec 1) (inc 8)))
(+ (dec 4) (inc 5))
(+ 0 9)
(if (= 0 0) 9 (+ (dec 0) (inc 9)))
9
```

El procedimiento 1 es recursivo y el 2 es iterativo.

##### Ejercicio 1.10
```scheme
;; 1
(A 1 10)
(A 0 (A 1 9))
(A 0 (A 0 (A 1 8)))
...

1024
```
1 - 1024
2 - 65536
3 - 65536

f(x): x * 2
g(x): x ^ 2
h(x): 2 ^ 2 ^ 2 ...

**SOLUCION**
h(x): 2 ^ (2 ^ (2 ^ ...))

#### Recursión en Árbol
La recursión en árbol implica una doble llamada (o más) al mismo procedimiento. Por ejemplo, en una función de Fibonacci, el número de pasos requeridos crece exponencialmente según la entrada, pero la memoria requerida crece solo linealmente.

##### Ejercicio 1.11
El procedimiento recursivo sería:

```scheme
(define (f n)
        (cond ((< n 3) n)
              (else (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))
```

Para el iterativo hay que pensar un poco. Al final resulta en:

```scheme
(define (ff-iter a b c count x)
  (if (> count x)
      a
      (ff-iter (+ a (* 2 b) (* 3 c )) a b (+ 1 count) x)))

(define (ff n)
         (if (< n 3)
             n
             (ff-iter 2 1 0 3 n)))
```

##### Ejercicio 1.12

```scheme
(define (pascal-triangle row index)
  (cond ((or (< index 1) (> index row)) 0)
        ((= row 1) 1)
        (else (+ (pascal-triangle (- row 1) (- index 1)) (pascal-triangle (- row 1) index)))))
```

##### Ejercicio 1.13
Como requiere de fórmulas matemáticas y no tiene mucho que ver con el tema del que trata el libro, mejor mirarlo en internet [aquí](http://wiki.drewhess.com/wiki/SICP_exercise_1.13).

#### Orden de crecimiento
Tomemos n como un parámetro que mide el tamaño del problema, y R(n) como la cantidad de recursos que el proceso requiere para un problema de tamaño n.

##### Ejercicio 1.14
**CORRECCIÓN**
O(n^5)

##### Ejercicio 1.15
Apartado a:

12.15 / 3 = 4.05
4.05 / 3 = 1.333...
1.333... / 3 = 0.444...
0.444... / 3 = 0.148148...
0.148148... / 3 ~= 0.0493
0.0493 < 0.1

Por cada división se aplica el procedimiento `p`, por lo que el procedimiento `p` se ejecuta 5 veces cuando `(sine 12.15)` es evaluado.

Apartado b:

Por exploración matemática he llegado a que:
Para dividir un número a por otro constante n hasta llegar al número deseado d o menos, el número de divisiones que hay que efectuar es de n√(a/d).
a -> O(3√a) (raíz cúbica)

**CORRECCION (solo apartado b)**

el número de pasos (divisiones se calcula así):
a/(3^n) < 0.1 -> ... -> log3(a/0.1) < n

Por lo que la relación es que por un número a se efectúan log3(a) pasos, y el orden es de O(log(n)).

#### Exponenciación
Una forma de calcular la potencia de un número es mediante un procedimiento recursivo:

```scheme
(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 2)))))
```

Podemos hacer uso de lo siguiente para crear un mejor procedimiento:

b^n = b^((n/2)^2), si n es par,
b^n = b * b^(n-1), si n es impar.

```scheme
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-exp b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))
```

El proceso que genera el procedimiento anterior evoluciona logarítmicamente con n en espacio y número de pasos.

##### Ejercicio 1.16

```scheme
(define (fastest-exp b n)
  (define (iter a b n)
    (cond ((= n 0) a)
          ((even? n) (iter a (* b b) (/ n 2)))
          (else (iter (* b a) b (- n 1)))))
  (iter 1 b n))
```

##### Ejercicio 1.17

```scheme
(define (mul f1 f2)
  (cond ((= f2 0) 0)
        ((even? f2) (mul (double f1) (halve f2)))
        (else (+ f1 (mul f1 (- f2 1))))))
```

##### Ejercicio 1.18

```scheme
(define (mul f1 f2)
  (define (iter a f1 f2)
    (cond ((= f2 0) a)
          ((even? f2) (iter a (double f1) (halve f2)))
          (else (iter (+ f1 a) f1 (- f2 1)))))
  (iter 0 f1 f2))
```

##### Ejercicio 1.19
Después de muchos cálculos, se concluye que:
q' = q * (2p + q)
p' = p^2 + q^2

##### Ejercicio 1.20

```scheme
; Evaluación de orden normal
(gcd 206 40)
(gcd 40 (remainder 206 40))
(if (= (remainder 206 40)) 40 (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
(if (= (remainder 40 (remainder 206 40)) 0) (remainder 206 40) (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) (remainder 40 (remainder 206 40)) ...)

; Evaluación de orden aplicativo
(gcd 206 40)
(if (= 40 0) 206 (gcd 40 (remainder 206 40))
(gcd 40 (remainder 206 40))
(gcd 40 6)
...

```

El número de veces que se llama a `remainder` es mucho mayor usando el orden normal que el aplicativo.

##### Ejercicio 1.21

```scheme
(smallest-divisor 199) ; -> 199
(smallest-divisor 1999) ; -> 1999
(smallest-divisor 19999) ; -> 7
```

##### Ejercicio 1.22

```scheme
(define (primes-range a b)
  (cond ((> a b))
        ((even? a) (primes-range (+ a 1) b))
        (else (timed-prime-test a) (primes-range (+ a 1) b))))

; Larger than 1000: 1009, 1013, 1019
; Larger than 10000: 10007, 10009, 10037
; Larger than 100000: 100003, 100019, 100043
; Larger than 1000000: 1000003, 1000033, 1000037
```

##### Ejercicio 1.23

```scheme
(define (next n)
       (if (= n 2) 3 (+ n 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
```


**CORRECCIÓN**
Es diferente de dos porque antes simplemente se incrementaba en 1 el divisor, y ahora se comprueba si es igual a 2 o no.

##### Ejercicio 1.24

```scheme
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))


(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (prime? n (- times 1)))
        (else false)))

(define (start-prime-test n start-time)
  (if (prime? n 3)
      (report-prime n (- (runtime) start-time))
      #f))

```

##### Ejercicio 1.25
Not for large numbers, it will be slower.

##### Ejercicio 1.26
When using `*` instead of `square`, the same argument is evaluated two times.

##### Ejercicio 1.27

```scheme
(define (fermat-test n)
  (define (test t)
    (cond ((>= t n) true)
          ((= (remainder (expt t n) n) t) (test (+ t 1)))
          (else false)))
  (test 2))
```

Carmichael numbers fool the Fermat test.

##### Ejercicio 1.28
(Demasiado difícil).
