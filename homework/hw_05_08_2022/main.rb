require_relative 'square'
require_relative 'rectangle'
require_relative 'triangle'
require_relative 'circle'
require_relative 'custom_shape'
shapes = [Square.new(3), Rectangle.new(3, 2), Triangle.new(3, 2),
          Circle.new(3), CustomShape.new(7)]
puts shapes.sort{ |a, b| a.square <=> b.square }
# .map{|el| el.square} # для отображения значений можно добавить к предыдущей строке
