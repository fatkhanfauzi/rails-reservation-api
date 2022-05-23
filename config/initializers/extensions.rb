class Object
  def try_chain(*methods)
    values = [self]
    methods.each do |method|
      next if method.eql?(:to_a)

      if method.eql?(:join_unique_string)
        value = values.last.uniq.join(',')
      else
        value = values.last.try(:[], method) || values.last.try(:[], method.to_s) || values.last.try(:[], method)
      end

      return nil if value.nil?

      values << value
    end

    return [values.last].flatten if methods.last.eql?(:to_a)

    values.last
  rescue
    return nil
  end
end
