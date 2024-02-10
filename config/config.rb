# Replace the 'config_from_url' string value below with your
# product environment's credentials, available from your Cloudinary console.
# =====================================================

require 'cloudinary'

Cloudinary.config_from_url("cloudinary://293282598713389:8Ep7TdV7Nv7oIyV3QUmHZfsMczY@djsk8cshz")
Cloudinary.config do |config|
  config.secure = true
end