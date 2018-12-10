module PublicSuffix
  LIST = parse_dat_file

  def self.parse_dat_file : Array(Rule)
    # time = Time.monotonic

    rules = Array(Rule).new
    File.open(__DIR__ + "/../../public_suffix_list.dat") do |f|
      while (str = f.gets)
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
    end

    # puts "Parsed dat file in #{(Time.monotonic - time).milliseconds} ms"

    rules
  end

  # return all matching rules for domain
  def self.find_matching_rules(for domain : Domain)
    LIST.map { |rule| rule.dup if rule.match(domain) }.compact
  end
end
