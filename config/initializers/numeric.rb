class Numeric
  Alph = ("A".."Z").to_a
  def alph
    s, q = "", self
    (q, r = (q - 1).divmod(26)); s.prepend(Alph[r]) until q.zero?
    s
  end
end
