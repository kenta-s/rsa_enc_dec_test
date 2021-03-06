#############################################
#
# RSAによる暗号化/複合化のテストです。
#
# 暗号文 = 平文^E mod N
# 平文 = 暗号文^D mod N
# 
# 公開鍵 = EとNの組
# 秘密鍵 = DとNの組
#
### N, E, Dの求め方
#
#### Nの求め方
#
# N = p * q 
# p, qは素数で、Nは暗号化する平文より大きな数になる必要があります
#
#### Lの求め方
#
# EとDを求める際に必要になる数、Lを求めます。
#
# L = p - 1, q - 1 の最小公倍数
#
#### Eの求め方
#
# Lとの最大公約数が1になる数で
# 1 < E < L を満たす必要があります
#
#### Dの求め方
#
# 1 < D < L
# E * D mod L = 1
#
# を満たす数Dを求めます。
#
#############################################


# ここでは平文に828365という数字を使ってみます
plain_text = 828365


# Nを求める。
# 対象となる平文828365より大きな数である必要があります。
p = 661 # 適当な素数
q = 1381 # 適当な素数

n = p * q
#=> 912841


# Lを求める。
# Rubyにlcmというメソッドが用意されていたのでこれを使います。
def lcm(a, b)
    a.lcm(b)
end

l = lcm(p - 1, q - 1)
#=> 15180


# Eを求める。
# Rubyにgcdというメソッドが用意されていたのでこれを使います。
# [2, 3, .., 15179]という配列を用意してプログラムで探しました。
# 条件を満たしていればどれでもいいんですが、真ん中あたりの値を選びました。

def gcd(a, b)
    a.gcd(b)
end

e = 541
gcd(l, e)
#=> 1


# Dを求める。
# こちらもループを書いて探しました。
d = 9961
e * d % l
#=> 1


# 暗号化
cipher_text = plain_text ** e % n
#=> 146223


# 複合化
cipher_text ** d % n
#=> 828365

(cipher_text ** d % n) == plain_text
#=> true
