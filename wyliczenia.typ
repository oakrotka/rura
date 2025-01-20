#set text(lang: "pl")
#set par(justify: true)
#set page(numbering: "1")

#let sectionbreak = line(length: 100%, stroke: .5pt)
#let reasonbreak = line(length: 100%, stroke: (dash: "dotted", thickness: .8pt))
#let important(c) = $ #rect(inset: 8pt, stroke: (dash: "dotted", thickness: .8pt))[#c] $

Treść zagadnienia:
$
-k(x) (dif^2 u(x)) / (dif x^2) = 0 \
u(2) = 3 \
(dif u(0)) / (dif x) + u(0) = 20 \
k(x) = cases(1\, space.quad &x in [0,1], 2\, space.quad &x in (1,2])
$
Szukana jest funkcja
$ [0,2] in.rev x -> u(x) in RR $

#sectionbreak
Przekształcamy nasze równanie do postaci
$ -(alpha u')' + beta u' + gamma u = f $
#reasonbreak
$ cases(beta = 0, gamma = 0, f = 0) $
// #reasonbreak
$
-(alpha u')' = -k u'' \
alpha' u' + alpha u'' = k u'' \
k' = 0 space => space alpha = k
$
#reasonbreak
$ -(k u')' = 0 $

#sectionbreak
Znajdujemy $B(u,v)$ i $L(v)$, gdzie $v$ to funkcja testowa
$
-(k u')' v &= 0 \
-integral^2_0 (k u')' v dif x &= 0
$
$
-integral^2_0 (k u')' v dif x &= -[k u' v]^2_0 + integral^2_0 k u' v' dif x \
&= -k(2)u'(2)v(2) + k(0)u'(0)v(0) + integral^2_0 k u' v' dif x \
&= space *
$
#reasonbreak 
W $x=2$ mamy warunek Dirichleta, więc dla funkcji testowej $v$ zakładamy w nim
$ v(2) = 0 space => space -k(2)u'(2)v(2) = 0 $
#reasonbreak 
W $x=0$ mamy warunek Cauchy'ego, więc obliczamy dla niego
$
1 dot u'(0) + u(0) &= 20 \
k(0) dot u'(0) + u(0) &= 20 \
k(0)u'(0)v(0) + u(0)v(0) &= 20v(0) \
k(0)u'(0)v(0) &= 20v(0) - u(0)v(0)
$
#reasonbreak 
Podstawiamy wyrażenia otrzymane z warunków granicznych do równania obliczonego wcześniej
$ * space = space 0 + 20v(0) - u(0)v(0) + integral^2_0 k u' v' dif x $
$
20v(0) - u(0)v(0) + integral^2_0 k u' v' dif x &= 0 \
-u(0)v(0) + integral^2_0 k u' v' dif x &= -20v(0)
$
#important[$
B(u,v) &= -u(0)v(0) + integral^2_0 k u' v' dif x \
L(v) &= -20 v(0) \ \
$]
$ B(u,v) = L(v) $

#sectionbreak
Robimy shift zgodnie z początkowym warunkiem Dirichleta
#let ushift = $tilde(u)$
$ ushift(2) = 3 space => space ushift(x) = 3 $
$ w = u - ushift $
$ B(w,v) = B(u,v) - B(ushift,v) $
$ B(w,v) = L(v) - B(ushift,v) $

#sectionbreak 
Definiujemy ciąg funkcji bazowych
$ e_k (x) = max{0, space 1 - abs(x/h - k)} space.quad x in [0,2], space k in {0,1,...,n} $
Ciąg funkcji testowych będzie równy ciągowi funkcji bazowych 
$ v_i = e_i $
Definiujemy również funkcję $w$ jako sumę iloczynów funkcji bazowych i ich wag
#let oursum = $limits(sum)_(i=0)^n$
$ w(x) = oursum w_i dot e_i (x) $
gdzie $w_n=0$ z warunku Dirichleta, a reszta $w_i$ jest szukana. 
#reasonbreak 
Podstawiamy równanie na $w(x)$ zdefiniowane wyżej do naszego równania
$ B(w,v) = B(oursum w_i e_i, v) = oursum w_i B(e_i, v) $
#important[
  $ oursum w_i B(e_i,v) = L(v) - B(ushift, v) $
]

#sectionbreak
Dla czytelności zapisu następnych obliczeń definiuję funkcję
$
g(e_i,e_j) = integral^2_0 k dot e'_i dot e'_j dif x
$
Dla optymalizacji obliczeń dokonanych przez komputer
rozpiszę tutaj wyrazy głównego równania na przypadki.
$
B(e_i,e_j) = cases(
  g(e_i,e_j) - 1\, space.quad &(i,j) = (0,0),
  g(e_i,e_j)\, space.quad &abs(i-j) <=1 and (i,j) != (0,0),
  0\, space.quad &abs(i-j) > 1
)
$
Jako że $ushift'=0$ całka w $B(ushift,v)$ się zeruje, więc stąd mamy
$
L(e_i) - B(ushift,e_i) = cases(-17\, space.quad &i = 0, 0\, space.quad &i in {1,2,...,n})
$

#sectionbreak 
Podstawiając każdą naszą funkcję testową, otrzymujemy układ równań
$
w_0 dot (g(e_0,e_0) - 1) + &w_1 dot g(e_1,e_0) &&&&= -17 \
w_0 dot g(e_0,e_1) + &w_1 dot g(e_1,e_1) &&+ w_2 dot g(e_2,e_1) &&= 0 \
w_1 dot g(e_1,e_2) + &w_2 dot g(e_2,e_2) &&+ w_3 dot g(e_3,e_2) &&= 0 \
&&&&&dots.v \
w_(n-3) dot g(e_(n-3),e_(n-2)) + &w_(n-2) dot g(e_(n-2),e_(n-2)) 
&&+ w_(n-1) dot g(e_(n-1),e_(n-2)) &&= 0 \
&w_(n-2) dot g(e_(n-2),e_(n-1)) &&+ w_(n-1) dot g(e_(n-1),e_(n-1)) &&= 0 \
$
który (czytelniej) zapisujemy jako macierz trójdiagonalną
$
mat(delim: "[",
  g(e_0,e_0)-1, g(e_1,e_0), 0, dots.c, 0,0,0;
  g(e_0,e_1), g(e_1,e_1), g(e_2,e_1), dots.c, 0,0,0;
  dots.v, dots.v, dots.v, dots.down, dots.v, dots.v, dots.v;
  0,0,0, dots.c, g(e_(n-3),e_(n-2)), g(e_(n-2),e_(n-2)), g(e_(n-1),e_(n-2));
  0,0,0, dots.c, 0, g(e_(n-2),e_(n-1)), g(e_(n-1),e_(n-1))
) mat(delim: "[",
  w_0; w_1; dots.v; w_(n-2); w_(n-1)
) = mat(delim: "[",
  -17; 0; dots.v; 0; 0
)
$
Z tego jesteśmy w końcu w stanie obliczyć nasze wagi $w_i$ i uzyskać funkcję $u=w+ushift$.

