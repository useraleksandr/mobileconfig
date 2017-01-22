#!/bin/bash

EMAIL="npv@koap.pro"

echo
echo "=== Requesting configuration data ==="
echo

read -p "VPN username: " VPNUSERNAME
VPNPASSWORD="11"
VPNPASSWORD2="2"
until ["$VPNPASSWORD"="$VPNPASSWORD2"]
do
  read -s -p "VPN password (no quotes, please): " VPNPASSWORD
  echo
  read -s -p "Confirm VPN password: " VPNPASSWORD2
  echo
done

echo
echo "=== Creating Apple .mobileconfig file ==="
echo

echo "<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE plist PUBLIC '-//Apple//DTD PLIST 1.0//EN' 'http://www.apple.com/DTDs/PropertyList-1.0.dtd'>
<plist version='1.0'>
<dict>
  <key>PayloadContent</key>
  <array>
    <dict>
      <key>IKEv2</key>
      <dict>
        <key>AuthenticationMethod</key>
        <string>None</string>
        <key>ChildSecurityAssociationParameters</key>
        <dict>
          <key>EncryptionAlgorithm</key>
          <string>AES-256-GCM</string>
          <key>IntegrityAlgorithm</key>
          <string>SHA2-384</string>
          <key>DiffieHellmanGroup</key>
          <integer>21</integer>
          <key>LifeTimeInMinutes</key>
          <integer>1440</integer>
        </dict>
        <key>DeadPeerDetectionRate</key>
        <string>Medium</string>
        <key>DisableMOBIKE</key>
        <integer>0</integer>
        <key>DisableRedirect</key>
        <integer>0</integer>
        <key>EnableCertificateRevocationCheck</key>
        <integer>0</integer>
        <key>EnablePFS</key>
        <true/>
        <key>ExtendedAuthEnabled</key>
        <true/>
        <key>IKESecurityAssociationParameters</key>
        <dict>
" > vpn.mobileconfig

echo 'Your IKEv2 VPN configuration profile for iOS and macOS is attached. Please double-click to install. You will need your device PIN or password, plus your VPN username and password.
' | mail -s "VPN configuration profile" -A vpn.mobileconfig $EMAIL
