class AlienvaultAgent < Formula
  desc "AlienVault Agent"
  homepage ""
  url "https://s3-us-west-2.amazonaws.com/ci-otxb-portal-osquery/repo/osx/alienvault-agent-1.0.1.tar.gz"
  sha256 "bcfb1609330749d612d57890a844eece90a74d093e66f77ec652447a7bd9df2a"
  version "1.0.1"
  plist_options :startup => true

  bottle :unneeded

  def install
    bin.install "osqueryi"
    bin.install "osqueryd"
    bin.install "osqueryctl"
    (etc/"osquery").mkpath
    (etc/"osquery").install "osquery.flags.example"
    (etc/"osquery/certs").mkpath
    (etc/"osquery/certs").install "certs.pem"
    (etc/"log/osquery").mkpath
  end

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Disabled</key>
      <false/>
      <key>Label</key>
      <string>com.facebook.osqueryd</string>
      <key>ProgramArguments</key>
      <array>
        <string>/usr/local/bin/osqueryd</string>
        <string>--flagfile=/private/var/osquery/osquery.flags</string>
        <string>--logger_min_stderr=1</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>ThrottleInterval</key>
      <integer>60</integer>
    </dict>
    </plist>
    EOS
  end
end
