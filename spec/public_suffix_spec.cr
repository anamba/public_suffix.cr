require "./spec_helper"

describe PublicSuffix do
  context "domain" do
    it "parses domain from a given string containing a valid hostname" do
      PublicSuffix.domain("example.com").to_s.should eq "example.com"
      PublicSuffix.domain("example.com").subdomain.should be_nil
      PublicSuffix.domain("foo.example.com").to_s.should eq "example.com"
      PublicSuffix.domain("foo.example.com").subdomain.should eq "foo"

      PublicSuffix.domain("verybritish.co.uk").to_s.should eq "verybritish.co.uk"
      PublicSuffix.domain("foo.verybritish.co.uk").to_s.should eq "verybritish.co.uk"

      PublicSuffix.domain("parliament.uk").to_s.should eq "parliament.uk"
      PublicSuffix.domain("foo.parliament.uk").to_s.should eq "parliament.uk"
    end

    it "raises on invalid hostname" do
      expect_raises(PublicSuffix::DomainNotAllowed) { PublicSuffix.domain("nic.bd") }
      expect_raises(PublicSuffix::DomainInvalid) { PublicSuffix.domain("") }
      expect_raises(PublicSuffix::DomainInvalid) { PublicSuffix.domain("www. .com") }
      expect_raises(PublicSuffix::DomainInvalid) { PublicSuffix.domain("foo.co..uk") }

      # TODO
      # expect_raises(PublicSuffix::DomainInvalid) { PublicSuffix.domain("goo,gle.com") }
      # expect_raises(PublicSuffix::DomainInvalid) { PublicSuffix.domain("google-.com") }
    end
  end
end
