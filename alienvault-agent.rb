class AlienvaultAgent < Formula
  desc "AlienVault Agent"
  homepage "https://www.alienvault.com/"
  url "https://s3-us-west-2.amazonaws.com/ci-otxb-portal-osquery/repo/osx/alienvault-agent-1.0.1.tar.gz"
  sha256 "47d0c629ca0bc8547808a9c541543d06b54ad9e3128c38c63bdc12c90270899f"
  version "1.0.1"
  plist_options :startup => true

  bottle :unneeded

  def install
    bin.install "osqueryi"
    bin.install "osqueryd"
    bin.install "osqueryctl"
    bin.install "osqueryd-run.sh"
    (var/"osquery").mkpath
    (var/"osquery").install "osquery.flags.example"
    (var/"osquery/certs").mkpath
    (var/"osquery/certs").install "certs.pem"
    (var/"log/osquery").mkpath
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
        <string>/usr/local/bin/osqueryd-run.sh</string>
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
