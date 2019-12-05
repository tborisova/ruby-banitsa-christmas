module Vendors
  class Dodo

    def parse(letter)
      presents =
        letter['Letters.Santa.Presents'].map do |present|
          {
            wish: present['Wish'],
            new_for_this_year: present['NewForThisYear'],
          }
        end

      {
        child_name: letter['Letters.Santa.ChildName'],
        presents: presents
        country: letter['Letters.Santa.Country'],
        city: letter['Letters.Santa.City'],
        address: letter['Letters.Santa.Address'],
        has_roof: letter['Letters.Santa.HasRoof'],
        child_id: ['Letters.Santa.ChildId']
      }
    end
  end
end
