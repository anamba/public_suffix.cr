module PublicSuffix
  LIST = parse_dat_file

  def self.embedded_dat_file
    {{ run("./read_list_file.cr").stringify }}
  end

  def self.parse_dat_file : Array(Rule)
    # time = Time.monotonic

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

    # puts "Parsed dat file in #{(Time.monotonic - time).milliseconds} ms"

    rules
  end

  # return all matching rules for domain
  def self.find_matching_rules(for domain : Domain)
    LIST.map { |rule| rule.dup if rule.match(domain) }.compact
  end
end
