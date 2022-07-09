# Возвращает сумму от 0 до n в двоичной системе
# На вход получает масив на выход возвращает массив соответсвующих по индексу результатов
def first_task(arr)
  index = 0
  res = []
  arr.each do |elem|
    if elem.zero?
      res[index] = 0
    elsif elem.negative?
      raise('have elem less than 0')
    else
      res[index] = 2 ** (Math.log2(elem).to_i + 1) - 1
    end
    index += 1
  end
  res
end

# Удаляет символ # и предшествующий символ
def second_task(str)
  res_str = ''
  str.chars.each do |elem|
    if elem == '#'
      res_str = res_str[0..-2]
    else
      res_str << elem
    end
  end
  res_str
end

begin
  p first_task([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 16, 31, 32])
rescue Exception => e
  if e.message == 'have elem less than 0'
    p "message: #{e.message}, error: #{e.class.to_s}"
  else
    p "#{e.class.to_s} #{e.message} шо це таки?)"
  end
ensure
  p second_task('#a#sd#f#ghj#k##')
end
