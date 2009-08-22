require 'geokit'
require 'geoip'

module Geokit
  module Geocoders

    # Should be overriden as Geokit::Geocoders::external_key in your configuration file
    @@geo_ip_database = 'REPLACE_WITH_GEOCITY_LOCATION'
    __define_accessors

    class GeoIpGeocoder < Geocoder
      private
      def self.db
        @@db ||= GeoIP.new(Geocoders.geo_ip_database)  
      end
      
      def self.do_geocode(address, options = {})
        ip, ip2, country_code, country_code2, country, continent, region, city, postal, latitude, longitude, usa = db.city(address)
        
        res = GeoLoc.new
        res.city = city
        res.country_code = country_code
        res.zip = postal
        res.lat = latitude
        res.lng = longitude
        res.success = !!(longitude && latitude)
        res
      end
    end

  end
end