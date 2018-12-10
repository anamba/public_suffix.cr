module PublicSuffix
  class Rule
    property suffix : Array(String)
    property wildcard : Bool
    property exception : Bool

    def initialize(@suffix, @wildcard = false, @exception = false)
    end

    def match(domain : Domain)
      # can only operate on domain.labels, as nothing else is guaranteed to be there
      domain.labels.size.times do |i|
        if wildcard
          if suffix == domain.labels[0..i] && i + 1 <= domain.labels.size
            return true
          end
        else
          if suffix == domain.labels[0..i]
            return true
          end
        end
      end

      false
    end
  end
end
