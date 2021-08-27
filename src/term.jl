
struct Term  #structs are immutable by default
    coeff::Int
    degree::Int
    function Term(coeff::Int, degree::Int)
        @assert degree ≥ 0
        coeff != 0 ? new(coeff,degree) : new(coeff,0)
    end
end

Base.show(io::IO, t::Term) = print(io, "$(t.coeff)⋅x^$(t.degree)")

#TODO:
#     def __str__(self) -> str:
#         (coeff, deg) = self.coeff, self.degree
#         sign = lambda x : "+" if x >= 0 else "-"
#         if not deg:
#             return sign(coeff) + str(abs(coeff))
#         elif deg == 1:
#             mono = "x"
#         else:
#             mono = "x^{}".format(deg)
#         return ''.join(map(str,[sign(coeff), abs(coeff) if coeff not in [1,-1] else "", mono]))



#QQQQ - Yoni Julia string rep??? 
#     def __repr__(self) -> str:
#         return str([self.coeff, self.degree])


Base.iszero(t::Term) = iszero(t.coeff)

import Base: +, -, *, %, ÷, isless

isless(t1::Term,t2::Term) =  t1.degree == t2.degree ? (t1.coeff < t2.coeff) : (t1.degree < t2.degree)  

function +(t1::Term,t2::Term)::Term
    @assert t1.degree == t2.degree
    Term(t1.coeff + t2.coeff, t1.degree)
end

-(t::Term) = Term(-t.coeff,t.degree) 
-(t1::Term,t2::Term)::Term = t1 + (-t2) 

*(t1::Term,t2::Term)::Term = Term(t1.coeff * t2.coeff, t1.degree + t2.degree)

%(t::Term,p::Int)::Term = Term(t.coeff % p, t.degree)

function ÷(t1::Term,t2::Term)#::QQQQ what is
    @assert t1.degree ≥ t2.degree #QQQQ rename inverse_mod to inverse later
    f(p::Int)::Term = Term((t1.coeff * inverse_mod(t2.coeff, p)) %p, t1.degree - t2.degree)
end

#QQQQ - maybe there is a better "julian" name for it.

evaluate(t::Term, x::T) where T <: Number = t.coeff * x^t.degree

#     def __floordiv__(self, other):
#         (coeff, deg) = self.coeff, self.degree
#         (doeff, eeg) = other.coeff, other.degree
#         if eeg > deg:
#             return None
#         return lambda p : Term(coeff*inverse(doeff, p) % p, deg-eeg)




# if __name__ == "__main__":
#     s = Term(16, 2)
#     t = Term(22, 3)

#     #f = Polynomial([s,t,Term(3,1),Term(7),Term(1,10),Term(-1,5)])
#     #g = Polynomial([s])

#     f = Polynomial([Term(1,1), Term(1,0)])
#     g = Polynomial([Term(1,1), Term(-1,0)])
#     h = f*g