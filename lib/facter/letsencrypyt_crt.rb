
require 'facter'

crt_domains = Dir['/opt/letsencrypt/requests/*/*.crt'].map { |a| a.gsub(%r{\.crt$}, '').gsub(%r{^.*/}, '') }

Facter.add(:letsencrypt_crts) do
  setcode do
    crt_domains.join(',') if crt_domains
  end
end

Facter.add(:letsencrypt_crts_content) do
  setcode do
    crt = {}
    crt_domains.each do |crt_domain|
      crt[crt_domain] = File.read("/opt/letsencrypt/requests/#{crt_domain}/#{crt_domain}.crt")
    end
    crt
  end
end

Facter.add(:letsencrypt_crts_ocsp_content) do
  setcode do
    ocsp = {}
    crt_domains.each do |crt_domain|
      ocsp[crt_domain] = File.read("/opt/letsencrypt/requests/#{crt_domain}/#{crt_domain}.crt.ocsp")
    end
    ocsp
  end
end

Facter.add(:letsencrypt_crts_ca_content) do
  setcode do
    ca = {}
    crt_domains.each do |crt_domain|
      ca[crt_domain] = File.read("/opt/letsencrypt/requests/#{crt_domain}/#{crt_domain}_ca.pem")
    end
    ca
  end
end
