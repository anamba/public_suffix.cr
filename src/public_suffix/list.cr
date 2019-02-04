module PublicSuffix
  LIST = parse_dat_file

  def self.parse_dat_file : Array(Rule)
    # start_time = Time.monotonic

    embedded_dat_file = {{ read_file(__DIR__ + "/../../public_suffix_list.dat") }}

    rules = Array(Rule).new
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

      rules << Rule.new(str.split(".").reverse, wildcard, exception)
    end

    # puts "Parsed dat file in #{(Time.monotonic - start_time).milliseconds} ms"

    rules
  end

  # return all matching rules for domain
  def self.find_matching_rules(for domain : Domain)
    LIST.map { |rule| rule.dup if rule.match(domain) }.compact
  end
end
