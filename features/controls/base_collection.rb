class BaseCollection
  include Enumerable

  def [](index)
    @collection[index]
  end

  def each
    if block_given?
      @collection.each do |link|
        yield link
      end
    else
      to_enum(:each)
    end
  end

  def length
    @collection.count
  end

end