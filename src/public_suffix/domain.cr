module PublicSuffix
  class Domain
    property suffix : String = ""
    property domain : String = ""
    property subdomain : String?

    # labels ordered from top to bottom, e.g. ["com", "google", "translate"]
    property labels = Array(String).new

    def initialize(str : String)
      raise DomainInvalid.new("Domain cannot be blank") if str.blank?

      # lean on URI::Parser for definition of valid host
      begin
        URI::Parser.new("//#{str}/").run
      rescue URI::Error
        raise DomainInvalid.new("URI::Parser raised URI::Error")
      end

      @labels = str.strip.downcase.split(".").reverse

      raise DomainInvalid.new("Domain contains one or more blank labels") if @labels.select(&.blank?).any?

      domain_level = 0 # which index of labels is the domain level
      prevailing_rule : Rule?

      # Match domain against all rules and take note of the matching ones.
      matches = PublicSuffix.find_matching_rules(for: self)

      # If no rules match, the prevailing rule is "*".
      if matches.empty?
        # nothing to do
      elsif matches.size == 1
        prevailing_rule = matches.first
      else
        # If more than one rule matches, the prevailing rule is the one which is an exception rule.
        if (rules = matches.select(&.exception)).any?
          prevailing_rule = rules.first

          # If the prevailing rule is a exception rule, modify it by removing the leftmost label.
          prevailing_rule.suffix.pop
        else
          # If there is no matching exception rule, the prevailing rule is the one with the most labels.
          prevailing_rule = matches.sort { |a, b| a.suffix.size + (a.wildcard ? 1 : 0) <=> b.suffix.size + (b.wildcard ? 1 : 0) }.last
        end
      end

      # The public suffix is the set of labels from the domain which match the labels of the prevailing rule, using the matching algorithm above.
      if (rule = prevailing_rule)
        domain_level = rule.suffix.size + (rule.wildcard ? 1 : 0)
        @suffix = labels[0...domain_level].reverse.join(".")
      end

      # The registered or registrable domain is the public suffix plus one additional label.
      raise DomainNotAllowed.new("Domain not allowed (is a suffix, one additional label required)") unless labels[domain_level]?
      @domain = labels[0..domain_level].reverse.join(".")
      @subdomain = @labels[domain_level + 1..-1].reverse.join(".") if @labels[domain_level + 1]?
    end

    def to_s
      @domain
    end
  end
end
