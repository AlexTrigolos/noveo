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

def first_task_with_reduce(arr)
  index = 0
  res = []
  arr.each do |elem|
    if elem.zero?
      res[index] = 0
    elsif elem.negative?
      raise('have elem less than 0')
    else
      res[index] = (0..elem).reduce(:|)
    end
    index += 1
  end
  res
end

# Удаляет символ # и предшествующий символ
def second_task(str)
  res_str = ''
  str.chars.each do |elem|
    elem == '#' ? res_str.chop! : res_str << elem
  end
  res_str
end

require 'benchmark'

begin
  p (Benchmark.measure { first_task(0..10000) }).real
  p (Benchmark.measure { first_task_with_reduce(0..10000) }).real
  p (Benchmark.measure { 2 ** (Math.log2(100000).to_i + 1) - 1 }).real
  p (Benchmark.measure { (0..100000).reduce(:|) }).real
rescue Exception => e
  if e.message == 'have elem less than 0'
    p "message: #{e.message}, error: #{e.class.to_s}"
  else
    p "#{e.class.to_s} #{e.message} шо це таки?)"
  end
ensure
  p second_task('#a#sd#f#ghj#k##')
end
