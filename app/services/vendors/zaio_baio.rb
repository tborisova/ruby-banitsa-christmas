module Vendors
  class ZaioBaio

    def parse(letter)
      presents =
        letter['Wishes'].map do |present|
          {
            wish: present['Wish'],
            new_for_this_year: present['NewForThisYear'],
          }
        end

      {
        child_name: letter['KidName'],
        presents: presents
        country: letter['Country'],
        city: letter['City'],
        address: letter['Address'],
        has_roof: letter['HasRoof'],
        child_id: letter['KidId']
      }
    end
  end
end
