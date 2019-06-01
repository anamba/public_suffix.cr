module PublicSuffix
  RULES = parse_dat_file

  def self.parse_dat_file : Hash(String, Array(Rule))
    # start_time = Time.monotonic

    embedded_dat_file = {{ read_file(__DIR__ + "/../../public_suffix_list.dat") }}

    rules = Hash(String, Array(Rule)).new

    embedded_dat_file.each_line do |str|
      str = str.gsub(/\s|(?:\/\/).*?$/, "")
      next if str.blank?

      wildcard = false
      exception = false
      if str =~ /^!(.*?)$/
        str = $1
        exception = true
      end
      if str =~ /^\*\.(.*?)$/
        str = $1
        wildcard = true
      end

      labels = str.split(".").reverse

      rules_for_key = rules.fetch(labels[0], Array(Rule).new)
      rules_for_key.push(Rule.new(labels, wildcard, exception))
      rules[labels[0]] = rules_for_key
    end

    # puts "Parsed dat file in #{(Time.monotonic - start_time).milliseconds} ms"
    rules
  end

  # return all matching rules for domain
  def self.find_matching_rules(for domain : Domain)
    rules = RULES.fetch(domain.labels[0], [] of Rule)
    rules.map { |rule| rule.dup if rule.match(domain) }.compact
  end
end
