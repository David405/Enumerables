# frozen_string_literal: true

module Enumerable
  def my_each
    for i in 0...self.length
      yield(self[i]) if block_given?
    end
end

  def my_each_with_index
    for i in 0...self.length
      yield(self[i], i) if block_given?
    end
end

  def my_select
    array = Array.new
    i = 0
    while i < size
      array << self[i] if yield(self[i])
      i += 1
    end

    return array
  end

  def my_all?
    if !block_given?
      my_each do |i|
        return false unless i
      end
    else
      my_each do |i|
        return false unless yield(i)
      end
      true
    end
  end

  def my_any?
    result = false
    if block_given?
      my_each do |i|
        result = true if yield(i)
      end
    else
      my_each do |i|
        result = true if i
      end
    end
    result
  end

  def my_none?(obj = nil)
    if obj
      my_each do |i|
        return false if i.class == obj
      end
    elsif block_given?
      my_each do |i|
        return false if yield(i)
      end
    else
      my_each do |i|
        return false if i
      end
    end
  end

  def my_count(obj = nil)
    count = 0
    if block_given?
      my_each do |i|
        count += 1 if yield(i)
      end
    elsif obj
      my_each do |i|
        count += 1 if i == obj
      end
    else
      count = self.length
    end

    count
  end

  def my_map(&block)
    arr = []
    my_each do |i|
      arr << block.call(i)
    end
    arr
  end

  def my_inject(obj = nil)
    accumulator = obj || shift

    my_each do |i|
      accumulator = yield(accumulator, i)
    end

    accumulator
  end
end