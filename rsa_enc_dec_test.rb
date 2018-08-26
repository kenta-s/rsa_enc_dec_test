# RSAによる暗号化/複合化のテストです。


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
