# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/aws'                        # required
#   config.fog_credentials = {
#     provider:              'AWS',                        # required
#     aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],                        # required
#     aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],                        # required
#     region:                'eu-west-2',                  # optional, defaults to 'us-east-1'
#     # host:                  's3.example.com',             # optional, defaults to nil
#     endpoint:              'https://snacky-production.s3.eu-west-2.amazonaws.com' # optional, defaults to nil
#   }
#   config.fog_directory  = 'snacky-production'                          # required
#   config.fog_public     = true                                        # optional, defaults to true
#   config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
# end
